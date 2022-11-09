`define ALUREGOP 7'b 0110011//ADD,SUB,MUL
`define ALUIMMOP 7'b 0010011//ADDI
`define LOADOP 7'b 0000011//LW,LB
`define STOREOP 7'b 0100011//SW,SB
`define BRANCHOP 7'b 1100011//BEQ


`define FF(CLK, RST, EN, DATAOUT, DATAIN, DEF) \
  always @ (posedge CLK) \
    if(RST)     DATAOUT <= DEF; \
    else if(EN) DATAOUT <= DATAIN;
