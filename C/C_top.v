
module C_top(
  //Inputs
  input clock, reset, icache_stall, mul_stall,
  input [31:0] ac_pc,
  input [4:0] ac_write_sel,
  input [31:0] ALU_result, ac_data2,
  input ac_is_load, ac_is_store, ac_is_wb,
  //Outputs
  output reg [31:0] cw_pc=0,
  output reg [4:0] cw_write_sel=0,
  output reg [31:0] cw_result=0,
  output reg cw_is_wb=0,
  output dcache_stall
);

// Internal wires
wire [31:0] cache_out;
wire [31:0] result = (ac_is_load)? cache_out:
                     ALU_result;

//Instruction cache
dcache dcache( .clk(clock), .reset(reset), .addr(ALU_result), .data(ac_data2), .is_load(ac_is_load), .is_store(ac_is_store), .out(cache_out), .stall(dcache_stall));


//Updating decode registers
always @(posedge clock) begin
  if(!dcache_stall && !icache_stall && !mul_stall)
  begin
    cw_pc <= ac_pc;
    cw_write_sel <= ac_write_sel;
    cw_result <= result;
    cw_is_wb <= ac_is_wb;
  end
end

endmodule
