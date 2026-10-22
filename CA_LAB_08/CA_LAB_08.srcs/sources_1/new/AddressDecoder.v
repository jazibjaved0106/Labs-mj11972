`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2026 02:29:45 AM
// Design Name: 
// Module Name: AddressDecoder
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


module AddressDecoder(
    input [31:0] address,  //takes 32 bit address from processor
    input readEnable,     // read signal
    input writeEnable,    // write signal
    output DataMemWrite,  // enable write to data memory
    output DataMemRead,   // enable read from data memory
    output LEDWrite,      // enable wrtie to the LED interface
    output SwitchReadEnable // enable reading from the switch interface
    );
    
    wire [1:0] Selector;  //two address bits that choose the device
    
    assign Selector = address[9:8];  //address bits 8 and 9
    
    // Combine "which device" with "read or write".
    // A signal is 1 only if both the address matches the device AND the CPU is
    // doing that operation.
    
    
     // Data Memory: addresses 0-511 (Selector 00 or 01), supports read and write
    assign DataMemWrite     = ((Selector == 2'b00) || (Selector == 2'b01)) && writeEnable;
    assign DataMemRead      = ((Selector == 2'b00) || (Selector == 2'b01)) && readEnable;
    // LEDs: addresses 512-767 (Selector 10), write only
    assign LEDWrite         = (Selector == 2'b10)    && writeEnable;
    // Switches: addresses 768-1023 (Selector 11), read only
    assign SwitchReadEnable = (Selector == 2'b11)  && readEnable;
    
endmodule
