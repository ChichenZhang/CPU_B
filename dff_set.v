module dff_set #(
    parameter DW = 16
)
(
    input wire clk,
    input wire rst,
    input wire jump_en,
    input wire [DW-1:0] set_data,
    input wire [DW-1:0] data_i,
    output reg [DW-1:0] data_o
);

    always @(posedge clk) begin
        if (rst == 1 'b0 || jump_en == 1 'b1)
            data_o <= set_data;
        else
            data_o <= data_i;
    end



endmodule