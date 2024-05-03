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
    #(parameter n = 16)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
	input [n-1:0] a,
	input [n-1:0] b,
	input c_in,
	input enable,

	output reg c_out,
	output reg [n-1:0] out
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
	always @(a or b or enable) begin
		if(enable) begin
			{c_out, out} = a + b + c_in;
		end else {c_out, out} = 'bz;
	end
endmodule

`endif // ADDER
