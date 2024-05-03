//////////////////////////////////////////////////////////////////////////////////
// The Cooper Union
// ECE 251 Spring 2024
// Engineer: Prof Rob Marano
// 
//     Create Date: 2023-02-07
//     Module Name: maindec
//     Description: 32-bit RISC-based CPU main decoder (MIPS)
//
// Revision: 1.0
//
//////////////////////////////////////////////////////////////////////////////////
`ifndef MAINDEC
`define MAINDEC

`timescale 1ns/100ps

module maindec
    #(parameter n = 16)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [4:0] op,
    output logic       memtoreg, memwrite,
    output logic       branch,
    output logic       regdst, regwrite,
    output logic       jump, overflow,
    output logic [3:0] aluop
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [10:0] controls; // 11-bit control vector

    // controls has 10 logical signals
    assign {regwrite, regdst, branch, memwrite,
            memtoreg, jump, aluop} = controls;

    always @* begin
        case(op[4:0])
            5'b00000: controls <= 11'b00000000000; // NOOP
            5'b00001: controls <= 11'b00000100000; // JR
            5'b00010: controls <= 11'b00100001001; // BNE
            5'b00011: controls <= 11'b00100001000; // BE
            5'b00100: controls <= 11'b00100001010; // BL
            5'b00101: controls <= 11'b00100001011; // BG
            5'b00110: controls <= 11'b00100001100; // BLE
            5'b00111: controls <= 11'b00100001101; // BGE
            5'b01010: controls <= 11'b11000001111; // LILO
            5'b01110: controls <= 11'b10001000000; // LW
            5'b01111: controls <= 11'b00010000000; // SW
            5'b10010: controls <= 11'b10000000111; // RST
            5'b10011: controls <= 11'b11000000000; // ADD
            5'b10110: controls <= 11'b11000000011; // XOR
            5'b10111: controls <= 11'b11000000001; // AND
            5'b11000: controls <= 11'b11000000010; // OR
            5'b11010: controls <= 11'b10000010100; // MULT
            5'b11110: controls <= 11'b11000000101; // SLL
            5'b11111: controls <= 11'b11000000110; // SLR
            default: controls <= 11'bxxxxxxxxxxx; // inavlid instruction
        endcase
    end

endmodule

`endif // MAINDEC
