//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Evan Rosenfeld, James Ryan
// 
//     Create Date: 2023-02-07
//     Module Name: alu
//     Description: 32-bit RISC-based CPU alu (MIPS)
//
// Revision: 1.0
// see https://github.com/Caskman/MIPS-Processor-in-Verilog/blob/master/ALU32Bit.v
//////////////////////////////////////////////////////////////////////////////////
`ifndef ALU
`define ALU

`timescale 1ns/100ps

module alu
    #(	parameter n = 16,
		parameter c_w = 4)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
	
	input logic [c_w-1:0] controlCommand,
	input logic [n-1:0] src1, src2,
	output logic [n-1:0] dest
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //

	always@(controlCommand, src1, src2) begin
		case (controlCommand)
			// ADD
			0:	dest <= src1 + src2;
			// AND
			1:	dest <= src1 & src2;
			// OR
			2:	dest <= src1 | src2;
			// XOR
			3:	dest <= src1 ^ src2;
			// MULT
			// HI and LO get stored in registers 4 and 5.
			// 4:		
		endcase
	end

endmodule

`endif // ALU
