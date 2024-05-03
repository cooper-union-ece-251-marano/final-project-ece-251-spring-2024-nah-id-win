NOOP
JR $hi
BNE $a, $x, 100
BE $a, $x, 100
BL $a, $x, 100
BG $a, $x, 100
BLE $a, $x, 100
BGE $a, $x, 100
LIHI 0b20
LILO -10
INC $a
DEC $a
RST $hi
ADD $lo, $a, $x
LWOFF $a, $x, 11
SWOFF $a, $x, 10
XOR $lo, $a, $x
AND $lo, $a, $x
OR $lo, $a, $x
MULT $a, $x
MFHI $lo
MFLO $lo
SLL $lo, $a, $x
SLR $lo, $a, $x
ADDI $lo, $hi, 400
J 100
LW $hi, $lo
SW $hi, $lo
XORI $lo, $hi, -400
ANDI $lo, $hi, 400
ORI $lo, $hi, 400
SLLI $lo, $hi, 400
SLRI $lo, $hi, 400
JAL 100
SETI $a, 0x1f
SET $x, $hi