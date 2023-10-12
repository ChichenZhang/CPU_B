`define NOP 16 'b0000_0000_0000_0000

`define NOP_op 4 'b0000 //
`define ADD_op 4 'b1100 //
`define SUB_op 4 'b1110 //
`define MUL_op 4 'b1001 //
`define DIV_op 4 'b1101 //
`define AND_op 4 'b0100 //
`define OR_op 4 'b0010 //
`define NOT_op 4 'b0110 //
`define MOV_op 4 'b0101 //
`define BNE_op 4 'b0001 
`define BLT_op 4 'b0101 

`define ADDI_op 4 'b1010
`define JMP_op 4 'b0001
`define LAD_op 4 'b0011
`define STR_op 4 'b0111