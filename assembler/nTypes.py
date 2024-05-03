from functools import lru_cache
from bitstring import *

@lru_cache(maxsize=128)
def immToBin(imm: str) -> str:
    if len(imm) >= 3:
        if imm[0:2] == '0b':
            return imm[2:].rjust(16, '0')
        elif imm[0:2] == '0x':
            return bin(int(imm[2:], 16))[2:].rjust(16, '0')
    return Bits(int=int(imm), length=16).bin

@lru_cache(maxsize=128)
def ADDI(line: str) -> list[str]:
    values: list[str] = line.split()[1:]
    dest: str = values[0].rstrip(',')
    src: str = values[1].rstrip(',')
    imm: str = immToBin(values[2].rstrip(','))
    return [f'LIHI 0b{imm[:8]}', f'LILO 0b{imm[8:]}', f'ADD {dest}, {src}, $im']

@lru_cache(maxsize=128)
def INC(line: str) -> list[str]:
    values: list[str] = line.split()[1:]
    src: str = values[0].rstrip(',')
    return [f'ADDI {src}, {src}, 1']

@lru_cache(maxsize=128)
def DEC(line: str) -> list[str]:
    values: list[str] = line.split()[1:]
    src: str = values[0].rstrip(',')
    return [f'ADDI {src}, {src}, 0b1111111111111111']

@lru_cache(maxsize=128)
def XORI(line: str) -> list[str]:
    values: list[str] = line.split()[1:]
    dest: str = values[0].rstrip(',')
    src: str = values[1].rstrip(',')
    imm: str = immToBin(values[2].rstrip(','))
    return [f'LIHI 0b{imm[:8]}', f'LILO 0b{imm[8:]}', f'XOR {dest}, {src}, $im']

@lru_cache(maxsize=128)
def ANDI(line: str) -> list[str]:
    values: list[str] = line.split()[1:]
    dest: str = values[0].rstrip(',')
    src: str = values[1].rstrip(',')
    imm: str = immToBin(values[2].rstrip(','))
    return [f'LIHI 0b{imm[:8]}', f'LILO 0b{imm[8:]}', f'AND {dest}, {src}, $im']

@lru_cache(maxsize=128)
def ORI(line: str) -> list[str]:
    values: list[str] = line.split()[1:]
    dest: str = values[0].rstrip(',')
    src: str = values[1].rstrip(',')
    imm: str = immToBin(values[2].rstrip(','))
    return [f'LIHI 0b{imm[:8]}', f'LILO 0b{imm[8:]}', f'OR {dest}, {src}, $im']

@lru_cache(maxsize=128)
def SETI(line: str) -> list[str]:
    values: list[str] = line.split()[1:]
    dest: str = values[0].rstrip(',')
    imm: str = immToBin(values[1].rstrip(','))
    return [f'LIHI 0b{imm[:8]}', f'LILO 0b{imm[8:]}', f'SET {dest}, $im']

@lru_cache(maxsize=128)
def SLLI(line: str) -> list[str]:
    values: list[str] = line.split()[1:]
    dest: str = values[0].rstrip(',')
    src: str = values[1].rstrip(',')
    imm: str = immToBin(values[2].rstrip(','))
    return [f'LIHI 0b{imm[:8]}', f'LILO 0b{imm[8:]}', f'SLL {dest}, {src}, $im']

@lru_cache(maxsize=128)
def SLRI(line: str) -> list[str]:
    values: list[str] = line.split()[1:]
    dest: str = values[0].rstrip(',')
    src: str = values[1].rstrip(',')
    imm: str = immToBin(values[2].rstrip(','))
    return [f'LIHI 0b{imm[:8]}', f'LILO 0b{imm[8:]}', f'SLR {dest}, {src}, $im']

def J(line: str, labels: dict[str, int], insCount: int) -> list[str]:
    values: list[str] = line.split()[1:]
    ji: str = values[0].rstrip(',')
    if ji[0] == '.':
        ji = str(labels[ji])
    imm = immToBin(ji)
    return [f'LIHI 0b{imm[:8]}', f'LILO 0b{imm[8:]}', f'JR $im']

@lru_cache(maxsize=128)
def LW(line: str) -> list[str]:
    values: list[str] = line.split()[1:]
    src: str = values[0].rstrip(',')
    dest: str = values[1].rstrip(',')
    imm: str = immToBin(values[2].rstrip(','))
    return [f'LIHI 0b{imm[:8]}', f'LILO 0b{imm[8:]}', f'LWOFF {src}, $im, {dest}']

@lru_cache(maxsize=128)
def SW(line: str) -> list[str]:
    values: list[str] = line.split()[1:]
    src: str = values[0].rstrip(',')
    dest: str = values[1].rstrip(',')
    imm: str = immToBin(values[2].rstrip(','))
    return [f'LIHI 0b{imm[:8]}', f'LILO 0b{imm[8:]}', f'SWOFF {src}, $im, {dest}']

def JAL(line: str, labels: dict[str, int], insCount: int) -> list[str]:
    values: list[str] = line.split()[1:]
    ji: str = values[0].rstrip(',')
    if ji[0] == '.':
        ji = str(labels[ji])
    imm = immToBin(ji)
    return [f'SETI $ra, {insCount+6}', f'LIHI 0b{imm[:8]}', f'LILO 0b{imm[8:]}', f'JR $im']