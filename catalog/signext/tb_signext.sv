//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: tb_signext
//     Description: Test bench for sign extender
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_SIGNEXT
`define TB_SIGNEXT

`timescale 1ns/100ps
`include "signext.sv"

module tb_sl2;
    parameter n = 16; // #bits for an operand
    parameter i = n/2; // #bits for an immediate
    logic [(i-1):0] a;
    logic [(n-1):0] y;

   initial begin
        $dumpfile("signext.vcd");
        $dumpvars(0, uut);
        //$monitor("a = %b (0x%0h)(%0d) y = %b (0x%0h)(%0d) ", a, a, a, y, y, y);
        $monitor("time=%0t \t a=%b y=%b",$realtime, a, y);
    end

    initial begin
        a <= #i'h8000;
    end

    signext uut(
        .A(a), .Y(y)
    );
endmodule
`endif // TB_SIGNEXT