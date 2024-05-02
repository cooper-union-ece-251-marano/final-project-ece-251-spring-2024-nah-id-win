def immToBin(imm: str) -> str:
    if len(imm) >= 3:
        if imm[0:2] == '0b':
            return imm[2:].rjust(16, '0')
        elif imm[0:2] == '0x':
            return bin(int(imm[2:], 16))[2:].rjust(16, '0')
    return bin(int(imm))[2:].rjust(16, '0')

def ADDI(line: str) -> list[str]:
    values: list[str] = line.split()[1:]
    dest: str = values[0].rstrip(',')
    src: str = values[1].rstrip(',')
    imm: str = immToBin(values[2].rstrip(','))
    return [f'LIHI 0b{imm[:8]}', f'LILO 0b{imm[8:]}', f'ADD {dest}, {src}, $im']

def XORI(line: str) -> list[str]:
    values: list[str] = line.split()[1:]
    dest: str = values[0].rstrip(',')
    src: str = values[1].rstrip(',')
    imm: str = immToBin(values[2].rstrip(','))
    return [f'LIHI 0b{imm[:8]}', f'LILO 0b{imm[8:]}', f'XOR {dest}, {src}, $im']

def ANDI(line: str) -> list[str]:
    values: list[str] = line.split()[1:]
    dest: str = values[0].rstrip(',')
    src: str = values[1].rstrip(',')
    imm: str = immToBin(values[2].rstrip(','))
    return [f'LIHI 0b{imm[:8]}', f'LILO 0b{imm[8:]}', f'AND {dest}, {src}, $im']

def ORI(line: str) -> list[str]:
    values: list[str] = line.split()[1:]
    dest: str = values[0].rstrip(',')
    src: str = values[1].rstrip(',')
    imm: str = immToBin(values[2].rstrip(','))
    return [f'LIHI 0b{imm[:8]}', f'LILO 0b{imm[8:]}', f'OR {dest}, {src}, $im']

def SETI(line: str) -> list[str]:
    values: list[str] = line.split()[1:]
    dest: str = values[0].rstrip(',')
    imm: str = immToBin(values[1].rstrip(','))
    return [f'LIHI 0b{imm[:8]}', f'LILO 0b{imm[8:]}', f'SET {dest}, $im']

def SLLI(line: str) -> list[str]:
    values: list[str] = line.split()[1:]
    dest: str = values[0].rstrip(',')
    src: str = values[1].rstrip(',')
    imm: str = immToBin(values[2].rstrip(','))
    return [f'LIHI 0b{imm[:8]}', f'LILO 0b{imm[8:]}', f'SLL {dest}, {src}, $im']

def SLRI(line: str) -> list[str]:
    values: list[str] = line.split()[1:]
    dest: str = values[0].rstrip(',')
    src: str = values[1].rstrip(',')
    imm: str = immToBin(values[2].rstrip(','))
    return [f'LIHI 0b{imm[:8]}', f'LILO 0b{imm[8:]}', f'SLR {dest}, {src}, $im']

def JI(line: str) -> list[str]:
    values: list[str] = line.split()[1:]
    imm: str = immToBin(values[0].rstrip(','))
    return [f'LIHI 0b{imm[:8]}', f'LILO 0b{imm[8:]}', f'JR $im']

def LW(line: str) -> list[str]:
    values: list[str] = line.split()[1:]
    src: str = values[0].rstrip(',')
    dest: str = values[1].rstrip(',')
    imm: str = immToBin(values[2].rstrip(','))
    return [f'LIHI 0b{imm[:8]}', f'LILO 0b{imm[8:]}', f'LWOFF {src}, $im, {dest}']

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