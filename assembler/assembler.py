from typing import Callable
from nTypes import *
from bitstring import *

def removNestings(l):
    output = []
    for i in l:
        if type(i) == list:
            output.extend(removNestings(i))
        else:
            output.append(i)
    return output

instructions: dict[str, list[int, str, int]] = {
    'NOOP' : [0, 'J'],
    'JR' : [1, 'R'],
    'BE' : [3, 'R'],
    'ADD' : [9, 'R'],
    'LW' : [7, 'R'],
    'SW' : [5, 'R'],
    'XOR' : [10, 'R'],
    'AND' : [11, 'R'],
    'OR' : [12, 'R'],
    'LI' : [8, 'I'],
    'SLL' : [14, 'R'],
    'SLR' : [15, 'R'],
}

nTypeFunctions: dict[str, Callable] = {
    'ADDI' : ADDI,
    'J' : J,
    'LWOFF' : LWOFF,
    'SWOFF' : SWOFF,
    'XORI' : XORI,
    'ANDI' : ANDI,
    'ORI' : ORI,
    'SETI' : SETI,
    'SLLI' : SLLI,
    'SLRI' : SLRI,
    'JAL' : JAL,
    'INC' : INC,
    'DEC' : DEC,
    'MFHI' : MFHI,
    'MFLO' : MFLO
}

blanks: dict[str, int] = {
    'R' : 2,
    'I' : 3,
    'J' : 8,
    'N' : 0
}

registers: dict[str, int] = {
    '$zero' : 0,
    '$sp' : 2,
    '$s' : 1,
    '$ra' : 3,
    '$im' : 4,
    '$a' : 5,
    '$b' : 6,
    '$x' : 7,
    '$y' : 8,
    '$hi' : 14,
    '$lo' : 15,
}

import sys

def parseLine(line: str, labels: dict[str, int], insCount: int) -> list[str]:
    values: list[str] = line.strip().split(' ')
    info: list[int, str] = instructions[values[0]]
    op: str = bin(info[0])[2:].rjust(4, '0')[:4]
    if info[1] == 'R':
        for reg in values[1:]:
            op += bin(registers[reg.rstrip(',')])[2:].rjust(4, '0')
    elif info[1] == 'I':
        op += bin(registers[values[1].rstrip(',')])[2:].rjust(4, '0')
        halfImm: str = values[2]
        if len(halfImm) >= 3:
            if halfImm[0:2] == '0b':
                num = halfImm[2:].rjust(8, '0')
                op += num
            elif halfImm[0:2] == '0x':
                num = bin(int(halfImm[2:], 16))[2:].rjust(8, '0')
                op += num
            else:
                op += Bits(int=int(halfImm), length=8).bin
        else:
            op += Bits(int=int(halfImm), length=8).bin
    elif info[1] == 'J':
        if (values[0] not in 'NOOP'):
            op += bin(registers[values[1].rstrip(',')])[2:].rjust(3, '0')
    else:
        if values[0] in ['JAL', 'J']:
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
            print("PROCESSING: {}".format(line))
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
