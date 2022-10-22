`include "core_defines.sv"

module D_top(
  input wire clock, reset,
  input reg [31:0] instr,
  output reg [31:0] dataA, dataB,
  output reg [3:0] op,
  output reg [4:0] regA, regB, regD,
  output reg [31:0] offset,
  output reg Wenable
);



wire opcode = instr[6:0];
wire funct3 = instr[14:12];
wire funct7 = instr[31:25];

always @ (posedge clock) begin
op <= (opcode==`ALUREGOP & funct3==3'b000 & funct7==7'b000000 ) ? 4'd1:
            (opcode==`ALUREGOP & funct3==3'b000 & funct7==7'b010000 ) ? 4'd2:
            (opcode==`ALUIMMOP & funct3==3'b000) ? 4'd3:
            (opcode==`LOADOP & funct3==3'b010) ? 4'd4:  
            (opcode==`LOADOP & funct3==3'b000) ? 4'd5:  
            (opcode==`STOREOP & funct3==3'b010) ? 4'd6:  
            (opcode==`STOREOP & funct3==3'b000) ? 4'd7:  
            (opcode==`BRANCHOP & funct3==3'b000) ? 4'd8:  
                                                  4'd0;             

regA <= ((op==4'd1)||(op==4'd2)||(op==4'd3)) ? instr[19:15]:
              (op==4'd2) ? instr[19:15]:
              instr[19:15];
              
regB <= ((op==4'd1)||(op==4'd2)) ? instr[24:20]:
              5'd0;
              
regD <= ((op==4'd1)||(op==4'd2)||(op==4'd3)) ? instr[11:7]:
              instr[11:7];
              
offset <= ((op==4'd1)||(op==4'd2)) ? 32'd0:
                ((op==4'd3)||(op==4'd3)) ? instr[31:20]<<20:
                instr[31:25];

dataA <= regA;
dataB <= regB;
Wenable <= 1'd0;

end



endmodule
