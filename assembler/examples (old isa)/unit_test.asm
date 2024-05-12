NOOP
JR $hi
BNE $a, $x, 100
BE $a, $x, 100
BL $a, $x, 100
BG $a, $x, 100
BLE $a, $x, 100
BGE $a, $x, 100
LIHI 0b20
LILO -100
INC $a
DEC $a
RST $hi
ADD $lo, $a, $x
LWOFF $a, $x, 7
SWOFF $a, $x, 7
XOR $lo, $a, $x
AND $lo, $a, $x
OR $lo, $a, $x
SETI $lo, 1
MULT $a, $x
MFHI $lo
MFLO $lo
SLL $lo, $a, $x
SLR $lo, $a, $x
ADDI $lo, $hi, 4000
J 100
LW $hi, $lo, 4000
SW $hi, $lo, 4000
XORI $lo, $hi, -4000
ANDI $lo, $hi, 4000
ORI $lo, $hi, 4000
SETI $lo, 4000
SLLI $lo, $hi, 4000
SLRI $lo, $hi, 4000
JAL 100
