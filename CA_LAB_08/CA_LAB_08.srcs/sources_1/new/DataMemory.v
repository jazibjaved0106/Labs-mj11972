`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2026 02:14:41 AM
// Design Name: 
// Module Name: DataMemory
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


module DataMemory(
    input clk,                //synchronous write signal
    input [8:0] address,      // uses last 9 bits of address: 2^9=512  (address range 0-511)
    input [31:0] write_data,  // data to store in memory
    input MemWrite,           //write enable = 1 : store write_data, 0: display read_data
    output [31:0] read_data   // data stored at the current address,
    );
    
    //Declaration of memory array : 512 locations each 32 bits wide.
    reg [31:0] mem[0:511];
    
    // Set every location in memory to zero at the start.
    integer i;
    initial begin
        for (i = 0; i < 512; i = i + 1)
            mem[i] = 32'd0;
    end
    
     // Write:
     // On every rising clock edge if MemWrite is 1, write_data is stored at the given address
    always @(posedge clk ) begin
        if (MemWrite)
            mem[address] <= write_data;  //non blocking assignement for clocked logic
        end
 
    // Read:
    // no clock needed, always displays the data stored at the current address.
    assign read_data = mem[address];
endmodule
