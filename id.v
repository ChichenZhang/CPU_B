`include "defines.v"

module id(
    // from if_id
    input [15:0] inst_i,
    input [3:0] inst_addr_i,
    
    // to regs
    output reg[2:0] rs1_addr_o,
    output reg[2:0] rs2_addr_o,
    
    // from regs
    input [15:0] rs1_i,
    input [15:0] rs2_i,
    
    // to id_ex
    output reg[15:0] inst_o,
    output reg[3:0] inst_addr_o,
    output reg[15:0] op1_o,
    output reg[15:0] op2_o,
    output reg[2:0] rd_addr_o,
    output reg reg_wen
    
);

    wire [3:0] opcode;
    wire [2:0] rd;
    wire [2:0] rs;
    wire [8:0] imm;
    
    assign opcode = inst_i[3:0];
    assign rd = inst_i[6:4];
    assign rs = inst_i[9:7];
    assign imm = inst_i[15:7];

    always @(*) begin
        inst_o = inst_i;
        inst_addr_o = inst_addr_i;
        case(opcode)
            `ADDI_op: begin
                rs1_addr_o = rd;
                rs2_addr_o = 3 'b0;
                op1_o = rs1_i;
                op2_o = {7 'b0,imm};
                reg_wen = 1 'b1;
                rd_addr_o = rd;
            end
            
            `NOP_op: begin
                rs1_addr_o = 0;
                rs2_addr_o = 0;
                op1_o = 0;
                op2_o = 0;
                reg_wen = 0;
                rd_addr_o = 0;
            end
            
//            `BNE_op, `BLT_op: begin
//                rs1_addr_o = rd;
//                rs2_addr_o = rs;
//                op1_o = rs1_i;
//                op2_o = rs2_i;
//                reg_wen = 1 'b0;
//                rd_addr_o = 0;
//            end
            
            default: begin
                rs1_addr_o = rd;
                rs2_addr_o = rs;
                op1_o = rs1_i;
                op2_o = rs2_i;
                reg_wen = 1 'b1;
                rd_addr_o = rd;
            end
            
        endcase    
    end
endmodule