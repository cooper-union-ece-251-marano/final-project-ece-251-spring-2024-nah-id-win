//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: controller
//     Description: 32-bit RISC-based CPU controller (MIPS)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef CONTROLLER
`define CONTROLLER

`timescale 1ns/100ps

`include "../maindec/maindec.sv"
`include "../aludec/aludec.sv"

module controller
    #(parameter n = 16)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [3:0] op,
    input  logic       zero,
	
	output logic       mem2reg, memwrite, memread,
    output logic       alusrc,
    output logic       regdst, regwrite,
    output logic       branch,
	output logic       pcsrc, jumpr
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
   	//logic [3:0] aluop;

    // CPU main decoder
    maindec md(.op(op), .mem2reg(mem2reg), .memwrite(memwrite), .memread(memread), 
	           .alusrc(alusrc), .regdst(regdst), .regwrite(regwrite), 
			   .branch(branch), .jumpr(jumpr));
    // CPU's ALU decoder
	// not needed in our design -- our 4 MSBs in our opcode covers this
	//	so we dont have an ALU decoder
    // aludec  ad(funct, aluop, alucontrol);

	assign pcsrc = branch & zero;

endmodule

`endif // CONTROLLER
