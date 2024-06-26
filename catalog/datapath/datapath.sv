//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: datapath
//     Description: 32-bit RISC-based CPU datapath (MIPS)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef DATAPATH
`define DATAPATH

`timescale 1ns/100ps

`include "../regfile/regfile.sv"
`include "../alu/alu.sv"
`include "../dff/dff.sv"
`include "../adder/adder.sv"
`include "../sl2/sl2.sv"
`include "../mux2/mux2.sv"
`include "../signext/signext.sv"

module datapath
    #(parameter n = `WORDSIZE)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic        clk, reset,
    input  logic        memtoreg,
    input  logic        alusrc, regdst,
    input  logic        regwrite, branch,
	input  logic [(n-1):0] instr,
    input  logic [(n-1):0] readdata,
	
	output logic        zero,
    output logic [(n-1):0] pc,
    output logic [(n-1):0] aluout, writedata,

    input  logic        jump
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [3:0] writereg;
    logic [(n-1):0] pcnext, pcnextbr, pcplus1, pcbranch;
    logic [(n-1):0] signimm, signimmsh;
    logic [(n-1):0] srca, srcb;
    logic [(n-1):0] result;
    logic [(n-1):0] branchextended;
    logic branchcheck;

    assign branchcheck = (branch & aluout[0]);

    // "next PC" logic
    dff #(n)    pcreg(clk, reset, pcnext, pc); // pc = pcnext (on end of cycle)
    adder       pcadd1(pc, 16'b1, pcplus1); // pcplus1 = pc + 1
    // signext #(n, 4)    brext(instr[3:0], branchextended);
    adder       pcaddbranch(pcplus1, {12'b0, instr[3:0]}, pcbranch); // pcbranch = pcplus1 + reg[ins[3:0]]
    mux2 #(n)   pcbrmux(pcplus1, pcbranch, branchcheck, pcnextbr); // pcnextbr = pcsrc == 0 ? pcplus1 : pcbranch
    mux2 #(n)   pcjrmux(pcnextbr, srca, jump, pcnext); // pcnext = jump == 0 ? reg[ins[11:8]] : pcnextbr

    // register file logic
    regfile     rf(clk, regwrite, instr[11:8], instr[7:4], writereg, result, srca, writedata);
	mux2 #(4)   wrmux(instr[11:8], instr[3:0], regdst, writereg);
    mux2 #(n)   resmux(aluout, readdata, memtoreg, result);

    // alu logic and i-type logic
	signext     se(instr[7:0], signimm);
    mux2 #(n)   srcbmux(writedata, signimm, alusrc, srcb);
	alu         alu(clk, srca, srcb, instr[15:12], aluout, zero);

endmodule

`endif // DATAPATH
