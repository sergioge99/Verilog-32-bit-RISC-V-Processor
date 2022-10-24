//include "core_defines.vh"

module A_top(
  input clock, reset,
  input [31:0] a_pc,
  input c_ready,
  output [31:0] a_pc_o,
  output a_ready
);



//Alu registers
reg[31:0] A_PC;



//Outputs
assign a_pc_o = A_PC;


//Updating decode registers
always @(posedge clock) begin
  if(c_ready)
  begin
    A_PC = a_pc;
  end
end



endmodule
