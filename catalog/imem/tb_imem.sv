//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: tb_imem
//     Description: Test bench for instruction memory
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_IMEM
`define TB_IMEM

`timescale 1ns/100ps
`include "imem.sv"

module tb_imem;
    parameter n = 16; // bit length of registers/memory
    parameter r = 6; // we are only addressing 64=2**6 mem slots in imem
    logic [(n-1):0] readdata;
    logic [(r-1):0] imem_addr;

   initial begin
        $dumpfile("imem.vcd");
        $dumpvars(0, uut);
        //$monitor("enable = %b clk = %b", enable, clk);
        $monitor("time=%0t \t imem_addr=%b readdata=%h",$realtime, imem_addr, readdata);
    end

    initial begin
        #10 imem_addr <= #(r)'b000000;
        #10 imem_addr <= #(r)'b000001;
        #10 imem_addr <= #(r)'b000010;
        $finish;
    end

   imem uut(
        .addr(imem_addr),
        .readdata(readdata)
    );
endmodule

`endif // TB_IMEM