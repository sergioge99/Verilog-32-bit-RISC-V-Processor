//include "core_defines.vh"

module A_top(
  input clock, reset,
  input dcache_stall,icache_stall,
  input [31:0] da_pc,
  input [4:0] da_write_sel,
  input [4:0] da_read_sel1,
  input [4:0] da_read_sel2,
  input [31:0] da_data1,
  input [31:0] da_data2,
  input [31:0] da_imm32,
  input [5:0] da_ALU_Control,
  input da_is_load, da_is_store, da_is_wb, da_is_imm,

//Bypasses
  input cw_is_wb,
  input[4:0] cw_write_sel,
  input[31:0] cw_result,
  

  output reg [31:0] ac_pc=0,
  output reg [4:0] ac_write_sel=0,
  output reg ac_is_load=0, ac_is_store=0, ac_is_wb=0,

  output reg [31:0] ALU_result=0,
  output reg [31:0] ac_data2

);

//Internal wires
  wire [31:0] alu_in1, alu_in2;
  wire [31:0] alu_out;
  wire jump;

// MUX 1
assign alu_in1 = (ac_is_wb && !ac_is_load && ac_write_sel==da_read_sel1)? ALU_result:
                  (cw_is_wb && cw_write_sel==da_read_sel1)? cw_result:
                  da_data1;

// MUX 2
assign alu_in2 = (da_is_imm)? da_imm32:
                  (ac_is_wb && !ac_is_load && ac_write_sel==da_read_sel2)? ALU_result:
                  (cw_is_wb && cw_write_sel==da_read_sel2)? cw_result:
                  da_data2;

//ALU
alu alu(
  .ALU_Control(da_ALU_Control),
  .operand_A(alu_in1),
  .operand_B(alu_in2),
  .ALU_result(alu_out)
);


//Updating decode registers
always @(posedge clock) begin
  if(!dcache_stall && !icache_stall) begin
    ac_pc <= da_pc;
    ac_write_sel <= da_write_sel;
    ac_is_load <= da_is_load;
    ac_is_store <= da_is_store;
    ac_is_wb <= da_is_wb;
    ALU_result <= alu_out;
    ac_data2 <= da_data2;
  end 
end



endmodule
