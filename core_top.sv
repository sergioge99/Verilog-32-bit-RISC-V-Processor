`include "core_defines.sv"

module core_top(
  input clock, reset
);

//Inter-Stage wires
wire d_ready;
wire br_en;
wire br_addr;
wire instr_data;

//F Stage
F_top F_top(
  .clock(clock),
  .reset(reset),
  .d_ready(d_ready),
  .br_en(br_en),
  .br_addr(br_addr),
  .instr_data(instr_data)
);

//D Stage
D_top D_top(
  .clock(clock),
  .reset(reset),
  .instr(instr)
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