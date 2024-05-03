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

`include "../definitions/definitions.sv"

module alu
    #(parameter n = `WORDSIZE, parameter c_w = `CW)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
	
	input [c_w-1:0] aluop,
	input [n-1:0] src1, 	
	input [n-1:0] src2,

	output reg [n-1:0] dest,
	output reg zero,
	output reg [n-1:0] overflow
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //

	always@(aluop, src1, src2) begin
		case (aluop)
			'd0: begin	//ADD
				{overflow, dest} = src1 + src2;
				zero = 1'b0;
			end
			'd1: begin	//AND 
				dest = src1 & src2;
				overflow = 'bz;
				zero = 1'b0;
			end
			'd2: begin	//OR
				dest = src1 | src2;
				overflow = 'bz;	
				zero = 1'b0;		
			end
			'd3: begin	//XOR
				dest = src1 ^ src2;
				overflow = 'bz;
				zero = 1'b0;
			end
			'd4: begin	//MULT	
				{overflow, dest} = src1 * src2;
				zero = 1'b0;
			end
			'd5: begin	//SLL
				dest = src1 << src2;
				overflow = 'bz;
				zero = 1'b0;
			end
			'd6: begin	//SLR
				dest = src1 >> src2;
				overflow = 'bz;
				zero = 1'b0;
			end
			'd7: begin	//RST
				dest = 'b0;
				overflow = 'bz;
				zero = 1'b0;
			end
			'd8: begin
				dest = 'bz;
				overflow = 'bz;
				zero = (src1 == src2); //BE
			end
			'd9: begin 
				dest = 'bz;
				overflow = 'bz;
				zero = (src1 != src2); //BNE
			end
			'd10: begin
				dest = 'bz;
				overflow = 'bz;
				zero = (src1 < src2); //BL
			end
			'd11: begin 
				dest = 'bz;
				overflow = 'bz;
				zero = (src1 > src2); //BG
			end
			'd12: begin
				dest = 'bz;
				overflow = 'bz;
				zero = (src1 <= src2); //BLE
			end
			'd13: begin
				dest = 'bz;
				overflow = 'bz;
				zero = (src1 >= src2); //BGE
			end
			'd14: begin
				dest[(n/2)-1:0] = src1; //LIHI
				overflow = 'bz;
				zero = 'b0;
			end
			'd15: begin
				dest[n-1:(n/2)] = src1; //LILO
				overflow = 'bz;
				zero = 'b0;
			end
			default: begin
				dest = 'bz;
				overflow = 'bz; 
				zero = 'b0;
			end
		endcase
	end

endmodule

`endif // ALU
