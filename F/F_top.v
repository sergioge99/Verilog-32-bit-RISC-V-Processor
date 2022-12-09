//include "core_defines.sv"

module F_top(
  input clock, reset,
  input d_ready,
  input br_en,
  input [31:0] br_addr,
  output reg [31:0] fd_pc = 0,
  output reg [31:0] fd_instr = 0
);

//PC register
reg[31:0] PC_reg = 0;

//Instruction cache
wire [31:0] instr;
icache icache( .clock(clock), .reset(reset), .addr(PC_reg), .instr(instr));


//Updating fetch registers
always @(posedge clock) begin

  if(d_ready)begin
    fd_pc <= PC_reg;
    fd_instr <= instr;
    PC_reg <= PC_reg + 32'd4;
  end

	if(reset)begin
    PC_reg <= 0;
  end
	else if(d_ready & br_en)begin
    PC_reg <= br_addr;
  end



end


endmodule