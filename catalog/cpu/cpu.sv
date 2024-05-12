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
    #(parameter n = `WORDSIZE)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic           clk, reset,
    input  logic [(n-1):0] instr,
    input  logic [(n-1):0] readdata,
	
	output logic [(n-1):0] dataadr,
	output logic [(n-1):0] pc,
    output logic           memwrite,
    output logic [(n-1):0] aluout, writedata
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //

    // cpu internal components
    logic       memtoreg, alusrc, regdst, regwrite, branch, zero, pcsrc, jump;
	//logic [n-1:0] overflow;

	//ctrl in: instr, zero
	//out: regdst, branch, memread, mem2reg, memwrite, alusrc, regwrite, pcsrc 
    controller c(instr[15:12],
                    memtoreg, memwrite, memread,
                    alusrc, regdst, regwrite, 
                    branch, jump);

	//dp in: clk, reset, inst, ALL ctrl signals
	//dp out: 
    datapath dp(clk, reset, memtoreg,
                    alusrc, regdst, regwrite, branch,
                    instr, readdata, zero, pc,
                    aluout, writedata, jump);

endmodule

`endif // CPU
