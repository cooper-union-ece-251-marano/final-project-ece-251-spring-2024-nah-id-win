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
    input  logic        memtoreg, pcsrc,
    input  logic        alusrc, regdst,
    input  logic        regwrite, jump,
    input  logic [3:0]  aluop,
    output logic        zero,
    output logic [(n-1):0] pc,
    input  logic [(n-1):0] instr,
    output logic [(n-1):0] aluout, overflow, writedata,
    input  logic [(n-1):0] readdata
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [2:0] writereg;
    logic [(n-1):0] pcnext, pcnextbr, pcplus4, pcbranch;
    logic [(n-1):0] signimm, signimmsh;
    logic [(n-1):0] srca, srcb;
    logic [(n-1):0] result;

    // "next PC" logic
    dff #(n)    pcreg(clk, reset, pcnext, pc);
    adder       pcadd1(pc, 16'b10, pcplus4);
	sl2         immsh(signimm, signimmsh);
    adder       pcadd2(pcplus4, signimmsh, pcbranch);
    mux2 #(n)   pcbrmux(pcplus4, pcbranch, pcsrc, pcnextbr);
    mux2 #(n)   pcmux(pcnextbr, {pcplus4[15:12], instr[11:0]}, jump, pcnext);

    // register file logic
    regfile     rf(clk, regwrite, instr[8:6], instr[5:3], writereg, result, srca, writedata);
    // switched between rd and our imm
	mux2 #(3)   wrmux(instr[5:3], instr[2:0], regdst, writereg);
    mux2 #(n)   resmux(aluout, readdata, memtoreg, result);
    signext     se(instr[7:0], signimm);

    // ALU logic
    mux2 #(n)   srcbmux(writedata, signimm, alusrc, srcb);
    alu         alu(clk, srca, srcb, aluop, aluout, zero, overflow);

endmodule

`endif // DATAPATH
