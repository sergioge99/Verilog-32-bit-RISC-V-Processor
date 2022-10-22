//include "core_defines.sv"

module F_top(
  input clock, reset,
  input d_ready,
  input br_en,
  input [31:0] br_addr,
  output [6:0] op,
  output [4:0] rs1,
  output [4:0] rs2,
  output [4:0] rd,
  output [11:0] imm
);


//Fetch registers
reg[31:0] PC;
reg[31:0] provisional_icache = 32'b01100110000000000000000000000000;

//Fetch wires
assign Next_PC = PC + 32'd4;
assign op = provisional_icache[6:0];
assign rs1 = provisional_icache[19:15];
assign rs2 = provisional_icache[24:20];
assign rd = provisional_icache[11:7];
assign imm = provisional_icache[31:20];

//Updating fetch registers
always @(posedge clock) begin
  if(d_ready && !br_en) PC = Next_PC;
  else if(d_ready && br_en)  PC = br_addr;
end


endmodule
