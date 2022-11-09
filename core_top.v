`include "core_defines.v"

module core_top(
  input clock, reset
);

//Branch wires
wire br_en;
wire br_addr;

//F-D wires
wire d_ready;
wire f_pc, instr;


//F Stage
F_top F_top(
  //Inputs
  .clock(clock),
  .reset(reset),
  .d_ready(d_ready),
  .br_en(br_en),
  .br_addr(br_addr),
  //Outputs
  .f_pc(f_pc),
  .instr(instr)
);


//D Stage
D_top D_top(
  //Inputs
  .clock(clock),
  .reset(reset),
  .d_pc(f_pc),
  .instr(instr),
  //Outputs
  .d_ready(d_ready)

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