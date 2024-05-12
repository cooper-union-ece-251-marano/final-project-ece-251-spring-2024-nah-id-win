LI $a, 1 // a = 1
LI $b, 1 // b = 1
LI $x, 0
LI $ra, label1
label1: 
ADD $x, $a, $b // x = a + b
ADD $b, $zero, $a // b = a
ADD $a, $zero, $x // a = x
JR $ra