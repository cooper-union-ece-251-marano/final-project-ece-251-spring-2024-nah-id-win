//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Evan Rosenfeld, James Ryan
// 
//     Create Date: 2023-02-07
//     Module Name: tb_alu
//     Description: Test bench for simple behavorial ALU
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_ALU
`define TB_ALU

`timescale 1ns/100ps
`include "alu.sv"
`include "../definitions/definitions.sv"

`include "../clock/clock.sv"

module tb_alu;
    parameter n = `WORDSIZE;
	parameter c_w = `CW;

	// initialize test vars
	
	reg [c_w-1:0] ALUOP;
	reg [n-1:0] SRC1;
	reg [n-1:0] SRC2;

	wire [n-1:0] DEST;
	wire ZERO;
	wire [n-1:0] OVERFLOW;

	logic clock_enable;

	clock clk(clock_enable, clk_out);

	integer i;

	initial begin: init_vars
		ALUOP = 4'b0000;
		SRC1 = 'd22;
		SRC2 = 'd10;
		clock_enable = 0;
	end
	initial begin
	    $dumpfile("tb_sll.vcd"); // for Makefile, make dump file same as module name
	    $dumpvars(0, uut);
	end
	
	// display some info during simulation
	initial begin
	    $monitor ($time,"ns, clk=%b, aluop=%b, src1=%b, src2=%b, dest=%b, zero=%b, of=%b",clk_out, ALUOP,SRC1,SRC2,DEST,ZERO,OVERFLOW);
	end
	
	initial begin: apply_stimulus
		#10
		#10 clock_enable = 1;
		for(i = 0; i < 16; i = i + 1) begin
			#5 ALUOP = i;
			#5;
		end	
		$finish;
	end

//
// ---------------- INSTANTIATE UNIT UNDER TEST (UUT) ----------------
//
alu uut(.clk(clk_out), .aluop(ALUOP), .src1(SRC1), .src2(SRC2), .dest(DEST), .zero(ZERO), .overflow(OVERFLOW));
endmodule
`endif // TB_ALU
