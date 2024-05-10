//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: tb_computer
//     Description: Test bench for a single-cycle MIPS computer
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_COMPUTER
`define TB_COMPUTER

`include "../definitions/definitions.sv"
`timescale 1ns/100ps

`include "computer.sv"
`include "../clock/clock.sv"

module tb_computer;
  parameter n = `WORDSIZE; // # bits to represent the instruction / ALU operand / general purpose register (GPR)
  parameter m = 4;  // # bits to represent the address of the 2**m=32 GPRs in the CPU
  logic clk;
  logic clk_enable;
  logic reset;
  logic memwrite;
  logic [n-1:0] writedata;
  logic [n-1:0] dataadr;

  logic firstTest, secondTest;

  // instantiate the CPU as the device to be tested
  computer dut(clk, reset, writedata, dataadr, memwrite);
  // generate clock to sequence tests
  // always
  //   begin
  //     clk <= 1; # 5; clk <= 0; # 5;
  //   end

  // instantiate the clock
  clock dut1(.ENABLE(clk_enable), .CLOCK(clk));


  initial begin
    firstTest = 1'b0;
    secondTest = 1'b0;
    $dumpfile("tb_computer.vcd");
    $dumpvars(0,dut1,clk,reset,writedata,dataadr,memwrite);
    $monitor("t=%t 0x%7h %7d %8d",$realtime,writedata,dataadr,memwrite);
    // $dumpvars(0,clk,a,b,ctrl,result,zero,negative,carryOut,overflow);
    // $display("Ctl Z  N  O  C  A                    B                    ALUresult");
    // $monitor("%3b %b  %b  %b  %b  %8b (0x%2h;%3d)  %8b (0x%2h;%3d)  %8b (0x%2h;%3d)",ctrl,zero,negative,overflow,carryOut,a,a,a,b,b,b,result,result,result);
  end

  // initialize test
  initial begin
    #0 clk_enable <= 0; #50 reset <= 1; # 50; reset <= 0; #50 clk_enable <= 1;
    #5000 $finish;
  end

  // monitor what happens at posedge of clock transition
  always @(posedge clk)
  begin
      $display("+");
      $display(" +instr = 0x%8h",dut.instr);
      $display(" +op = 0b%4b",dut.mips.c.op);
      $display(" +controls = 0b%7b",dut.mips.c.md.controls);
      //$display(" +funct = 0b%6b",dut.mips.c.ad.funct);
      //$display(" +aluop = 0b%2b",dut.mips.c.aluop);
      //$display(" +alucontrol = 0b%3b",dut.mips.c.ad.alucontrol);
      $display(" +alu result = 0x%8h",dut.mips.dp.alu.dest);
      //TODO implement HiLO
	  //$display(" +HiLo = 0x%8h",dut.mips.dp.alu.HiLo);
	  
	  $display(" +$pc = 0x%4h",dut.pc);
	  $display(" +$sp = 0x%4h",dut.mips.dp.rf.rf[2]);
      $display(" +$im = 0x%4h",dut.mips.dp.rf.rf[3]);
      $display(" +$ra = 0x%4h",dut.mips.dp.rf.rf[4]);
      $display(" +$a  = 0x%4h",dut.mips.dp.rf.rf[5]);
      $display(" +$b = 0x%4h",dut.mips.dp.rf.rf[6]);
      $display(" +$x = 0x%4h",dut.mips.dp.rf.rf[7]);
	  $display(" +$y = 0x%4h",dut.mips.dp.rf.rf[8]);
	  $display(" +$?? = 0x%4h",dut.mips.dp.rf.rf[9]);
	  $display(" +$?? = 0x%4h",dut.mips.dp.rf.rf[10]);
	  $display(" +$?? = 0x%4h",dut.mips.dp.rf.rf[11]);
	  $display(" +$?? = 0x%4h",dut.mips.dp.rf.rf[12]);
	  $display(" +$?? = 0x%4h",dut.mips.dp.rf.rf[13]);
	  $display(" +$hi = 0x%4h",dut.mips.dp.rf.rf[14]);
	  $display(" +$lo = 0x%4h",dut.mips.dp.rf.rf[15]);
	  $display(" +$zero = 0x%4h",dut.mips.dp.rf.rf[0]);
      $display(" +regfile -- ra1 = %d",dut.mips.dp.rf.ra1);
      $display(" +regfile -- ra2 = %d",dut.mips.dp.rf.ra2);
      $display(" +regfile -- we3 = %d",dut.mips.dp.rf.we3);
      $display(" +regfile -- wa3 = %d",dut.mips.dp.rf.wa3);
      $display(" +regfile -- wd3 = %d",dut.mips.dp.rf.wd3);
      $display(" +regfile -- rd1 = %d",dut.mips.dp.rf.rd1);
      $display(" +regfile -- rd2 = %d",dut.mips.dp.rf.rd2);
      $display(" +RAM[%4d] = %4d",dut.dmem.addr,dut.dmem.readdata);
      $display("writedata dataadr memwrite");
  end

  // run program
  // monitor what happens at negedge of clock transition
  always @(negedge clk) begin
    $display("-");
    $display(" +instr = 0x%8h",dut.instr);
    $display(" +op = 0b%4b",dut.mips.c.op);
    $display(" +controls = 0b%7b",dut.mips.c.md.controls);
    //$display(" +funct = 0b%6b",dut.mips.c.ad.funct);
    //$display(" +aluop = 0b%2b",dut.mips.c.aluop);
    //$display(" +alucontrol = 0b%3b",dut.mips.c.ad.alucontrol);
    $display(" +alu result = 0x%8h",dut.mips.dp.alu.dest);
    //TODO implement HiLO
    //$display(" +HiLo = 0x%8h",dut.mips.dp.alu.HiLo);
    
    $display(" +$pc = 0x%4h",dut.pc);
    $display(" +$sp = 0x%4h",dut.mips.dp.rf.rf[2]);
    $display(" +$im = 0x%4h",dut.mips.dp.rf.rf[3]);
    $display(" +$ra = 0x%4h",dut.mips.dp.rf.rf[4]);
    $display(" +$a  = 0x%4h",dut.mips.dp.rf.rf[5]);
    $display(" +$b = 0x%4h",dut.mips.dp.rf.rf[6]);
    $display(" +$x = 0x%4h",dut.mips.dp.rf.rf[7]);
    $display(" +$y = 0x%4h",dut.mips.dp.rf.rf[8]);
    $display(" +$?? = 0x%4h",dut.mips.dp.rf.rf[9]);
    $display(" +$?? = 0x%4h",dut.mips.dp.rf.rf[10]);
    $display(" +$?? = 0x%4h",dut.mips.dp.rf.rf[11]);
    $display(" +$?? = 0x%4h",dut.mips.dp.rf.rf[12]);
    $display(" +$?? = 0x%4h",dut.mips.dp.rf.rf[13]);
    $display(" +$hi = 0x%4h",dut.mips.dp.rf.rf[14]);
    $display(" +$lo = 0x%4h",dut.mips.dp.rf.rf[15]);
    $display(" +$zero = 0x%4h",dut.mips.dp.rf.rf[0]);
    $display(" +regfile -- ra1 = %d",dut.mips.dp.rf.ra1);
    $display(" +regfile -- ra2 = %d",dut.mips.dp.rf.ra2);
    $display(" +regfile -- we3 = %d",dut.mips.dp.rf.we3);
    $display(" +regfile -- wa3 = %d",dut.mips.dp.rf.wa3);
    $display(" +regfile -- wd3 = %d",dut.mips.dp.rf.wd3);
    $display(" +regfile -- rd1 = %d",dut.mips.dp.rf.rd1);
    $display(" +regfile -- rd2 = %d",dut.mips.dp.rf.rd2);
    $display(" +RAM[%4d] = %4d",dut.dmem.addr,dut.dmem.readdata);
    $display("writedata dataadr memwrite");
  end
endmodule

`endif // TB_COMPUTER
