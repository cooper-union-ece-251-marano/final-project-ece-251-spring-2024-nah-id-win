//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: dffn
//     Description: 32 bit D flip flop with additional assignment on negetive edge
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef DFFN
`define DFFN

`timescale 1ns/100ps

module dffn
    #(parameter n = 16)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic CLOCK, RESET,
    input  logic [(n-1):0] D_on_neg_edge,
    input  logic [(n-1):0] D,
    output logic [(n-1):0] Q
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    always @(posedge RESET) begin
        Q <= 0;
    end

    always @(posedge CLOCK) begin
        Q <= D;
    end

    always @(negedge CLOCK) begin
        Q <= D_on_neg_edge;
    end
endmodule

`endif // DFF
