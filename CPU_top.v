`timescale 1ns / 1ps
`include "PC_reg.v"
`include "ifetch.v"
`include "if_id.v"
`include "id.v"
`include "id.v"
`include "regs.v"
`include "id_ex.v"
`include "ex.v"

module CPU_top(
    input clk,
    input rst_n,
    
    input [15:0] inst_i,
    output [3:0] inst_addr_o
);
    
    // pc to if
    wire [15:0] pc_reg_pc_o;
    
    // ctrl to all sequential logic part
    wire [5:0] ctrl_jump_offset_o;
    wire ctrl_jump_en_o;
    
    (* DONT_TOUCH= "{ture|yes}" *)
    PC_reg PC_reg_inst(
        .clk (clk),
        .rst (rst_n),
        
        .jump_en (ctrl_jump_en_o),
        .jump_offset (ctrl_jump_offset_o),
        
        .pc_o (pc_reg_pc_o)
);
    
    //if to id
    wire [3:0] if_inst_addr_o;
    wire [15:0] if_inst_o;
    
    // Instantiate the ifetch module
    (* DONT_TOUCH= "{ture|yes}" *)
    ifetch ifetch_inst(
        // from pc
        .addr_i (pc_reg_pc_o),
        
        // from rom
        .inst_i (inst_i),
        
        // to rom
        .addr_o2rom (inst_addr_o),
        
        //to if_id
        .inst_o (if_inst_o),
        .addr_o2id (if_inst_addr_o)

);
    
    // if_id to id
    wire [3:0] if_id_inst_addr_o;
    wire [15:0] if_id_inst_o;
    
    (* DONT_TOUCH= "{ture|yes}" *)
    if_id if_id_inst(
        .clk (clk),
        .rst (rst_n),
        
        .inst_i (if_inst_o),
        .inst_addr_i (if_inst_addr_o),
        .inst_o (if_id_inst_o),
        .inst_addr_o (if_id_inst_addr_o),
        
        .jump_en(ctrl_jump_en_o)
);
    
    // id to regs
    wire [2:0] id_regs_rs1_addr;
    wire [2:0] id_regs_rs2_addr;
    
    // id to id_ex
    wire [15:0] id_ex_inst_o;
    wire [3:0] id_ex_inst_addr_o;
    wire [15:0] id_ex_op1_o;
    wire [15:0] id_ex_op2_o;
    wire [15:0] id_ex_rd_addr_o;
    wire id_ex_reg_wen;
    
    // regs to id
    wire [15:0] regs_id_op1_o;
    wire [15:0] regs_id_op2_o;
    
    (* DONT_TOUCH= "{ture|yes}" *)
    id id_inst(
        // from if_id
        .inst_i (if_id_inst_o),
        .inst_addr_i (if_id_inst_addr_o),
        
        // to regs
        .rs1_addr_o (id_regs_rs1_addr),
        .rs2_addr_o (id_regs_rs2_addr),
        
        // from regs
        .rs1_i (regs_id_op1_o),
        .rs2_i (regs_id_op2_o),
        
        // to id_ex
        .inst_o (id_ex_inst_o),
        .inst_addr_o (id_ex_inst_addr_o),
        .op1_o (id_ex_op1_o),
        .op2_o (id_ex_op2_o),
        .rd_addr_o (id_ex_rd_addr_o),
        .reg_wen (id_ex_reg_wen)
);
    
    // ex to regs
    wire [2:0] ex_regs_rd_addr_o;
    wire [15:0] ex_regs_rd_data_o;
    wire ex_regs_rd_wen_o;
    
    (* DONT_TOUCH= "{ture|yes}" *)
    regs regs_inst(
        .clk (clk),
        .rst (rst_n),
        
        // from id
        .rs1_addr_i (id_regs_rs1_addr),
        .rs2_addr_i (id_regs_rs2_addr),
        
        // to id
        .op1_o (regs_id_op1_o),
        .op2_o (regs_id_op2_o),
        
        // write
        .wen (ex_regs_rd_wen_o),
        .rd_addr (ex_regs_rd_addr_o),
        .rd_data (ex_regs_rd_data_o)

);

    // id_ex to ex
    wire [15:0] id_ex_ex_inst_o;
    wire [3:0] id_ex_ex_inst_addr_o;
    wire [15:0] id_ex_ex_op1_o;
    wire [15:0] id_ex_ex_op2_o;
    wire [15:0] id_ex_ex_rd_addr_o;
    wire id_ex_ex_reg_wen;
    
    (* DONT_TOUCH= "{ture|yes}" *)
    id_ex id_ex_inst(
        .clk (clk),
        .rst (rst_n),
            
        .inst_i (id_ex_inst_o),
        .inst_addr_i (id_ex_inst_addr_o),
        .op1_i (id_ex_op1_o),
        .op2_i (id_ex_op2_o),
        .rd_addr_i (id_ex_rd_addr_o),
        .reg_wen_i (id_ex_reg_wen),
        
        .inst_o (id_ex_ex_inst_o),
        .inst_addr_o (id_ex_ex_inst_addr_o),
        .op1_o (id_ex_ex_op1_o),
        .op2_o (id_ex_ex_op2_o),
        .rd_addr_o (id_ex_ex_rd_addr_o),
        .reg_wen_o (id_ex_ex_reg_wen),
        
        .jump_en(ctrl_jump_en_o)
);

    wire [5:0] ex_ctrl_jump_offset;
    wire ex_ctrl_jump_en;

    (* DONT_TOUCH= "{ture|yes}" *)
    ex ex_inst(
        .inst_i (id_ex_ex_inst_o),
        .inst_addr_i (id_ex_ex_inst_addr_o),
        .op1_i (id_ex_ex_op1_o),
        .op2_i (id_ex_ex_op2_o),
        .rd_addr_i (id_ex_ex_rd_addr_o),
        .reg_wen_i (id_ex_ex_reg_wen),
        
        .rd_addr_o (ex_regs_rd_addr_o),
        .rd_data_o (ex_regs_rd_data_o),
        .rd_wen_o (ex_regs_rd_wen_o),
        
        .jump_offset (ex_ctrl_jump_offset),
        .jump_en (ex_ctrl_jump_en)
);
    
    (* DONT_TOUCH= "{ture|yes}" *)
    Br_ctrl Br_ctrl_inst(
    .jump_offset (ex_ctrl_jump_offset),
    .jump_en (ex_ctrl_jump_en),
    
    .jump_offset_o (ctrl_jump_offset_o),
    .jump_en_o (ctrl_jump_en_o)
    
    
 );
    
endmodule
