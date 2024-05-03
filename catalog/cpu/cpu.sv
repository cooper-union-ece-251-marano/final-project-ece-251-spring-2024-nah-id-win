//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// Engineer: Evan Rosenfeld, James Ryan
// 
//     Create Date: 2023-02-07
//     Module Name: cpu
//     Description: 32-bit RISC-based CPU (MIPS)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef CPU
`define CPU

`timescale 1ns/100ps

`include "../controller/controller.sv"
`include "../datapath/datapath.sv"

module cpu
    #(parameter n = 16)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic           clk, reset,
    output logic [(n-1):0] pc,
    input  logic [(n-1):0] instr,
    output logic           memwrite,
    output logic [(n-1):0] aluout, writedata,
    input  logic [(n-1):0] readdata
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //

    // cpu internal components
    logic       memtoreg, alusrc, regdst, regwrite, jump, overflow, pcsrc, zero;
    logic [3:0] alucontrol;
    logic branch;
    
    controller c(instr[4:0], branch, memtoreg, memwrite,
                    regdst, regwrite, jump, overflow,
                    alucontrol, zero);

    datapath dp(clk, reset, memtoreg, pcsrc,
                    alusrc, regdst, regwrite, jump,
                    alucontrol,
                    zero, overflow, pc, instr,
                    aluout, writedata, readdata, branch);

endmodule

`endif // CPU
