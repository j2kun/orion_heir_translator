"""
Orion scheme parameters implementation.

This module provides Orion-specific scheme parameter handling,
including integration with the actual Orion library when available.
"""

from typing import List, Optional, Union

from src.orion_heir.core.types import SchemeParameters


class OrionNotAvailableError(Exception):
    """Raised when Orion is required but not available."""

    pass


class OrionSchemeParameters(SchemeParameters):
    """
    Orion-specific implementation of scheme parameters.

    This class handles Orion CKKS parameters and provides
    the interface expected by the generic translator.
    """

    def __init__(
        self,
        logN: Union[List[int], int],
        logQ: List[int],
        logP: List[int],
        logScale: int,
        slots: int,
        ring_degree: int,
        backend: str = "lattigo",
        require_orion: bool = False,
    ):
        # Normalize logN to always be an integer for Orion
        self.logN = logN[0] if isinstance(logN, list) else logN
        self.logQ = logQ
        self.logP = logP
        self.logScale = logScale
        self.slots = slots
        self.backend = backend
        self._ring_degree = ring_degree
        self._modulus_chain = None
        self.require_orion = require_orion
        (mod, aux) = self._get_actual_primes()
        self.ciphertext_modulus_chain = mod
        self.auxiliary_modulus_chain = aux

    @property
    def ring_degree(self) -> int:
        """Ring degree of the polynomial."""
        return self._ring_degree

    @property
    def plaintext_modulus(self) -> int:
        """Modulus for plaintexts."""
        # For CKKS, this is typically derived from the scaling factor
        return 2**self.logScale

    @property
    def log_scale(self) -> int:
        """Logarithm of the scaling factor."""
        return self.logScale

    @property
    def log_n(self) -> int:
        """Logarithm of the ring degree."""
        return self.logN

    def _get_actual_primes(self) -> Optional[List[int]]:
        """Get selected primes from Orion."""
        from orion.core.orion import Scheme

        config = {
            "ckks_params": {
                "LogN": self.logN,
                "LogQ": self.logQ,
                "LogP": self.logP,
                "LogScale": self.logScale,
                "H": 192,
                "RingType": "standard",
            },
            "orion": {
                "margin": 2,
                "embedding_method": "hybrid",
                "backend": self.backend,
                "fuse_modules": True,
                "debug": False,
                "diags_path": "data/diagonals.h5",
                "keys_path": "data/keys.h5",
                "io_mode": "save",
            },
        }

        print(f"🔧 Initializing Orion with LogN={self.logN}, LogQ={self.logQ}")

        # Initialize scheme
        scheme = Scheme()
        scheme.init_scheme(config)

        # Get moduli
        ciphertext_modulus_chain = scheme.encoder.get_moduli_chain()
        # i.e., special primes for key switching
        auxiliary_modulus_chain = scheme.encoder.get_aux_moduli_chain()
        scheme.delete_scheme()
        return (ciphertext_modulus_chain, auxiliary_modulus_chain)

    def to_dict(self) -> dict:
        """Convert parameters to dictionary representation."""
        return {
            "logN": self.logN,
            "logQ": self.logQ,
            "logP": self.logP,
            "logScale": self.logScale,
            "slots": self.slots,
            "ring_degree": self.ring_degree,
            "backend": self.backend,
            "require_orion": self.require_orion,
            "modulus_chain": self.ciphertext_modulus_chain,
            "aux_modulus_chain": self.auxiliary_modulus_chain,
        }

    @classmethod
    def from_dict(cls, data: dict) -> "OrionSchemeParameters":
        """Create parameters from dictionary representation."""
        return cls(
            logN=data["logN"],
            logQ=data["logQ"],
            logP=data["logP"],
            logScale=data["logScale"],
            slots=data["slots"],
            ring_degree=data["ring_degree"],
            backend=data.get("backend", "lattigo"),
            require_orion=data.get("require_orion", False),
        )

    def __repr__(self) -> str:
        return (
            f"OrionSchemeParameters(logN={self.logN}, logQ={self.logQ}, "
            f"logP={self.logP}, logScale={self.logScale}, "
            f"slots={self.slots}, ring_degree={self.ring_degree}, "
            f"require_orion={self.require_orion})"
        )


def create_default_orion_parameters(require_orion: bool = False) -> OrionSchemeParameters:
    """Create default Orion parameters for testing."""
    return OrionSchemeParameters(
        logN=13,  # Changed from [13] to 13
        logQ=[55, 45, 45, 55],
        logP=[55],
        logScale=45,
        slots=4096,
        ring_degree=8192,
        backend="lattigo",
        require_orion=require_orion,
    )


def create_mlp_orion_parameters(require_orion: bool = False) -> OrionSchemeParameters:
    """Create Orion parameters suitable for MLP computations."""
    return OrionSchemeParameters(
        logN=13,  # Changed from [13] to 13
        logQ=[60, 50, 50, 60],
        logP=[60],
        logScale=50,
        slots=4096,
        ring_degree=8192,
        backend="lattigo",
        require_orion=require_orion,
    )


def create_orion_parameters_strict() -> OrionSchemeParameters:
    """Create Orion parameters that require the actual Orion library."""
    return OrionSchemeParameters(
        logN=13,  # Changed from [13] to 13
        logQ=[55, 45, 45, 55],
        logP=[55],
        logScale=45,
        slots=4096,
        ring_degree=8192,
        backend="lattigo",
        require_orion=True,  # This will hard fail if Orion is not available
    )
