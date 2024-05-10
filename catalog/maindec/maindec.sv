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
    input  logic [3:0] op,
    
	output logic       mem2reg, memwrite, memread,
    output logic       alusrc,
    output logic       regdst, regwrite,
    output logic       branch,
    output logic       jumpr
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [7:0] controls; // 7-bit control vector

    // controls has 8 logical signals
    assign {regwrite, regdst, alusrc, memwrite, memread,
            mem2reg, branch, jumpr} = controls;

    always @* begin
        case(op[3:0])
            4'b0000: controls <= 8'b00000000; // NOOP
            4'b0001: controls <= 8'b00000001; // JR
            4'b0010: controls <= 8'b00000000; // JI
            4'b0011: controls <= 8'b00000010; // BE
            4'b1000: controls <= 8'b10100000; // LI
            4'b0110: controls <= 8'b00000000; // MFLO
			4'b0111: controls <= 8'b10101100; // LW
            4'b0101: controls <= 8'b0x110x00; // SW
            4'b1001: controls <= 8'b11000000; // ADD
            4'b1010: controls <= 8'b11000000; // XOR
            4'b1011: controls <= 8'b11000000; // AND
            4'b1100: controls <= 8'b11000000; // OR
            4'b1101: controls <= 8'b00000000; // MULT
            4'b1110: controls <= 8'b11000000; // SLL
            4'b1111: controls <= 8'b11000000; // SLR
            default: controls <= 8'bxxxxxxxx; // inavlid instruction
        endcase
    end

endmodule

`endif // MAINDEC
