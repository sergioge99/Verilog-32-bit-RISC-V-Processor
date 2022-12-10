//include "core_defines.vh"

module C_top(
  input clock, reset,
  input [31:0] ac_pc,
  input [4:0] ac_write_sel,
  input [31:0] ALU_result,
  input ac_is_load, ac_is_store, ac_is_wb,
  output reg [31:0] cw_pc=0,
  output reg [4:0] cw_write_sel=0,
  output reg [31:0] cw_result=0,
  output reg cw_is_wb=0
);

// Internal wires
wire [31:0] data;
wire [31:0] result = (ac_is_load)? data:
                     ALU_result;

//Instruction cache
dcache dcache( .clock(clock), .reset(reset), .addr(ALU_result), .data(data));


//Updating decode registers
always @(posedge clock) begin
  if(1)
  begin
    cw_pc <= ac_pc;
    cw_write_sel <= ac_write_sel;
    cw_result <= result;
    cw_is_wb <= ac_is_wb;
  end
end


endmodule
