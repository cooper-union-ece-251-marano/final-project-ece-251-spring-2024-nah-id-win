//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: tb_mux2
//     Description: Test bench for 2 to 1 multiplexer
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_MUX2
`define TB_MUX2

`timescale 1ns/100ps
`include "mux2.sv"
`include "../clock/clock.sv"

module tb_mux2;
    parameter n = 16; // #bits for an operand
    logic s;
    logic [(n-1):0] d0, d1;
    logic [(n-1):0] y;
    wire clk;
    logic enable;


   initial begin
        $dumpfile("mux2.vcd");
        $dumpvars(0, uut0, uut1);
        // $monitor("s = %0b d0 = (0x%0h)(%0d) d1 = (0x%0h)(%0d) y = (0x%0h)(%0d)", s, d0, d0, d1, d1, y, y);
        $monitor("time=%0t \t enable=%0b s=%0b y=%h d0=%h d1=%h",$realtime, enable, s, y, d0, d1);
    end

    initial begin
        d0 <= #n'h80000000;
        d1 <= #n'h00000001;
        enable <= 0;
        #10 enable <= 1;
        #10 s <= 1'b0;
        #20 s <= 1'b1;
        #100 enable <= 0;
        $finish;
    end

    mux2 uut0(
        .S(s), .D0(d0), .D1(d1), .Y(y)
    );
    clock uut1(
        .ENABLE(enable),
        .CLOCK(clk)
    );
endmodule
`endif // TB_MUX2