//include "core_defines.vh"

module W_top(
  input clock, reset,
  input [31:0] cw_pc,
  input [4:0] cw_write_sel,
  input [31:0] cw_result,
  input cw_is_wb,
  output w_ready,
  output [4:0] w_write_sel,
  output [31:0] w_result,
  output w_is_wb
);

assign w_ready = 1;
assign w_write_sel = cw_write_sel;
assign w_result = cw_result;
assign w_is_wb = cw_is_wb;


endmodule
