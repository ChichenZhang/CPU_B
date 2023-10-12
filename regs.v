module regs(
    input clk,
    input rst,
    
    // from id
    input [2:0] rs1_addr_i,
    input [2:0] rs2_addr_i,
    
    // to id
    output reg[15:0] op1_o,
    output reg[15:0] op2_o,
    
    // write
    input wen,
    input [2:0] rd_addr,
    input [15:0] rd_data

);

    reg[15:0] regs[7:0];
    integer i;

    always @(*) begin
        if (rst == 1'b0)
            op1_o <= 16 'b0;
        else if(rs1_addr_i == 0)
            op1_o <= 16 'b0;
        else if(wen && rs1_addr_i == rd_addr)
            op1_o <= rd_data;      
        else
            op1_o <= regs[rs1_addr_i];
    end
    
    always @(*) begin
        if (rst == 1'b0)
            op2_o <= 16 'b0;
        else if(rs2_addr_i == 0)
            op2_o <= 16 'b0;
        else if(wen && rs2_addr_i == rd_addr)
            op2_o <= rd_data;
        else
            op2_o <= regs[rs2_addr_i];
    end
    
    always @(posedge clk) begin
        if (rst == 0) begin
            for (i=0;i<8; i=i+1) begin
                regs[i] <= 16 'b0;
            end
        end
        else if(wen && rd_addr != 3 'b0) begin
            regs[rd_addr] <= rd_data;
        end
    end

endmodule