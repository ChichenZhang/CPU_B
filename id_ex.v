`include "defines.v"

module id_ex(
    input clk,
    input rst,
        
    input [15:0] inst_i,
    input [3:0] inst_addr_i,
    input [15:0] op1_i,
    input [15:0] op2_i,
    input [2:0] rd_addr_i,
    input  reg_wen_i,
    
    output [15:0] inst_o,
    output [3:0] inst_addr_o,
    output [15:0] op1_o,
    output [15:0] op2_o,
    output [2:0] rd_addr_o,
    output reg_wen_o,
    
    //from ctrl
    input jump_en
);

    dff_set #(16) dff1(clk, rst, jump_en, `NOP, inst_i, inst_o);
    dff_set #(.DW(4)) dff2(clk, rst, jump_en, 16 'b0, inst_addr_i, inst_addr_o);
    dff_set #(16) dff3(clk, rst, jump_en, 16 'b0, op1_i, op1_o);
    dff_set #(16) dff4(clk, rst, jump_en, 16 'b0, op2_i, op2_o);
    dff_set #(.DW(3)) dff5(clk, rst, jump_en, 3 'b0, rd_addr_i, rd_addr_o);
    dff_set #(.DW(1)) dff6(clk, rst, jump_en, 1 'b0, reg_wen_i, reg_wen_o);
    
endmodule