//include "core_defines.vh"

module C_top(
  input clock, reset,
  input [31:0] c_pc,
  input w_ready,
  output [31:0] c_pc_o,
  output c_ready
);



//Cache registers
reg[31:0] C_PC;



//Outputs
assign c_pc_o = C_PC;


//Updating decode registers
always @(posedge clock) begin
  if(w_ready)
  begin
    C_PC = c_pc;
  end
end


endmodule
