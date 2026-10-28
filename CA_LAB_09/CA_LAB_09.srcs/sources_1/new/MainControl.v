`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2026 12:42:08 PM
// Design Name: 
// Module Name: MainControl
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


module MainControl(
    input [6:0] opcode,
    output RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, Branch,
    output [1:0] ALUOp
);

    reg RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, Branch;
    reg [1:0] ALUOp;
    
     always @(*) 
     begin
        // Starting with everthing off as Safe defaults (takes care of the dont care conditions)
        RegWrite = 0; 
        ALUSrc = 0; 
        MemRead = 0;
        MemWrite = 0; 
        MemtoReg = 0; 
        Branch = 0;
        ALUOp = 2'b00;

        case (opcode)
            7'b0110011:        // R-type
                begin 
                RegWrite = 1; 
                ALUOp = 2'b10;     // tell ALU control to look at funct3/funct7
                end              
            7'b0010011:        // ADDI
                begin 
                RegWrite = 1; 
                ALUSrc = 1; 
                ALUOp = 2'b11;  //I typr dor just add
                end  
            7'b0000011:            // Loads( LW/LH/LB)
                begin 
                RegWrite = 1; 
                ALUSrc = 1; 
                MemRead = 1;
                MemtoReg = 1; 
                ALUOp = 2'b00;    // ALU adds register + offset (the address)
                end              
            7'b0100011:          // Stores (SW/SH/SB)
                begin 
                ALUSrc = 1; 
                MemWrite = 1; 
                ALUOp = 2'b00;       // ALU adds register + offset (the address)
                end  
            7'b1100011:          // BEQ
                begin 
                Branch = 1; 
                ALUOp = 2'b01;     // ALU subtracts to compare the two registers
                end                
            default: ;  // unknown opcode: everything stays 0
        endcase
    end

endmodule
