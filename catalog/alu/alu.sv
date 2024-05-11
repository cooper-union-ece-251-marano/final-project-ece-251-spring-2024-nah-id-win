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
	
	input clk,
	input [(n-1):0] src1, 	
	input [(n-1):0] src2,
	input [c_w-1:0] aluop,
	
	output reg [(n-1):0] dest,
	output reg zero
	//output reg [n-1:0] overflow
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //

	reg [n-1:0] Hi;
	reg [n-1:0] Lo;


	always@(posedge clk) begin
			case (aluop)
				4'b1000: begin //LI
					dest <= src1 + src2;
					zero <= 1'b0;
				end
				4'b1001: begin //ADD
					dest <= src1 + src2;
					zero <= src1 == src2 ? 1'b1 : 1'b0;
				end
				4'b1010: begin //XOR
					dest <= src1 ^ src2;
					zero <= src1 == src2 ? 1'b1 : 1'b0;
				end
				4'b1011: begin //AND
					dest <= src1 & src2;
					zero <= src1 == src2 ? 1'b1 : 1'b0;
				end
				4'b1100: begin //OR
					dest <= src1 | src2;
					zero <= src1 == src2 ? 1'b1 : 1'b0;
				end
				4'b1101: begin //MULT
					dest <= src1 * src2;
					zero <= src1 == src2 ? 1'b1 : 1'b0;
				end
				4'b1110: begin //SLL
					dest <= src1 << src2;
					zero <= src1 == src2 ? 1'b1 : 1'b0;
				end
				4'b1111: begin //SLR
					dest <= src1 >> src2;
					zero <= src1 == src2 ? 1'b1 : 1'b0;
				end
				4'b0001: begin //JR
					dest <= src1;
					zero <= 1'd0;
				end
				default: begin
					dest <= {n{1'bz}};
					zero <= 1'b0;				
				end
			endcase
	end

endmodule

`endif // ALU
