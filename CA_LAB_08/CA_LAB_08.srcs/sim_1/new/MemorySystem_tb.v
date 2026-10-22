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

    //inputs initialized:
    reg clk = 0;
    reg rst = 1;                  //starting with reset active
    reg [31:0] address = 0;
    reg readEnable = 0, writeEnable = 0;
    reg [31:0] writeData = 0;
    reg [15:0] switches = 0;
    
    //outputs:
    wire [31:0] readData;
    wire [15:0] leds;
    
    
    //memory system (device under test):
    addressDecoderTop dut (
        .clk(clk), .rst(rst),
        .address(address),
        .readEnable(readEnable), .writeEnable(writeEnable),
        .writeData(writeData),
        .switches(switches),
        .readData(readData),
        .leds(leds)
    );
 
    // 100 MHz clock that flips every 5ns so period is 10ns
    always #5 clk = ~clk;
 
    initial begin
        // holds Reset for 20ns then releases it
        #20 
        rst = 0;
 
        // Write to Data Memory at addresses 5 and 100
        //    DataMemWrite=1, LEDWrite=0
        address = 5;   
        writeData = 32'hFFFFFFFF; 
        writeEnable = 1;  
        #10;                       //FFFFFFFF stored at address 5
        address = 100; 
        writeData = 32'h12345678;                   
        #10;                      //12345678 stored at address 100
        writeEnable = 0;
 
        // Read from Data Memory
        readEnable = 1;
        address = 5;      // readData=FFFFFFFF
        #10;
        address = 100;    // readData=12345678
        #10;
        readEnable = 0;
 
        // Write to LEDs at addresses 512 and 600
        //  LEDWrite = 1 , DataMemWrite=0
        address = 512; 
        writeData = 32'hAAAAAAAA; 
        writeEnable = 1;  
        #10;                  //AAAAAAAA stored at address 512 (LEDs show AAAA)
        address = 600; 
        writeData = 32'hBBBBBBBB;                   
        #10;                 //BBBBBBBB stored at address 600  (LEDs show BBBB)
        writeEnable = 0;
 
        // Read from Switches
        switches = 16'h1234;
        address = 768; 
        readEnable = 1;  
        #10;                 //readData=00001234
        switches = 16'hFFFF;   //changes value while reading         
        #10;                 //readData=0000FFFF
        readEnable = 0;
 
        // Write to a switch address (nothing should happen)
        address = 768; 
        writeData = 32'hFFFFFFFF; 
        writeEnable = 1;  
        #10;
        writeEnable = 0;
 
        // Read an LED address (LEDs are write-only)
        address = 512; 
        readEnable = 1;  
        #10;    // readData stays 0
        readEnable = 0;
 
        // Reset clears the LEDs
        rst = 1;  
        #20;        //LEds go to zero
        rst = 0;  
        #10;
 
        $finish;
    end
    
endmodule
