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
    #(parameter n = 16)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic        clk, reset,
    input  logic        memtoreg,
    input  logic        alusrc, regdst,
    input  logic        regwrite, jump,
    input  logic [3:0]  alucontrol,
    output logic        zero,
    output logic [(n-1):0] pc,
    input  logic [(n-1):0] instr,
    output logic [(n-1):0] aluout, writedata,
    input  logic [(n-1):0] readdata,
    input  logic           branch
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [2:0]  writereg;
    logic [(n-1):0] pcnext, pcnextbr, pcplus1, pcbranch;
    logic [(n-1):0] signimm, signimmsh;
    logic [(n-1):0] srca, srcb;
    logic [(n-1):0] result;
    logic [(n-1):0] jr;
    logic [n-1:0] overflow;
    logic carry_out;
    logic overflow_flag;
    logic pcsrc;

    // "next PC" logic
    dff #(n)    pcreg(clk, reset, pcnext, pc);
    adder       pcadd1(pc, 16'b1, 1'b0, 1'b1, carry_out, pcplus1);
    mux2 #(n)   pcbrmux(pcplus1, pcbranch, pcsrc, pcnextbr);
    mux2 #(n)   pcmux(pcnextbr, rf.rf[jr], jump, pcnext);

    // register file logic
    regfile     rf(clk, regwrite, instr[8:6], instr[5:3], writereg, result, srca, writedata);
    mux2 #(3)   wrmux(instr[5:3], instr[2:0], regdst, writereg);
    mux2 #(n)   resmux(aluout, readdata, memtoreg, result);
    signext #(n, 8)     se(instr[7:0], signimm);
    
    always @(overflow_flag or overflow or branch or zero) begin
        if (overflow_flag) begin
            rf.rf[7] = overflow;
        end
        pcsrc = branch & zero;
    end

    // ALU logic
    // mux2 #(n)   srcbmux(writedata, signimm, alusrc, srcb);
    alu         alu(clk, srca, srcb, alucontrol, aluout, zero, overflow);

endmodule

`endif // DATAPATH