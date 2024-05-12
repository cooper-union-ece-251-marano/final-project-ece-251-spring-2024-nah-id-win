//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: computer
//     Description: 32-bit RISC
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef COMPUTER
`define COMPUTER

`include "../definitions/definitions.sv"
`timescale 1ns/100ps

`include "../cpu/cpu.sv"
`include "../imem/imem.sv"
`include "../dmem/dmem.sv"

module computer
    #(parameter n = `WORDSIZE)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic           clk, reset, 
    output logic [(n-1):0] writedata, dataadr, 
    output logic           memwrite
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [(n-1):0] pc, instr, readdata, aluout;

    // computer internal components

    cpu mips(.clk(clk), .reset(reset), .pc(pc), .instr(instr), 
	         .memwrite(memwrite), .dataadr(dataadr), .aluout(aluout), 
			 .writedata(writedata), .readdata(readdata));
    
	// the instruction memory ("text segment") in main memory
    imem imem(pc[7:1], instr);
    // the data memory ("data segment") in main memory
    dmem dmem(clk, memwrite, dataadr, writedata, readdata);

endmodule

`endif // COMPUTER
