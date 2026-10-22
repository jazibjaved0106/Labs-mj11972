`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2026 12:47:37 PM
// Design Name: 
// Module Name: MemorySystem_tb
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


module MemorySystem_tb();

    reg clk = 0;
    reg rst = 1;
    reg [31:0] address = 0;
    reg readEnable = 0, writeEnable = 0;
    reg [31:0] writeData = 0;
    reg [15:0] switches = 0;
    wire [31:0] readData;
    wire [15:0] leds;
 
    addressDecoderTop dut (
        .clk(clk), .rst(rst),
        .address(address),
        .readEnable(readEnable), .writeEnable(writeEnable),
        .writeData(writeData),
        .switches(switches),
        .readData(readData),
        .leds(leds)
    );
 
    // 100 MHz clock
    always #5 clk = ~clk;
 
    initial begin
        // Reset
        #20 
        rst = 0;
 
        // 1) Write to Data Memory (addresses 5 and 100)
        address = 5;   
        writeData = 32'hDEADBEEF; 
        writeEnable = 1;  
        #10;
        address = 100; 
        writeData = 32'h12345678;                   
        #10;
        writeEnable = 0;
 
        // 2) Read from Data Memory
        readEnable = 1;
        address = 5;   
        #10;
        address = 100; 
        #10;
        readEnable = 0;
 
        // 3) Write to LEDs
        address = 512; 
        writeData = 32'h0000A5A5; 
        writeEnable = 1;  
        #10;
        address = 600; 
        writeData = 32'h000000FF;                   
        #10;
        writeEnable = 0;
 
        // 4) Read from Switches
        switches = 16'h1234;
        address = 768; 
        readEnable = 1;  
        #10;
        switches = 16'hFFFF;            
        #10;
        readEnable = 0;
 
        // 5) Write to a switch address (nothing should happen)
        address = 768; 
        writeData = 32'hFFFFFFFF; 
        writeEnable = 1;  
        #10;
        writeEnable = 0;
 
        // 6) Read an LED address (LEDs are write-only, readData stays 0)
        address = 512; 
        readEnable = 1;  
        #10;
        readEnable = 0;
 
        // 7) Reset clears the LEDs
        rst = 1;  
        #20;
        rst = 0;  
        #10;
 
        $finish;
    end
    
endmodule
