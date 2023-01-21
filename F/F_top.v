//include "core_defines.sv"

module F_top(
  input clock, reset,
  input load_stall,
  input branch_stall,
  input dcache_stall,
  input br_en,
  input [31:0] br_addr,
  output reg [31:0] fd_pc = 0,
  output reg [31:0] fd_instr = 0,
  output icache_stall
);

//PC register
reg[31:0] PC_reg = 0;

//Instruction cache
wire [31:0] instr;
icache icache( .clk(clock), .reset(reset), .addr(PC_reg), .out(instr), .stall(icache_stall));


//Updating fetch registers
always @(posedge clock) begin
  if(!load_stall && !dcache_stall && !icache_stall && !branch_stall)begin
    if(!br_en)begin
      fd_pc <= PC_reg;
      fd_instr <= instr;
      PC_reg <= PC_reg + 32'd4;
    end
    else begin
      fd_pc <= 0;
      fd_instr <= 0;
      PC_reg <= br_addr;
    end
  end

end


endmodule