`include "defines.v"

module ex(
    input [15:0] inst_i,
    input [3:0] inst_addr_i,
    input [15:0] op1_i,
    input [15:0] op2_i,
    input [2:0] rd_addr_i,
    input  reg_wen_i,
    
    output reg [2:0] rd_addr_o,
    output reg [15:0] rd_data_o,
    output reg rd_wen_o,
    
    // to Br_ctrl
    output reg [5:0] jump_offset,
    output reg jump_en
);

    wire [3:0] opcode;
    wire [2:0] rd;
    wire [2:0] rs;
    wire [8:0] imm;
    wire [5:0] offset;
    
    assign opcode = inst_i[3:0];
    assign rd = inst_i[6:4];
    assign rs = inst_i[9:7];
    assign offset = inst_i[15:10];
    assign imm = inst_i[15:7];

    always @(*) begin
        case(opcode)
             `ADDI_op, `ADD_op: begin
                jump_offset = 0;
                jump_en = 0;
                rd_data_o = op1_i + op2_i;
                rd_addr_o = rd_addr_i;
                rd_wen_o = 1 'b1;
             end
             `SUB_op: begin
                jump_offset = 0;
                jump_en = 0;
                rd_data_o = op1_i - op2_i;
                rd_addr_o = rd_addr_i;
                rd_wen_o = 1 'b1;
             end
             `MUL_op: begin
                jump_offset = 0;
                jump_en = 0;
                rd_data_o = op1_i * op2_i;
                rd_addr_o = rd_addr_i;
                rd_wen_o = 1 'b1;
             end
             `DIV_op: begin
                jump_offset = 0;
                jump_en = 0;
                rd_data_o = op1_i / op2_i;
                rd_addr_o = rd_addr_i;
                rd_wen_o = 1 'b1;
             end
             `AND_op: begin
                jump_offset = 0;
                jump_en = 0;
                rd_data_o = op1_i & op2_i;
                rd_addr_o = rd_addr_i;
                rd_wen_o = 1 'b1;
             end
             `OR_op: begin
                jump_offset = 0;
                jump_en = 0;
                rd_data_o = op1_i | op2_i;
                rd_addr_o = rd_addr_i;
                rd_wen_o = 1 'b1;
             end
             `NOT_op: begin
                jump_offset = 0;
                jump_en = 0;
                rd_data_o = ~op1_i;
                rd_addr_o = rd_addr_i;
                rd_wen_o = 1 'b1;
             end
             `MOV_op: begin
                jump_offset = 0;
                jump_en = 0;
                rd_data_o = op2_i;
                rd_addr_o = rd_addr_i;
                rd_wen_o = 1 'b1;
             end
             
             // branch class
             `BNE_op: begin
                if (op1_i != op2_i) begin
                    jump_offset = offset;
                    jump_en = 1 'b1;
                end
                rd_data_o = 0;
                rd_addr_o = 0;
                rd_wen_o = 1 'b0;
             end
             
             `BLT_op: begin
                if (op1_i < op2_i) begin
                    jump_offset = offset;
                    jump_en = 1 'b1;
                end
                rd_data_o = 0;
                rd_addr_o = 0;
                rd_wen_o = 1 'b0;
             end
             
             default: begin
                jump_offset = 0;
                jump_en = 0;
                rd_data_o = 0;
                rd_addr_o = 0;
                rd_wen_o = 0;
             end
        endcase
    end
endmodule








