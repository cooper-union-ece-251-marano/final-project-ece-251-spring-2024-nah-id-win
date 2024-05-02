# x = 50, y = 50, a = x + y, a = a = 1, print(a)
SETI $x, 50
SETI $y, 50
ADD $a, $x, $y
INC $a
OUT $a
HALT