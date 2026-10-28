`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2026 12:48:43 PM
// Design Name: 
// Module Name: ALUControl
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


module ALUControl(
    input  [1:0] ALUOp,
    input  [2:0] funct3,
    input  [6:0] funct7,
    output [3:0] ALUCtrl
    );
    
    reg [3:0] ALUCtrl;
    
    always @(*) 
    begin
        ALUCtrl = 4'b0010;   // Default value, so ALUCtrl always has a safe value (ADD)

        case (ALUOp)     // First deciding based on ALUOp from MainControl
            2'b00:        // load/store (perform ADD operation)
                begin
                ALUCtrl = 4'b0010;           
                end
            2'b01:       // BEQ  (performt subtract operation)
                begin
                ALUCtrl = 4'b0110;           
                end
            2'b10:       // R-type so  look at funct3/funct7
                begin                        
                case (funct3)
                    3'b000:     //ADD or SUB (Look at funct 7)
                        begin
                        if (funct7[5]) 
                            ALUCtrl = 4'b0110;  // SUB
                        else           
                            ALUCtrl = 4'b0010;  // ADD
                        end
                    3'b001:                 // SLL
                        begin
                        ALUCtrl = 4'b0100;  
                        end
                    3'b101:          // SRL
                        begin
                        ALUCtrl = 4'b0101;  
                        end
                    3'b111:        // AND
                        begin
                        ALUCtrl = 4'b0000;  
                        end
                    3'b110:        // OR
                        begin
                        ALUCtrl = 4'b0001;  
                        end
                    3'b100:     // XOR
                    begin
                    ALUCtrl = 4'b0011;  
                    end
                    default: ALUCtrl = 4'b0010;   // Any other funct3 go back to ADD
                endcase
            end
            2'b11:   // ADDI  (perform ADD operation)
            begin
            ALUCtrl = 4'b0010;           
            end
        endcase
    end

endmodule
