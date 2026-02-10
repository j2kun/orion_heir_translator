"""
Halo scheme parameters implementation.

This module provides Halo-specific scheme parameter handling.
"""

from typing import List, Optional, Union
import warnings

from ...core.types import SchemeParameters


class HaloNotAvailableError(Exception):
    """Raised when Halo is required but not available."""

    pass


class HaloSchemeParameters(SchemeParameters):
    """
    Halo-specific implementation of scheme parameters.

    This class handles Halo CKKS parameters and provides
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
        backend: str = "halo",
        primes: List[int] = [],
        aux: List[int] = [],
    ):
        # Normalize logN to always be an integer
        self.logN = logN[0] if isinstance(logN, list) else logN
        self.logQ = logQ
        self.logP = logP
        self.logScale = logScale
        self.slots = slots
        self.backend = backend
        self._ring_degree = ring_degree
        self._modulus_chain = None

        # For Halo, we will use pre-computed primes
        self.ciphertext_modulus_chain = primes
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
            "actual_primes": self.ciphertext_modulus_chain,
        }

    @classmethod
    def from_dict(cls, data: dict) -> "HaloSchemeParameters":
        """Create parameters from dictionary representation."""
        return cls(
            logN=data["logN"],
            logQ=data["logQ"],
            logP=data["logP"],
            logScale=data["logScale"],
            slots=data["slots"],
            ring_degree=data["ring_degree"],
            backend=data.get("backend", "halo"),
        )

    def __repr__(self) -> str:
        return (
            f"HaloSchemeParameters(logN={self.logN}, logQ={self.logQ}, "
            f"logP={self.logP}, logScale={self.logScale}, "
            f"slots={self.slots}, ring_degree={self.ring_degree})"
        )
