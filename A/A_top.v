
module A_top(
  //Input
  input clock, reset,
  input dcache_stall,icache_stall,
  input [31:0] da_pc,
  input [4:0] da_write_sel,
  input [4:0] da_read_sel1,
  input [4:0] da_read_sel2,
  input [31:0] da_data1,
  input [31:0] da_data2,
  input [31:0] da_imm32,
  input [5:0] da_ALU_Control,
  input da_is_load, da_is_store, da_is_wb, da_is_imm,
  input cw_is_wb,
  input[4:0] cw_write_sel,
  input[31:0] cw_result,
//Output
  output reg [31:0] ac_pc=0,
  output reg [4:0] ac_write_sel=0,
  output reg ac_is_load=0, ac_is_store=0, ac_is_wb=0,
  output reg [31:0] ALU_result=0,
  output reg [31:0] ac_data2,
  output mul_stall
);

//Internal wires
wire [31:0] alu_in1, alu_in2, alu_out;
reg [3:0] stall_countdown=4;


// MUX 1
assign alu_in1 = (ac_is_wb && ac_write_sel==da_read_sel1)? ALU_result:
                  (cw_is_wb && cw_write_sel==da_read_sel1)? cw_result:
                  da_data1;

// MUX 2
assign alu_in2 = (da_is_imm)? da_imm32:
                  (ac_is_wb && ac_write_sel==da_read_sel2)? ALU_result:
                  (cw_is_wb && cw_write_sel==da_read_sel2)? cw_result:
                  da_data2;

//MUL 5-stage simulation
assign mul_stall =  ((da_ALU_Control == 6'b000010) && (stall_countdown!=0))? 1:
                    0;

//ALU
alu alu(
  .ALU_Control(da_ALU_Control),
  .operand_A(alu_in1),
  .operand_B(alu_in2),
  .ALU_result(alu_out)
);


//Update registers
always @(posedge clock) begin
  if((da_ALU_Control == 6'b000010) && stall_countdown==0 && (!dcache_stall && !icache_stall)) begin
		stall_countdown = 4;
	end
  else begin
    if((da_ALU_Control == 6'b000010) && stall_countdown>0) begin
		  stall_countdown = stall_countdown -1;
	  end
  end

  if(!dcache_stall && !icache_stall && !mul_stall) begin
    ac_pc <= da_pc;
    ac_write_sel <= da_write_sel;
    ac_is_load <= da_is_load;
    ac_is_store <= da_is_store;
    ac_is_wb <= da_is_wb;
    ALU_result <= alu_out;
    ac_data2 <= da_data2;
  end 

end

endmodule
