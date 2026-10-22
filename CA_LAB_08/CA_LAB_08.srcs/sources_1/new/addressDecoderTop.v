`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/21/2026 02:40:15 AM
// Design Name: 
// Module Name: addressDecoderTop
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


module addressDecoderTop(
    input clk, rst,
    input [31:0] address,             //address recived from the CPU
    input readEnable, writeEnable,   // CPU wants to read/write
    input [31:0] writeData,        // data from the CPU to write
    input [15:0] switches,          //switches on the board
    
    output [31:0] readData,     //data returned to the CPU to read
    output [15:0] leds          //LEDs on the board
    );
    
    
    // Enable signals from the decoder for each device
    wire DataMemWrite, DataMemRead, LEDWrite, SwitchReadEnable;
 
    // Data coming back from each device that can be read (from Data memory or switch interface)
    wire [31:0] memData, switchData;
 
    // 1. Address decoder
    AddressDecoder decoder (
        .address(address),
        .readEnable(readEnable),
        .writeEnable(writeEnable),
        .DataMemWrite(DataMemWrite),
        .DataMemRead(DataMemRead),
        .LEDWrite(LEDWrite),
        .SwitchReadEnable(SwitchReadEnable)
    );
 
    // 2. Data memory (uses the lower 9 bits of the address)
    // Only writes when DataMemWrite=1
    DataMemory dmem (
        .clk(clk),
        .MemWrite(DataMemWrite),
        .address(address[8:0]),
        .write_data(writeData),
        .read_data(memData)
    );
 
    // 3. Switch interface from Lab 5 (module is called "leds", but it is the one that reads the switches 
    leds switch_reader (
        .clk(clk), .rst(rst),
        .btns(16'd0),       //unused(set to zero)
        .writeData(32'd0),  //unused(set to zero)
        .writeEnable(1'b0), //unused(set to zero)
        .readEnable(SwitchReadEnable),  //enabled for address locations 768-1023
        .memAddress(address[29:0]),
        .switches(switches),
        .readData(switchData)  //switch data sent to read mux
    );
 
    // 4. LED interface from Lab 5 (module is called "switches", but it is the one that drives the LEDs)
    switches led_writer (
        .clk(clk), .rst(rst),
        .writeData(writeData),
        .writeEnable(LEDWrite),      //updates LEDs when LEDWrite=1 (address locations 512-767)
        .readEnable(1'b0),            // LEDs are write-only so set to 0
        .memAddress(address[29:0]),
        .readData(),                 //unused so not connected   
        .leds(leds)
    );
 
    // 5.  Read Data Mux : Chooses which device's data ( Data memory or switch interface) goes back to the CPU
    // if DataMemRead=1 -> data memeory data
    // else if SwitchReadEnable=1 -> Switch interface data
    /// else -> 0  
    assign readData = DataMemRead ?  memData : SwitchReadEnable ? switchData : 32'd0;
    
    
    
    
endmodule
