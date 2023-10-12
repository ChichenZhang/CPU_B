

module ifetch(
    // from pc
    input [3:0] addr_i,
    
    // from rom
    input [15:0] inst_i,
    
    // to rom
    output [3:0] addr_o2rom,
    
    //to if_id
    output [15:0] inst_o,
    output [3:0] addr_o2id

    );
    
    
    assign addr_o2rom = addr_i;
    assign addr_o2id = addr_i;
    assign inst_o = inst_i;
    
    
endmodule