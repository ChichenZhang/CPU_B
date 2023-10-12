`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/09/17 15:03:16
// Design Name: 
// Module Name: PC_reg
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


module PC_reg(
    input wire clk,
    input wire rst,
    
    // from ctrl
    input wire jump_en,
    input wire [5:0] jump_offset,
    
    output reg[3:0] pc_o
    );
    
    always @(posedge clk) begin
        if (rst == 1 'b0) begin
            pc_o <= 4 'b0;
        end else if (jump_en) begin
            pc_o <= pc_o - jump_offset[3:0] - 2;
        end else begin
            pc_o <= pc_o + 4 'd1;
        end
    end
endmodule
