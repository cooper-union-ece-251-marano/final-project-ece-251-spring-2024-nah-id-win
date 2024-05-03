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
    input  logic [4:0] op,
    input  logic       zero,
	output logic       memtoreg, memwrite,
    output logic       pcsrc, alusrc,
    output logic       regdst, regwrite,
    output logic       jump
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic       branch;
   	logic [3:0] aluop;

    // CPU main decoder
    maindec md(op, memtoreg, memwrite, branch, regdst, regwrite, jump, aluop);
    // CPU's ALU decoder
    // aludec  ad(funct, aluop, alucontrol);

  assign pcsrc = branch & zero;

endmodule

`endif // CONTROLLER
