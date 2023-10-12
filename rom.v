`include "defines.v"


module rom(
    input [3:0] addr_i,
    output reg[15:0] inst_o
);

    reg [15:0] memo[15:0];
    
    initial begin
    
        memo[0] = {9 'b1_1111_1111, 3 'b001, `ADDI_op};
        memo[1] = {9 'b0_0000_0011, 3 'b010, `ADDI_op};
        memo[2] = {6 'd0, 3 'b010, 3 'b001, `ADD_op};
        memo[3] = {6 'd0, 3 'b010, 3 'b001, `SUB_op};
        memo[4] = {6 'd0, 3 'b010, 3 'b001, `MUL_op};
        memo[5] = {6 'd5 , 3 'b010, 3 'b001, `BNE_op};
    
    end
    
    always @(*) begin
        inst_o = memo[addr_i];
    end

endmodule