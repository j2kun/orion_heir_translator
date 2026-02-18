"""
Halo frontend for the HEIR translator.

This module provides Halo-specific functionality for extracting operations
and scheme parameters from Halo FHE computations.
"""

from typing import List, Any, Dict, Optional, Union
from pathlib import Path
import yaml

from src.orion_heir.core.types import FHEOperation, FrontendInterface, SchemeParameters
from src.orion_heir.frontends.halo.primes import generatePrimeCandidate, probablyPrime, nearestPowerOfTwo
from src.orion_heir.frontends.halo.scheme_parameters import HaloSchemeParameters

from src.orion_heir.dialects.halo import Halo, PolyType
from src.orion_heir.dialects.ckks import CKKS
from src.orion_heir.dialects.lwe import LWE
from xdsl.dialects.arith import ConstantOp
from xdsl.dialects.builtin import DenseArrayBase, i32
from src.orion_heir.dialects.ckks import (
    AddOp,
    AddPlainOp,
    MulOp,
    MulPlainOp,
    RelinearizeOp,
    RescaleOp,
    RotateOp,
    SubOp,
    LevelReduce,
    NegateOp,
    BootstrapOp,
)

from src.orion_heir.dialects.polynomial import Polynomial
from src.orion_heir.dialects.mod_arith import ModArith
from src.orion_heir.dialects.rns import RNS
from src.orion_heir.dialects.mgmt import MGMT

from src.orion_heir.core.type_builder import TypeBuilder

from xdsl.ir import SSAValue, Block, Region
from xdsl.builder import Builder
from xdsl.rewriter import InsertPoint
from xdsl.dialects.func import FuncOp, ReturnOp
from xdsl.dialects.tensor import EmptyOp

from xdsl.dialects.builtin import (
    IntegerType,
    FunctionType,
    IntegerAttr,
)
from xdsl.dialects import arith, builtin, scf, func
from xdsl.dialects.builtin import TensorType


