import random
import math


def decompose(n):
    exponentOfTwo = 0

    while n % 2 == 0:
        n = n // 2
        exponentOfTwo += 1

    return exponentOfTwo, n


def isWitness(possibleWitness, p, exponent, remainder):
    possibleWitness = pow(possibleWitness, remainder, p)

    if possibleWitness == 1 or possibleWitness == p - 1:
        return False

    for _ in range(exponent):
        possibleWitness = pow(possibleWitness, 2, p)

        if possibleWitness == p - 1:
            return False

    return True

def nearestPowerOfTwo(p):
    # match the computation of APInt::nearestLogBase2
    # nearestLogBase2(x) = logBase2(x) + x[logBase2(x)-1].
    # where x[i] is referring to the value of the ith bit of x.
    lg = math.floor(math.log2(p))
    bit = (p >> (lg - 1)) & 1
    return lg + bit


def probablyPrime(p, accuracy=100):
    if p == 2 or p == 3:
        return True
    if p < 2:
        return False

    exponent, remainder = decompose(p - 1)

    for _ in range(accuracy):
        possibleWitness = random.randint(2, p - 2)
        if isWitness(possibleWitness, p, exponent, remainder):
            return False

    return True


def generatePrimeCandidate(bit_width=60):
    candidate = random.getrandbits(bit_width)
    candidate |= 1
    candidate |= 1 << (bit_width - 1)
    candidate &= (1 << bit_width) - 1
    return candidate
