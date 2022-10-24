//include "core_defines.sv"

module F_top(
  input clock, reset,
  input d_ready,
  input br_en,
  input [31:0] br_addr,
  output [31:0] f_pc_o,
  output [31:0] instr
);


//Fetch registers
reg[31:0] PC = 32'd0;
reg[31:0] provisional_icache = 32'b01100110000000000000000000000000;

//PC register logic
assign next_PC = (d_ready & !br_en) ? PC + 32'd4:
                  (d_ready & br_en) ? br_addr:
                                      PC;

//Outputs
assign f_pc_o = PC;
assign instr = provisional_icache[6:0];

//Updating fetch registers
always @(posedge clock) begin
  if(d_ready)
  begin
    PC = next_PC;
  end
end


endmodule
