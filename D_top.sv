`include "core_defines.sv"

module D_top(
  input clock, reset,
  input [31:0] d_pc,
  input [31:0] instr,
  input a_ready,
  output [31:0] d_pc_o,
  output d_ready,
  output [31:0] dataA, dataB,
  output [3:0] op,
  output [4:0] regA, regB, regD,
  output [31:0] offset,
  output w_en
);

//Decode registers
reg[31:0] D_PC;


//Instr split
wire opcode = instr[6:0];
wire funct3 = instr[14:12];
wire funct7 = instr[31:25];




//Outputs
assign d_pc_o = D_PC;


//Updating decode registers
always @(posedge clock) begin
  if(a_ready)
  begin
    D_PC <= d_pc;
  end
end



endmodule
