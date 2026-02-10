#!/usr/bin/env python3
"""
Entry point to convert a Halo output IR to HEIR IR
"""

import click
import sys
from pathlib import Path
from io import StringIO

from xdsl.printer import Printer
from xdsl.parser import Parser
from xdsl.context import Context
from xdsl.dialects.builtin import Builtin
from xdsl.dialects import builtin

# Add the src directory to the path
sys.path.insert(0, str(Path(__file__).parent.parent))

from src.orion_heir.frontends.halo.halo_frontend import create_halo_frontend

def load_module_from_file(file_path: Path):
    from xdsl.dialects.arith import Arith
    from xdsl.dialects.tensor import Tensor
    from xdsl.dialects.func import Func
    from orion_heir.dialects.halo import Halo

    suffix = file_path.suffix.lower()

    with open(file_path, "r") as f:
        if suffix == ".mlir":
            context = Context()
            for dialect in [Halo, Builtin, Func, Tensor, Arith]:
                context.load_dialect(dialect)
            parser = Parser(context, f.read())
            module = parser.parse_module()
            return module
        else:
            raise ValueError(
                f"Unsupported file format: {suffix}. Please use MLIR, JSON or YAML."
            )


def translate_to_heir_module(
        dacapo_mlir: builtin.ModuleOp) -> builtin.ModuleOp:
    frontend = create_halo_frontend()
    heir_module = frontend.translate_module(dacapo_mlir)
    return heir_module


@click.command()
@click.option(
    "--input",
    "-i",
    "input",
    type=click.Path(exists=True, path_type=Path),
    help="Input file from Halo IR",
)
@click.option(
    "--output",
    "-o",
    "output",
    type=click.Path(path_type=Path),
    help="Ouptut file for HEIR IR",
)
def main(input, output):
    module = load_module_from_file(input)
    heir_module = translate_to_heir_module(module)

    output_buffer = StringIO()
    printer = Printer(stream=output_buffer)
    printer.print_op(heir_module)
    mlir_output = output_buffer.getvalue()

    Path(output).write_text(mlir_output)


if __name__ == "__main__":
    exit(main())
