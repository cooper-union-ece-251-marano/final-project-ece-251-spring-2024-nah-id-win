from typing import Callable
from nTypes import *
from functools import lru_cache

def removNestings(l):
    output = []
    for i in l:
        if type(i) == list:
            output.extend(removNestings(i))
        else:
            output.append(i)
    return output

instructions: dict[str, list[int, str, int]] = {
    'ADDI' : [-1, 'N'],
    'NOOP' : [0, 'I'],
    'INC' : [1, 'R'],
    'DEC' : [2, 'R'],
    'RST' : [3, 'R'],
    'JI' : [-1, 'N'],
    'JR' : [4, 'J'],
    'BNE' : [5, 'J'],
    'BE' : [6, 'J'],
    'ADD' : [7, 'R'],
    'LW' : [-1, 'N'],
    'SW' : [-1, 'N'],
    'LWOFF' : [8, 'R'],
    'SWOFF' : [9, 'R'],
    'XOR' : [10, 'R'],
    'AND' : [11, 'R'],
    'OR' : [12, 'R'],
    'XORI' : [-1, 'N'],
    'ANDI' : [-1, 'N'],
    'ORI' : [-1, 'N'],
    'SETI' : [-1, 'N'],
    'SET' : [13, 'R'],
    'MULT' : [14, 'R'],
    'MFHI' : [15, 'R'],
    'MFLO' : [16, 'R'],
    'BL' : [17, 'J'],
    'BG' : [18, 'J'],
    'BLE' : [19, 'J'],
    'BGE' : [20, 'J'],
    'LIHI' : [21, 'I'],
    'LILO' : [22, 'I'],
    'OUT' : [23, 'R'],
    'HALT' : [24, 'J'],
    'SLLI' : [-1, 'N'],
    'SLRI' : [-1, 'N'],
    'SLL' : [25, 'R'],
    'SLR' : [26, 'R'],
    'JAL' : [-1, 'N']
}

nTypeFunctions: dict[str, Callable] = {
    'ADDI' : ADDI,
    'JI' : JI,
    'LW' : LW,
    'SW' : SW,
    'XORI' : XORI,
    'ANDI' : ANDI,
    'ORI' : ORI,
    'SETI' : SETI,
    'SLLI' : SLLI,
    'SLRI' : SLRI,
    'JAL' : JAL
}

blanks: dict[str, int] = {
    'R' : 2,
    'I' : 3,
    'J' : 8,
    'N' : 0
}

registers: dict[str, int] = {
    '$im' : 0,
    '$a' : 1,
    '$x' : 2,
    '$y' : 3,
    '$hi' : 4,
    '$lo' : 5,
    '$sp' : 6,
    '$ra' : 7,
}

import sys

@lru_cache(maxsize=128)
def parseLine(line: str, labels: dict[str, int], insCount: int) -> list[str]:
    values: list[str] = line.strip().split(' ')
    info: list[int, str] = instructions[values[0]]
    op: str = bin(info[0])[2:].rjust(5, '0')[:5] + ('0' * blanks[info[1]])
    if info[1] == 'R':
        for reg in values[1:]:
            op += bin(registers[reg.rstrip(',')])[2:].rjust(3, '0')
    elif info[1] == 'I':
        halfImm: str = values[1]
        if len(halfImm) >= 3:
            if halfImm[0:2] == '0b':
                num = halfImm[2:].rjust(8, '0')
                op += num
            elif halfImm[0:2] == '0x':
                num = bin(int(halfImm[2:], 16))[2:].rjust(8, '0')
                op += num
            else:
                op += bin(int(halfImm))[2:].rjust(8, '0')
        else:
            op += bin(int(halfImm))[2:].rjust(8, '0')
    elif info[1] == 'J':
        if (values[0] not in ['NOOP', 'HALT']):
            op += bin(registers[values[1]])[2:].rjust(3, '0')
    else:
        if values[0] == 'JAL':
            ops = (nTypeFunctions[values[0]](line, labels, insCount))
        else:
            ops = (nTypeFunctions[values[0]](line))
        return removNestings([parseLine(ins, labels, insCount) for ins in ops])
    op = op.ljust(16, '0')
    return [op]

def main() -> None:
    verbose: bool = False
    labels: dict[str, int] = {}
    insCount: int = 0
    args: list[str] = sys.argv[1:]
    if len(args) == 0:
        raise Exception('Input file name not provided.')
    if len(args) == 1:
        raise Exception('Output file name not provided.')
    if len(args) == 3:
        if args[2] == '-v':
            verbose = True
    inFileName = args[0]
    outFileName = args[1]
    lines: list[str] = []
    with open(inFileName, 'r') as inFile:
        lines = inFile.readlines()
    with open(outFileName, 'w') as outFile:
        for line in lines:
            if line[0] == '#' or line == '\n':
                if verbose:
                    print(line.strip())
                    print(['COMMENT'])
                    print()
                continue
            if line[0] == '.':
                labels[line.strip()] = insCount
                if verbose:
                    print(line.strip())
                    print(['LABEL', f'{line.strip()} = {labels[line.strip()]}'])
                    print()
                continue
            ops = parseLine(line, labels, insCount)
            if verbose:
                print(line.strip())
                print(ops)
                print()
            insCount += len(ops)
            for op in ops:
                outFile.write(op+'\n')
    
if __name__ == '__main__':
    main()