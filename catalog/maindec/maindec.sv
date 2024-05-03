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
    #(parameter n = 32)(
    //
    // ---------------- PORT DEFINITIONS ----------------
    //
    input  logic [4:0] op,
    output logic       memtoreg, memwrite,
    output logic       branch,
    output logic       regdst, regwrite,
    output logic       jump,
    output logic [3:0] aluop
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [8:0] controls; // 9-bit control vector

    // controls has 9 logical signals
    assign {regwrite, regdst, branch, memwrite,
            memtoreg, jump, aluop} = controls;

    always @* begin
        case(op[4:0])
            5'b00000: controls <= 10'b0000000000; // NOOP
            5'b00001: controls <= 10'b0000010000; // JR
            5'b00010: controls <= 10'b0010001001; // BNE
            5'b00011: controls <= 10'b0010001000; // BE
            5'b00100: controls <= 10'b0010001010; // BL
            5'b00101: controls <= 10'b0010001011; // BG
            5'b00110: controls <= 10'b0010001100; // BLE
            5'b00111: controls <= 10'b0010001101; // BGE
            5'b01001: controls <= 10'b0000001110; // LIHI
            5'b01010: controls <= 10'b0000001111; // LILO
            5'b01110: controls <= 10'b1000100000; // LW
            5'b01111: controls <= 10'b0001000000; // SW
            5'b10010: controls <= 10'b1000000111; // RST
            5'b10011: controls <= 10'b1100000000; // ADD
            5'b10110: controls <= 10'b1100000011; // XOR
            5'b10111: controls <= 10'b1100000001; // AND
            5'b11000: controls <= 10'b1100000010; // OR
            5'b11010: controls <= 10'b1000000100; // MULT
            5'b11110: controls <= 10'b1100000101; // SLL
            5'b11111: controls <= 10'b1100000110; // SLR
            default: controls <= 10'bxxxxxxxxxx; // inavlid instruction
        endcase
    end

endmodule

`endif // MAINDEC
