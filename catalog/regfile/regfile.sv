//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// Engineer: Evan Rosenfeld, James Ryan
// 
//     Create Date: 2023-02-07
//     Module Name: regfile
//     Description: 32-bit RISC register file
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef REGFILE
`define REGFILE

`timescale 1ns/100ps

module regfile
    // n=bit length of register; r=bit length of addr of registers
    #(parameter n = 16, parameter r = 4)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic        clk, 
    input  logic        we3, 
    input  logic [(r-1):0] ra1, ra2, wa3, 
	input  logic [(n-1):0] wd3, 
    output logic [(n-1):0] rd1, rd2
    );
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [(n-1):0] rf[(2**r-1):0];
	
	initial begin
		int i;
		for (i = 0; i < (2**r); i = i + 1) begin
		  rf[i] <= '0;
		end
	end

    // three ported register file
    // read two ports combinationally
    // write third port on rising edge of clk
    // register 0 hardwired to 0
    // note: for pipelined processor, write third port
    // on falling edge of clk

    always @(posedge clk) begin
        if (we3) begin
            rf[wa3] <= wd3;
        end
    end

    assign rd1 = (ra1 != 0) ? rf[ra1] : 0;
    assign rd2 = (ra2 != 0) ? rf[ra2] : 0;
endmodule

`endif // REGFILE
