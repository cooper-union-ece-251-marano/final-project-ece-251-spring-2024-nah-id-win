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
    output logic       branch
);
    //
    // ---------------- MODULE DESIGN IMPLEMENTATION ----------------
    //
    logic [6:0] controls; // 7-bit control vector

    // controls has 10 logical signals
    assign {regwrite, regdst, alusrc, memwrite, memread,
            mem2reg, branch} = controls;

    always @* begin
        case(op[3:0])
            4'b0000: controls <= 7'b0000000; // NOOP
            4'b0001: controls <= 7'b0000000; // JR
            4'b0010: controls <= 7'b0000000; // JI
            4'b0011: controls <= 7'b0000001; // BE
            4'b0100: controls <= 7'b0000001; // BL
            4'b1000: controls <= 7'b1010000; // LI
            4'b0110: controls <= 7'b0000000; // MFLO
			4'b0111: controls <= 7'b1010110; // LW
            4'b0101: controls <= 7'b0x110x0; // SW
            4'b1001: controls <= 7'b1100000; // ADD
            4'b1010: controls <= 7'b1100000; // XOR
            4'b1011: controls <= 7'b1100000; // AND
            4'b1100: controls <= 7'b1100000; // OR
            4'b1101: controls <= 7'b0000000; // MULT
            4'b1110: controls <= 7'b1100000; // SLL
            4'b1111: controls <= 7'b1100000; // SLR
            default: controls <= 7'bxxxxxxx; // inavlid instruction
        endcase
    end

endmodule

`endif // MAINDEC
