`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2026 01:02:28 PM
// Design Name: 
// Module Name: Control_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Control_tb();
    // Inputs 
    reg  [6:0] opcode, funct7;
    reg  [2:0] funct3;
    // Outputs 
    wire RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, Branch;
    wire [1:0] ALUOp;
    wire [3:0] ALUCtrl;
    
    // Connecting the two modules 
    MainControl mc(opcode, RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, Branch, ALUOp);
    ALUControl  ac(ALUOp, funct3, funct7, ALUCtrl);


    initial begin
        // ADD
        opcode = 7'b0110011; funct3 = 3'b000; funct7 = 7'b0000000; #10;
        // SUB
        opcode = 7'b0110011; funct3 = 3'b000; funct7 = 7'b0100000; #10;
        // SLL
        opcode = 7'b0110011; funct3 = 3'b001; funct7 = 7'b0000000; #10;
        // SRL
        opcode = 7'b0110011; funct3 = 3'b101; funct7 = 7'b0000000; #10;
        // AND
        opcode = 7'b0110011; funct3 = 3'b111; funct7 = 7'b0000000; #10;
        // OR
        opcode = 7'b0110011; funct3 = 3'b110; funct7 = 7'b0000000; #10;
        // XOR
        opcode = 7'b0110011; funct3 = 3'b100; funct7 = 7'b0000000; #10;

        // ADDI
        opcode = 7'b0010011; funct3 = 3'b000; funct7 = 7'b0000000; #10;

        // LW
        opcode = 7'b0000011; funct3 = 3'b010; funct7 = 7'b0000000; #10;
        // LH
        opcode = 7'b0000011; funct3 = 3'b001; funct7 = 7'b0000000; #10;
        // LB
        opcode = 7'b0000011; funct3 = 3'b000; funct7 = 7'b0000000; #10;

        // SW
        opcode = 7'b0100011; funct3 = 3'b010; funct7 = 7'b0000000; #10;
        // SH
        opcode = 7'b0100011; funct3 = 3'b001; funct7 = 7'b0000000; #10;
        // SB
        opcode = 7'b0100011; funct3 = 3'b000; funct7 = 7'b0000000; #10;

        // BEQ
        opcode = 7'b1100011; funct3 = 3'b000; funct7 = 7'b0000000; #10;

        $finish;
    end



endmodule
