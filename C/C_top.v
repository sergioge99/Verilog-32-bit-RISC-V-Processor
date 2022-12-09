//include "core_defines.vh"

module C_top(
  input clock, reset,
  input w_ready,
  input [31:0] ac_pc,
  input [4:0] ac_write_sel,
  input [31:0] ALU_result,
  input ac_is_load, ac_is_store, ac_is_wb,
  output reg c_ready=0,
  output reg [31:0] cw_pc=0,
  output reg [4:0] cw_write_sel=0,
  output reg [31:0] cw_result=0,
  output reg cw_is_wb=0
);

// Internal wires
wire [31:0] mem_out = 32'd0;
wire [31:0] result = (ac_is_load)? mem_out:
                     ALU_result;

//Dcache
//en construccion


//Updating decode registers
always @(posedge clock) begin
  if(w_ready)
  begin
    c_ready <= 1;
    cw_pc <= ac_pc;
    cw_write_sel <= ac_write_sel;
    cw_result <= result;
    cw_is_wb <= ac_is_wb;
  end
  else begin
    c_ready <= 0;
  end
end


endmodule
