"""
Orion-HEIR Translator Package

A standalone translator for converting Orion FHE operations to HEIR MLIR format.
"""

__version__ = "0.1.0"
__author__ = "FHE Research Team"

from src.orion_heir.core.translator import GenericTranslator, create_translator
from src.orion_heir.core.types import FHEOperation
from src.orion_heir.frontends.orion.orion_frontend import OrionFrontend
from src.orion_heir.frontends.orion.scheme_params import OrionSchemeParameters

from src.orion_heir.frontends.halo.halo_frontend import HaloFrontend
from src.orion_heir.frontends.halo.scheme_parameters import HaloSchemeParameters

# Import CKKS interpreter components
try:
    from src.orion_heir.ckks_interpreter import (
        CKKSDialectInterpreter,
        CKKSValidationFramework,
        OrionHeirValidationPipeline,
        ValidationReport,
    )

    _CKKS_INTERPRETER_AVAILABLE = True
except ImportError:
    _CKKS_INTERPRETER_AVAILABLE = False

__all__ = [
    "GenericTranslator",
    "FHEOperation",
    "create_translator",
    "OrionFrontend",
    "OrionSchemeParameters",
]

# Add CKKS interpreter exports if available
if _CKKS_INTERPRETER_AVAILABLE:
    __all__.extend(
        [
            "CKKSDialectInterpreter",
            "CKKSValidationFramework",
            "OrionHeirValidationPipeline",
            "ValidationReport",
        ]
    )
