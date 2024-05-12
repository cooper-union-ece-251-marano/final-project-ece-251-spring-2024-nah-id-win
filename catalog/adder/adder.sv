//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Evan Rosenfeld, James Ryan
// 
//     Create Date: 2023-02-07
//     Module Name: adder
//     Description: simple behavorial adder
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef ADDER
`define ADDER

`timescale 1ns/100ps

module adder
    #(parameter n = `WORDSIZE)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
	input [n-1:0] a,
	input [n-1:0] b,

	output reg [n-1:0] out
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
	always @(a or b) begin
		out = a + b; 
	end
endmodule

`endif // ADDER
