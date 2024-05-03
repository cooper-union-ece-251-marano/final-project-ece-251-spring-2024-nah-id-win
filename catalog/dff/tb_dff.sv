//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: tb_dff
//     Description: Test bench for 32 bit D flip flop
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_DFF
`define TB_DFF

`timescale 1ns/100ps
`include "dff.sv"
`include "../clock/clock.sv"

module tb_dff;
    parameter n = 16; // #bits for an operand
    wire clk;
    logic enable;
    logic reset;
    logic [(n-1):0] d;
    logic [(n-1):0] q;

   initial begin
        $dumpfile("dff.vcd");
        $dumpvars(0, uut0, uut1);
        //$monitor("d = %b (0x%0h)(%0d) q = %b (0x%0h)(%0d) ", d,d,d,q,q,q);
        $monitor("time=%0t \t d=%h q=%h",$realtime, d, q);
    end

    initial begin
        d <= #n'h8000;
        enable <= 0;
        #10 enable <= 1;
        #10 reset <= 1;
        #20 d <= #n'h0001;
        #10 reset <= 0;
        #10 reset <=0;
        #20 d <= #n'h0001;
        #100 enable <= 0;
        $finish;        
    end

    dff uut0(
        .CLOCK(clk), .RESET(reset), .D(d), .Q(q)
    );

   clock uut1(
        .ENABLE(enable),
        .CLOCK(clk)
    );
endmodule
`endif // TB_DFF