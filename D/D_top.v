`include "core_defines.v"

module D_top(
  input clock, reset,
  input [31:0] d_pc,
  input [31:0] instr,
  input a_ready,
  input w_regfile,
  input [4:0] sel_regfile,
  input [31:0] data_regfile,
  output [31:0] d_pc_o,
  output reg d_ready,
  output [31:0] dataA, dataB,
  output [3:0] op,
  output [4:0] regA, regB, regD,
  output [31:0] offset,
  output w_en,
  output mem_en,
  output [5:0] alu_ctl,
  output is_branch
);

//Decode registers
reg[31:0] D_PC;


//DECODER
decoder decoder(
  // Inputs from Fetch
.PC(d_pc),
.instruction(instr),
  // Outputs to Reg File
.read_sel1(regA),
.read_sel2(regB),
.write_sel(regD),
.wEn(w_en),
  // Outputs to Execute/ALU
.branch_op(is_branch), 
.imm32(offset),
.ALU_Control(alu_ctl),
  // Outputs to Memory
.mem_wEn(mem_en)
);

//REGFILE
regfile regfile(
.clock(clock), 
.reset(reset),
.wEn(w_regfile),
.write_data(data_regfile),
.read_sel1(regA),
.read_sel2(regB),
.write_sel(sel_regfile),
.read_data1(dataA),
.read_data2(dataB)
);

//Outputs
assign d_pc_o = D_PC;

//Updating decode registers
always @(posedge clock) begin
  if(a_ready)
  begin
    D_PC <= d_pc;
    d_ready <= 1;
  end
  else
    d_ready <= 0;
end



endmodule
