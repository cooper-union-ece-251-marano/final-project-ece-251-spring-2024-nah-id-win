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
    output logic       branch, alusrc,
    output logic       regdst, regwrite,
    output logic       jump,
    output logic [2:0] aluop
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [8:0] controls; // 9-bit control vector

    // controls has 9 logical signals
    assign {regwrite, regdst, alusrc, branch, memwrite,
            memtoreg, jump, aluop} = controls;

    always @* begin
        case(op[4:0])
            5'b00000: controls <= 10'b0000000000; // NOOP
            5'b00001: controls <= 10'b0000000000; // JR
            5'b00010: controls <= 10'b0000000000; // BNE
            5'b00011: controls <= 10'b0000000000; // BE
            5'b00100: controls <= 10'b0000000000; // BL
            5'b00101: controls <= 10'b0000000000; // BG
            5'b00110: controls <= 10'b0000000000; // BLE
            5'b00111: controls <= 10'b0000000000; // BGE
            5'b01000: controls <= 10'b0000000000; // HALT
            5'b01001: controls <= 10'b0000000000; // LIHI
            5'b01010: controls <= 10'b0000000000; // LILO
            5'b01110: controls <= 10'b0000000000; // LWOFF
            5'b01111: controls <= 10'b0000000000; // SWOFF
            5'b10010: controls <= 10'b0000000000; // RST
            5'b10011: controls <= 10'b0000000000; // ADD
            5'b10110: controls <= 10'b0000000000; // XOR
            5'b10111: controls <= 10'b0000000000; // AND
            5'b11000: controls <= 10'b0000000000; // OR
            5'b11001: controls <= 10'b0000000000; // SET
            5'b11010: controls <= 10'b0000000000; // MULT
            5'b11011: controls <= 10'b0000000000; // MFHI
            5'b11100: controls <= 10'b0000000000; // MFLO
            5'b11101: controls <= 10'b0000000000; // OUT
            5'b11110: controls <= 10'b0000000000; // SLL
            5'b11111: controls <= 10'b0000000000; // SLR
            default: controls <= 10'bxxxxxxxxxx; // inavlid instruction
        endcase
    end

endmodule

`endif // MAINDEC
