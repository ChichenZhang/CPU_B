`include "defines.v"


module if_id(
    input clk,
    input rst,
    
    input [15:0] inst_i,
    input [3:0] inst_addr_i,
    output [15:0] inst_o,
    output [3:0] inst_addr_o,
    
    // from ctrl
    input jump_en
);

    dff_set #(16) dff1(clk, rst, jump_en, `NOP, inst_i, inst_o);
    
    dff_set #(.DW(4)) dff2(clk, rst, jump_en, 16 'b0, inst_addr_i, inst_addr_o);
    
endmodule


