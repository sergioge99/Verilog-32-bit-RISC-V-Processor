`include "core_defines.v"

module core_top(
  input clock, reset
);

//Branch wires
wire br_en;
wire [31:0] br_addr;

//F-D wires
wire d_ready;
wire [31:0] fd_pc, fd_instr;


//F Stage
F_top F_top(
  //Inputs
  .clock(clock),
  .reset(reset),
  .d_ready(d_ready),
  .br_en(br_en),
  .br_addr(br_addr),
  //Outputs
  .fd_pc(fd_pc),
  .fd_instr(fd_instr)
);

//W-D wires
wire w_regfile;
wire [4:0] sel_regfile;
wire [31:0] data_regfile;

//D-A wires
wire da_pc;
wire a_ready;
wire [4:0] da_write_sel;
wire da_is_wb;
wire [4:0] da_read_sel1;
wire [4:0] da_read_sel2;
wire [31:0] da_data1;
wire [31:0] da_data2;
wire [31:0] da_imm32;
wire [5:0] da_ALU_Control;
wire [31:0] da_target_PC;
wire da_is_branch;
wire da_is_load, da_is_store;

//D Stage
D_top D_top(
  //Inputs
  .clock(clock),
  .reset(reset),
  .fd_pc(fd_pc),
  .fd_instr(fd_instr),
  .a_ready(a_ready),
  .w_regfile(w_regfile),
  .sel_regfile(sel_regfile),
  .data_regfile(data_regfile),
  //Outputs
  .da_pc(da_pc),
  .d_ready(d_ready),
  .da_write_sel(da_write_sel),
  .da_is_wb(da_is_wb),
  .da_read_sel1(da_read_sel1),
  .da_read_sel2(da_read_sel2),
  .da_data1(da_data1),
  .da_data2(da_data2),
  .da_imm32(da_imm32),
  .da_ALU_Control(da_ALU_Control),
  .da_target_PC(da_target_PC),
  .da_is_branch(da_is_branch),
  .da_is_load(da_is_load),
  .da_is_store(da_is_store)
);

//A-C wires
wire c_ready;
wire [31:0] ac_pc;
wire [4:0] ac_write_sel;
wire ac_is_load, ac_is_store, ac_is_wb;
wire [31:0] ALU_result;


//A Stage
A_top A_top(
  //Inputs
  .clock(clock),
  .reset(reset),
  .da_pc(da_pc),
  .c_ready(c_ready),
  .da_write_sel(da_write_sel),
  .da_is_wb(da_is_wb),
  .da_read_sel1(da_read_sel1),
  .da_read_sel2(da_read_sel2),
  .da_data1(da_data1),
  .da_data2(da_data2),
  .da_imm32(da_imm32),
  .da_ALU_Control(da_ALU_Control),
  .da_target_PC(da_target_PC),
  .da_is_branch(da_is_branch),
  .da_is_load(da_is_load),
  .da_is_store(da_is_store),
  //Outputs
  .ac_pc(ac_pc),
  .ac_write_sel(ac_write_sel),
  .ac_is_load(ac_is_load), 
  .ac_is_store(ac_is_store), 
  .ac_is_wb(ac_is_wb),
  .a_ready(a_ready),
  .ALU_result(ALU_result)
);

//C-WB wires
wire w_ready;
wire [31:0] cw_pc;
wire [4:0] cw_write_sel;
wire [31:0] cw_result;
wire cw_is_wb;

//C Stage
C_top C_top(
  .clock(clock),
  .reset(reset),
  .w_ready(w_ready),
  .ac_pc(ac_pc),
  .ac_write_sel(ac_write_sel),
  .ALU_result(ALU_result),
  .ac_is_load(ac_is_load), 
  .ac_is_store(ac_is_store), 
  .ac_is_wb(ac_is_wb),
  .c_ready(c_ready),
  .cw_pc(cw_pc),
  .cw_write_sel(cw_write_sel),
  .cw_result(cw_result),
  .cw_is_wb(cw_is_wb)
);


//W Stage
W_top W_top(
  .clock(clock),
  .reset(reset),
  .cw_pc(cw_pc),
  .cw_write_sel(cw_write_sel),
  .cw_result(cw_result),
  .cw_is_wb(cw_is_wb),
  .w_write_sel(sel_regfile),
  .w_result(data_regfile),
  .w_is_wb(w_regfile)
);


endmodule