//include "core_defines.sv"

module F_top(
  input clock, reset,
  input d_ready,
  input br_en,
  input [31:0] br_addr,
  output [31:0] f_pc,
  output [31:0] instr
);

//Fetch registers
reg[31:0] PC_reg = 32'd0;

icache icache( .clock(clock), .reset(reset), .addr(PC), .instr(instr));

//Outputs
assign f_pc = PC;

//Updating fetch registers
always @(posedge clock) begin
	if(reset) PC_reg <= 0;
	else if(d_ready & !br_en) PC_reg <= PC_reg + 32'd4;
  else if(d_ready & br_en)  PC_reg <= br_addr;
end


endmodule