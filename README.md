# "Nah, I'd Win" CPU ISA
## A MIPS-like architecture <br> ECE-251 Computer Architecture Final Project, led by Prof. Rob Marano <br> written by evan rosenfeld and james ryan  

**Please See `pdf/bin/NahIdWinGreenSheet.pdf` for detailed info on our ISA**  

# What's Provided
1. Our ISA
    - under `catalog/computer` are various test programs for the user to load  
   onto our ISA, just specify the file name in the Instruction Memory module  
   (under `catalog/imem/imem.sv`), and then run `make` in the `catalog/computer/`  
   directory.  
    - We provide a sample Fibonnaci program, `catalog/computer/fib/fib.asm`, and  
    we provide a pre-assembled copy under `catalog/computer/fib/fib.bin`, along  
    with a provided output log `catalog/computer/fib/output.txt` which shows  
    the result of running fib ($x stores fib(n+1) where n is the number of iterations)  
2. Our Assembler
    - We provide an assembler under `assembler/`. The Green Sheet  
    provides info on valid instructions which it can recognized, along with their  
    canonical instruction names. This is BETA, and only supports a handful of our  
    instructions.  
3. A demo!
    - A demo video can be found [here!](https://youtu.be/mvnDQ-c6qT8)
    - Other goodies (like our fib waveforms) can be seen under `goodies/`
