//include "core_defines.vh"

module A_top(
  input clock, reset,
  input c_ready,
  input [31:0] da_pc,
  input [4:0] da_write_sel,
  input [4:0] da_read_sel1,
  input [4:0] da_read_sel2,
  input [31:0] da_data1,
  input [31:0] da_data2,
  input [31:0] da_imm32,
  input [5:0] da_ALU_Control,
  input [31:0] da_target_PC,
  input da_is_branch, da_is_load, da_is_store, da_is_wb,

  output reg [31:0] ac_pc,
  output reg [4:0] ac_write_sel,
  output reg ac_is_load, ac_is_store, ac_is_wb,

  output reg a_ready,
  output reg [31:0] ALU_result,
  output reg [31:0] br_addr,
  output reg br_en

);

//Internal wires
  wire [31:0] alu_in1, alu_in2;
  wire [31:0] alu_out;
  wire jump;

// MUX 1
assign alu_in1 = da_data1;

// MUX 2
assign alu_in2 = da_data2;

//ALU
alu alu(
  .branch_op(da_is_branch),
  .ALU_Control(da_ALU_Control),
  .operand_A(alu_in1),
  .operand_B(alu_in2),
  .ALU_result(alu_out),
  .branch(jump)
);



//Updating decode registers
always @(posedge clock) begin
  if(c_ready) begin
    a_ready <= 1;
    ac_pc <= da_pc;
    ac_write_sel <= da_write_sel;
    ac_is_load <= da_is_load;
    ac_is_store <= da_is_store;
    ac_is_wb <= da_is_wb;
    ALU_result <= alu_out;
    br_addr <= da_target_PC;
    br_en <= jump;
  end 
  else begin
    a_ready<=0;
  end
end



endmodule
