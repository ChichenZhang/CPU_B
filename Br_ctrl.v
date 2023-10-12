`timescale 1ns / 1ps



module Br_ctrl(
    input wire [15:0] jump_offset,
    input wire jump_en,
    
    output reg [15:0] jump_offset_o,
    output reg jump_en_o

    );
    
    always @(*) begin
        jump_offset_o = jump_offset;
        jump_en_o = jump_en; 
    end
    
endmodule
