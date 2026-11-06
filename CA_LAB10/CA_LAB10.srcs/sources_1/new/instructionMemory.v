`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2026 04:16:26 PM
// Design Name: 
// Module Name: instructionMemory
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


module instructionMemory #( 
    parameter OPERAND_LENGTH = 31            // address width: 32 bits (bits 31 down to 0)
    )(input [OPERAND_LENGTH:0] instAddress,  // address of the instruction we want (the PC)
    output reg [31:0] instruction            // the 32-bit instruction we send back
); 
    // 256 bytes, each instruction is 4bytes so room for 64 instructions (our program uses 63)
    reg [7:0] memory [0:255];
 
    integer i;
    initial begin
        // Clearing everything to 0 so nothin left undefined
        for (i = 0; i < 256; i = i + 1)
            memory[i] = 8'h00;
        // then loading the program (The file has one byte per line, lowest byte of each instruction first)
        $readmemh("program.mem", memory);
    end
 
    // Reading is continuous: whenever the address changes, the instruction updates.
    // We glue 4 bytes together to make one 32-bit instruction.
    // RISC-V stores the lowest byte first (little-endian), so the byte at
    // the lowest address goes at the right end of the instruction.
    always @(*) begin
        instruction = {memory[instAddress + 3],   // highest byte, goes on the left
                       memory[instAddress + 2],
                       memory[instAddress + 1],
                       memory[instAddress]};     // lowest byte, goes on the right
    
    end
endmodule
