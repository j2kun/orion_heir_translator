"""
Halo dialect implementation for xDSL.

This dialect provides operations for the Halo FHE scheme, based on the
CKKS dialect defined in the DaCapo project.
"""

from collections.abc import Sequence

from xdsl.dialects.builtin import IntegerAttr, DenseArrayBase, TensorType
from xdsl.ir import Attribute, Dialect, ParametrizedAttribute, TypeAttribute
from xdsl.irdl import (
    IRDLOperation,
    ParameterDef,
    irdl_attr_definition,
    irdl_op_definition,
    operand_def,
    prop_def,
    result_def,
)
from xdsl.parser import Parser
from xdsl.printer import Printer


@irdl_attr_definition
class PolyType(ParametrizedAttribute, TypeAttribute):
    """
    A type for CKKS poly type
    """

    name = "ckks.poly"

    num_poly: ParameterDef[IntegerAttr]
    level: ParameterDef[IntegerAttr]

    @classmethod
    def parse_parameters(cls, parser: Parser) -> Sequence[Attribute]:
        """Parse PolyType parameters."""
        parser.parse_punctuation("<")
        num_poly = parser.parse_integer()
        parser.parse_punctuation("*")
        level = parser.parse_integer()
        parser.parse_punctuation(">")
        return [
            IntegerAttr.from_int_and_width(num_poly, 64),
            IntegerAttr.from_int_and_width(level, 64),
        ]

    def print_parameters(self, printer: Printer) -> None:
        """Print PolyType parameters."""
        printer.print_string(f"<{self.num_poly.value.data}* {self.level.value.data}>")


PolyTensor = TensorType[PolyType]


@irdl_op_definition
class EncodeOp(IRDLOperation):
    name = "ckks.encode"
    dst = operand_def(PolyTensor)
    value = prop_def(IntegerAttr)
    scale = prop_def(IntegerAttr)
    level = prop_def(IntegerAttr)
    result = result_def(PolyTensor)


@irdl_op_definition
class RotateCOp(IRDLOperation):
    name = "ckks.rotatec"
    dst = operand_def(PolyTensor)
    src = operand_def(PolyTensor)
    offset = prop_def(DenseArrayBase)
    result = result_def(PolyTensor)


@irdl_op_definition
class NegateCOp(IRDLOperation):
    name = "ckks.negatec"
    dst = operand_def(PolyTensor)
    src = operand_def(PolyTensor)
    result = result_def(PolyTensor)


@irdl_op_definition
class RescaleCOp(IRDLOperation):
    name = "ckks.rescalec"
    dst = operand_def(PolyTensor)
    src = operand_def(PolyTensor)
    result = result_def(PolyTensor)


@irdl_op_definition
class ModswitchCOp(IRDLOperation):
    name = "ckks.modswitchc"
    dst = operand_def(PolyTensor)
    src = operand_def(PolyTensor)
    downFactor = prop_def(IntegerAttr)
    result = result_def(PolyTensor)


@irdl_op_definition
class UpscaleCOp(IRDLOperation):
    name = "ckks.upscalec"
    dst = operand_def(PolyTensor)
    src = operand_def(PolyTensor)
    upFactor = prop_def(IntegerAttr)
    result = result_def(PolyTensor)


@irdl_op_definition
class BootstrapCOp(IRDLOperation):
    name = "ckks.bootstrapc"
    dst = operand_def(PolyTensor)
    src = operand_def(PolyTensor)
    level = prop_def(IntegerAttr)
    result = result_def(PolyTensor)


@irdl_op_definition
class AddCCOp(IRDLOperation):
    name = "ckks.addcc"
    dst = operand_def(PolyTensor)
    lhs = operand_def(PolyTensor)
    rhs = operand_def(PolyTensor)
    result = result_def(PolyTensor)


@irdl_op_definition
class AddCPOp(IRDLOperation):
    name = "ckks.addcp"
    dst = operand_def(PolyTensor)
    lhs = operand_def(PolyTensor)
    rhs = operand_def(PolyTensor)
    result = result_def(PolyTensor)


@irdl_op_definition
class MulCCOp(IRDLOperation):
    name = "ckks.mulcc"
    dst = operand_def(PolyTensor)
    lhs = operand_def(PolyTensor)
    rhs = operand_def(PolyTensor)
    result = result_def(PolyTensor)


@irdl_op_definition
class MulCPOp(IRDLOperation):
    name = "ckks.mulcp"
    dst = operand_def(PolyTensor)
    lhs = operand_def(PolyTensor)
    rhs = operand_def(PolyTensor)
    result = result_def(PolyTensor)


Halo = Dialect(
    "ckks",
    [
        EncodeOp,
        RotateCOp,
        NegateCOp,
        RescaleCOp,
        ModswitchCOp,
        UpscaleCOp,
        BootstrapCOp,
        AddCCOp,
        AddCPOp,
        MulCCOp,
        MulCPOp,
    ],
    [
        PolyType,
    ],
)