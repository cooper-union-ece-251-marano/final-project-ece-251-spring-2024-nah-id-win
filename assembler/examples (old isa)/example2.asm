# a = 0, while(true) {print(a), a = a + 1}
RST $a
.loop
INC $a
OUT $a
J .loop