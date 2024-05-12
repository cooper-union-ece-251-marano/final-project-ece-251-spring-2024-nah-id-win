//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: tb_dmem
//     Description: Test bench for data memory
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef TB_DMEM
`define TB_DMEM

`timescale 1ns/100ps
`include "dmem.sv"
`include "../clock/clock.sv"

module tb_dmem;
    parameter n = 16; // bit length of registers/memory
    parameter r = 6; // we are only addressing 64=2**6 mem slots in imem
    logic [(n-1):0] readdata, writedata;
    logic [(n-1):0] dmem_addr;
    logic write_enable;
    logic clk, clock_enable;

   initial begin
        $dumpfile("dmem.vcd");
        $dumpvars(0, uut, uut1);
        $monitor("time=%0t write_enable=%b dmem_addr=%h readdata=%h writedata=%h",
            $realtime, write_enable, dmem_addr, readdata, writedata);
    end

    initial begin
        #10 clock_enable <= 1;
        #20 writedata = #(n)'hFFFFFFFF;
        #20 dmem_addr <= #(r)'b000000;
        #20 write_enable <= 1;
        #20 write_enable <= 0;
        #20 dmem_addr <= #(r)'b000001;
        #20 writedata = #(n)'h0000FFFF;
        #20 write_enable <= 1;
        #20 write_enable <= 0;
        #20 dmem_addr <= #(r)'b000010;
        #20 writedata = #(n)'h00000000;
        #20 write_enable <= 1;
        #20 write_enable <= 0;
        #20 $finish;
    end

   dmem uut(
        .clk(clk),
        .write_enable(write_enable),
        .addr(dmem_addr),
        .writedata(writedata),
        .readdata(readdata)
    );
    clock uut1(
        .ENABLE(clock_enable),
        .CLOCK(clk)
    );
endmodule

`endif // TB_IMEM