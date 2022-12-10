`include "core_defines.v"

module core_top(
  input clock, reset
);

//Branch wires
wire br_en;
wire [31:0] br_addr;

//F-D wires
wire [31:0] fd_pc, fd_instr;
wire stall;

//F Stage
F_top F_top(
  //Inputs
  .clock(clock),
  .reset(reset),
  .stall(stall),
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
wire [31:0] da_pc;
wire [4:0] da_write_sel;
wire da_is_wb;
wire [4:0] da_read_sel1;
wire [4:0] da_read_sel2;
wire [31:0] da_data1;
wire [31:0] da_data2;
wire [31:0] da_imm32;
wire [5:0] da_ALU_Control;
wire [31:0] da_target_PC;
wire da_is_branch, da_is_imm;
wire da_is_load, da_is_store;

//D Stage
D_top D_top(
  //Inputs
  .clock(clock),
  .reset(reset),
  .br_en(br_en),
  .fd_pc(fd_pc),
  .fd_instr(fd_instr),
  .w_regfile(w_regfile),
  .sel_regfile(sel_regfile),
  .data_regfile(data_regfile),
  //Outputs
  .da_pc(da_pc),
  .stall(stall),
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
  .da_is_imm(da_is_imm)
);

//A-C wires
wire [31:0] ac_pc;
wire [4:0] ac_write_sel;
wire ac_is_load, ac_is_store, ac_is_wb;
wire [31:0] ALU_result;

//C-WB wires
wire [31:0] cw_pc;
wire [4:0] cw_write_sel;
wire [31:0] cw_result;
wire cw_is_wb;


//A Stage
A_top A_top(
  //Inputs
  .clock(clock),
  .reset(reset),
  .da_pc(da_pc),
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
  .da_is_imm(da_is_imm),
  .cw_write_sel(cw_write_sel),
  .cw_result(cw_result),
  .cw_is_wb(cw_is_wb),
  //Outputs
  .ac_pc(ac_pc),
  .br_en(br_en),
  .br_addr(br_addr),
  .ac_write_sel(ac_write_sel),
  .ac_is_load(ac_is_load), 
  .ac_is_store(ac_is_store), 
  .ac_is_wb(ac_is_wb),
  .ALU_result(ALU_result)
);



//C Stage
C_top C_top(
  .clock(clock),
  .reset(reset),
  .ac_pc(ac_pc),
  .ac_write_sel(ac_write_sel),
  .ALU_result(ALU_result),
  .ac_is_load(ac_is_load), 
  .ac_is_store(ac_is_store), 
  .ac_is_wb(ac_is_wb),
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