class HaloFrontend(object):
    """
    Frontend for translating Halo FHE operations to HEIR.

    This class implements the FrontendInterface for Halo,
    providing Halo-specific logic for operation extraction
    and parameter handling.
    """

    def __init__(self):
        """Initialize the Halo frontend with supported operations."""
        self._op_translators = {
            "tensor.empty": self._translate_tensor_empty,
            "ckks.addcc": self._translate_addcc,
            "ckks.addcp": self._translate_addcp,
            "ckks.mulcc": self._translate_mulcc,
            "ckks.mulcp": self._translate_mulcp,
            "ckks.negatec": self._translate_negatec,
            "ckks.rotatec": self._translate_rotatec,
            "ckks.modswitchc": self._translate_modswitchc,
            "ckks.rescalec": self._translate_rescalec,
            "ckks.bootstrapc": self._translate_bootstrapc,
            "ckks.encode": self._translate_encode,
            "func.return": self._translate_func_return,
        }

        self.params = None
        self.type_builder = None
        self.value_map = dict()

    def _translate_tensor_empty(self, op: Any):
        # mostly always pass through since its use will be a destination tensor
        return

    def _translate_modswitchc(self, op: Any):
        assert op.src in self.value_map
        input = self.value_map[op.src]
        down_factor = op.downFactor.value.data
        input_level = input.type.parameters[
            4].current.value.data  # current modulus chain value
        new_level = input_level - down_factor
        scale = self.type_builder.get_scaling_factor(input.type)
        output_new_level = self.type_builder.create_ciphertext_type_with_updated_level(
            input.type, new_level)
        output_correct_scale = self.type_builder.create_ciphertext_type_with_updated_scale(
            output_new_level, scale)
        reduce_op = LevelReduce(
            operands=[input],
            result_types=[output_correct_scale],
            properties={
                "levelToDrop": IntegerAttr(down_factor, IntegerType(64))
            },
        )
        self.value_map[op.result] = reduce_op.result
        return [reduce_op]

    def _translate_rescalec(self, op: Any):
        assert op.src in self.value_map
        input = self.value_map[op.src]
        input_scale = self.type_builder.get_scaling_factor(input.type)
        rescale_amount = self.params.logScale
        new_scale = input_scale - rescale_amount
        output_ty = self.type_builder.create_rescaled_type(
            input.type, new_scale)
        to_ring = output_ty.ciphertext_space.ring
        rescale_op = RescaleOp(
            operands=[input],
            result_types=[output_ty],
            properties={"to_ring": to_ring},
        )
        self.value_map[op.result] = rescale_op.result
        return [rescale_op]

    def _translate_bootstrapc(self, op: Any):
        # TODO: clean up the output type
        assert op.src in self.value_map
        input = self.value_map[op.src]
        # Since we need to add moduli, we need to create the full chain again.
        new_ty = self.translate_type(op.result.type)
        # Then update the scale to be reset
        output_ty = self.type_builder.create_ciphertext_type_with_updated_scale(
            new_ty, self.params.logScale)
        boostrap = BootstrapOp(
            operands=[self.value_map[op.src]],
            result_types=[output_ty],
            properties={
                "level": IntegerAttr(op.level.value.data, IntegerType(64))
            },
        )
        self.value_map[op.result] = boostrap.result
        return [boostrap]

    def _translate_mulcp(self, op: Any):
        assert op.lhs in self.value_map
        assert op.rhs in self.value_map
        lhs = self.value_map[op.lhs]
        rhs = self.value_map[op.rhs]
        output_ty = self.type_builder.infer_result_type(
            "mul_plain", lhs.type, rhs.type)
        mul_plain = MulPlainOp(
            operands=[lhs, rhs],
            result_types=[output_ty],
        )
        self.value_map[op.result] = mul_plain.result
        return [mul_plain]

    def _translate_addcp(self, op: Any):
        assert op.lhs in self.value_map
        assert op.rhs in self.value_map
        lhs = self.value_map[op.lhs]
        mul_plain = AddPlainOp(
            operands=[lhs, self.value_map[op.rhs]],
            result_types=[lhs.type],
        )
        self.value_map[op.result] = mul_plain.result
        return [mul_plain]

    def _translate_negatec(self, op: Any):
        assert op.src in self.value_map
        input = self.value_map[op.src]
        negate_op = NegateOp(
            operands=[input],
            result_types=[input.type],
        )
        self.value_map[op.result] = negate_op.result
        return [negate_op]

    def _translate_mulcc(self, op: Any):
        # Halo assumes relin happens after every mul
        lhs = self.value_map[op.lhs]
        rhs = self.value_map[op.rhs]
        mul_result = self.type_builder.infer_result_type(
            "mul", lhs.type, rhs.type)
        mulop = MulOp(
            operands=[lhs, rhs],
            result_types=[mul_result],
        )
        relintype = self.type_builder.create_relinearized_ciphertext_type(
            mulop.result.type)
        relinop = RelinearizeOp(
            operands=[mulop.result],
            result_types=[relintype],
            properties={
                "from_basis": DenseArrayBase.from_list(i32, [0, 1, 2]),
                "to_basis": DenseArrayBase.from_list(i32, [0, 1]),
            },
        )
        self.value_map[op.result] = relinop.result
        return [mulop, relinop]

    def _translate_addcc(self, op: Any):
        assert op.lhs in self.value_map
        assert op.rhs in self.value_map
        lhs = self.value_map[op.lhs]
        rhs = self.value_map[op.rhs]
        output_ty = self.type_builder.infer_result_type(
            "add", lhs.type, rhs.type)
        add_op = AddOp(
            operands=[self.value_map[op.lhs], self.value_map[op.rhs]],
            result_types=[output_ty],
        )
        self.value_map[op.result] = add_op.result
        return [add_op]

    def _translate_rotatec(self, op: Any) -> FHEOperation:
        """Translate a halo.rotatec operation."""
        offset = op.offset.get_values()[0]
        assert op.src in self.value_map
        input = self.value_map[op.src]
        negate_op = RotateOp(
            operands=[input],
            result_types=[input.type],
            properties={"offset": IntegerAttr(offset, IntegerType(32))},
        )
        self.value_map[op.result] = negate_op.result
        return [negate_op]

    def _translate_encode(self, op: Any) -> FHEOperation:
        """Translate a halo.encode operation."""
        # Note: it doesn't encode anything except a tensor.empty
        # Create tensor type with slot count shape
        from xdsl.dialects.builtin import TensorType, f64, DenseIntOrFPElementsAttr

        tensor_type = TensorType(f64, [self.params.slots])

        # Create constant operation
        dense_attr = DenseIntOrFPElementsAttr.from_list(tensor_type, [0])
        const_op = ConstantOp(dense_attr, tensor_type)
        # Take the level and scale of the ckks.encode operation
        scale = op.scale.value.data
        encode_op = self.type_builder.create_plaintext_encoding(
            const_op.result, scale)
        self.value_map[op.result] = encode_op.results[0]
        return [const_op, encode_op]

    def _translate_func(self, op: Any):
        # Setup function
        attrs = op.attributes
        func_ty = op.function_type

        arg_scales = attrs["arg_scale"].get_values()
        res_scales = attrs["res_scale"].get_values()

        inputs = [
            self.type_builder.create_ciphertext_type_with_updated_scale(
                self.translate_type(ty), scale)
            for ty, scale in zip(func_ty.inputs, arg_scales)
        ]
        outputs = [
            self.type_builder.create_ciphertext_type_with_updated_scale(
                self.translate_type(ty), scale)
            for ty, scale in zip(func_ty.outputs, res_scales)
        ]
        heir_func_type = FunctionType.from_lists(inputs, outputs)
        func = FuncOp(name=op.sym_name.data,
                      function_type=heir_func_type,
                      region=Region.DEFAULT)
        entry_block = func.body.blocks.first

        # Add block args to map
        for block_arg, heir_arg in zip(op.body.block.args,
                                       func.regions[0].block.args):
            self.value_map[block_arg] = heir_arg

        # Process operations one by one
        for body_op in op.body.blocks[0].ops:
            heir_op = self.translate_op(body_op)
            if not heir_op:
                continue
            for new_op in heir_op:
                entry_block.add_op(new_op)

        # While we know the result scales from the result attribute, we may need to update the result level.
        func.update_function_type()
        return func

    def _translate_func_return(self, op: Any):
        ret = ReturnOp(*[self.value_map[inp] for inp in op.operands])
        return [ret]

    def translate_op(self, op: Any):
        if op.name not in self._op_translators:
            raise ValueError("unsupported operation" + str(op.name))
        return self._op_translators[op.name](op)

    def translate_module(self, module: builtin.ModuleOp) -> builtin.ModuleOp:
        """
        Translate a Halo MLIR module to a HEIR MLIR module.
        """
        self.params = self._create_default_scheme()
        self.type_builder = TypeBuilder(self.params)
        attributes = self.type_builder.create_module_attributes()
        heir_module = builtin.ModuleOp([], attributes)
        block = heir_module.body.block
        for op in module.body.ops:
            if isinstance(op, FuncOp):
                block.add_op(self._translate_func(op))
        return heir_module

    def _create_default_scheme(self) -> HaloSchemeParameters:
        """Create scheme parameters for testing."""
        # Table 1 in DaCapo paper shows evaluations used logScale = 51
        logScale = 60
        waterline = 40
        maxLevel = 13
        return HaloSchemeParameters(
            logN=17,
            logQ=[logScale] * (maxLevel + 1),
            logP=[],
            logScale=logScale,  # input log scales
            slots=2**16,
            ring_degree=1 << 17,
            backend="halo",
            primes=self._generate_primes(maxLevel + 1, logScale),
            # Not sure how many auxiliary primes in general to include
            aux=self._generate_primes(2, logScale)
        )

    def _generate_primes(self, number: int, bit_size: int) -> List[int]:
        primes = set()
        while len(primes) < number:
            prime_candidate = generatePrimeCandidate(bit_size)
            while not (probablyPrime(prime_candidate)
                       and nearestPowerOfTwo(prime_candidate) == bit_size):
                prime_candidate = generatePrimeCandidate(bit_size)
            primes.add(prime_candidate)
        return list(primes)

    def translate_type(self, ty: Any) -> Any:
        level = ty.element_type.level.value.data
        ciphertext_type = self.type_builder.create_ciphertext_type_at_level(
            level)
        return ciphertext_type


def create_halo_frontend() -> HaloFrontend:
    """Factory function to create a Halo frontend."""
    return HaloFrontend()
