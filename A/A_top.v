//include "core_defines.vh"

module A_top(
  input clock, reset,
  input [31:0] a_pc,
  input is_branch,
  input [5:0]  ALU_Control,
  input [31:0] operand_A,
  input [31:0] operand_B,
  output [31:0] a_pc_o,
  output a_ready,
  output [31:0] ALU_result,
  output br_en
);



//Alu registers
reg[31:0] A_PC;



//Outputs
assign a_pc_o = A_PC;

//ALU
alu alu(
  .branch_op(is_branch),
  .ALU_Control(ALU_Control),
  .operand_A(operand_A),
  .operand_B(operand_B),
  .ALU_result(ALU_result),
  .branch(br_en)
);


//Updating decode registers
always @(posedge clock) begin
  if(1)
  begin
    A_PC = a_pc;
  end
end



endmodule
