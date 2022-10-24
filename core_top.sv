`include "core_defines.sv"

module core_top(
  input clock, reset
);

//Branch wires
wire br_en;
wire br_addr;

//F-D wires
wire d_ready_wire;
wire f_pc_o_wire, instr_wire;


//F Stage
F_top F_top(
  //Inputs
  .clock(clock),
  .reset(reset),
  .d_ready(d_ready_wire),
  .br_en(br_en),
  .br_addr(br_addr),
  //Outputs
  .f_pc_o(f_pc_o_wire),
  .instr(instr_wire)
);


//D Stage
D_top D_top(
  //Inputs
  .clock(clock),
  .reset(reset),
  .d_pc(f_pc_o_wire),
  .instr(instr_wire),
  //Outputs
  .d_ready(d_ready_wire)

);


//A Stage
A_top A_top(
  .clock(clock),
  .reset(reset)
);


//C Stage
C_top C_top(
  .clock(clock),
  .reset(reset)
);


//W Stage
W_top W_top(
  .clock(clock),
  .reset(reset)
);


endmodule