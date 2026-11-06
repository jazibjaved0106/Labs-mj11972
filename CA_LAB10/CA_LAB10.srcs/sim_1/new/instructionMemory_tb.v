`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2026 04:34:45 PM
// Design Name: 
// Module Name: instructionMemory_tb
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


module instructionMemory_tb();
    reg  [31:0] pc;
    wire [31:0] instruction;
 
    instructionMemory uut (
        .instAddress(pc),
        .instruction(instruction)
    );
 
    initial begin
        pc = 0;
    end
 
    always begin
        #10;
        pc = pc + 4;
    end


endmodule
