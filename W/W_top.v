
module W_top(
  //Inputs
  input clock, reset,
  input [31:0] cw_pc,
  input [4:0] cw_write_sel,
  input [31:0] cw_result,
  input cw_is_wb,
  //Outputs
  output [4:0] w_write_sel,
  output [31:0] w_result,
  output w_is_wb
);

//Out
assign w_write_sel = cw_write_sel;
assign w_result = cw_result;
assign w_is_wb = cw_is_wb;

endmodule