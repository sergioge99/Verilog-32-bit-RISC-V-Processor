
module core_top(
  input clock, reset
);

//Branch wires
wire br_en;
wire [31:0] br_addr;
//F-D wires
wire [31:0] fd_pc, fd_instr;
wire load_stall, branch_stall, dcache_stall, icache_stall, mul_stall;
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
wire da_is_imm;
wire da_is_load, da_is_store;
//A-C wires
wire [31:0] ac_pc;
wire [4:0] ac_write_sel;
wire ac_is_load, ac_is_store, ac_is_wb;
wire [31:0] ALU_result, ac_data2;
//C-WB wires
wire [31:0] cw_pc;
wire [4:0] cw_write_sel;
wire [31:0] cw_result;
wire cw_is_wb;


//F Stage
F_top F_top(
  //Inputs
  .clock(clock),
  .reset(reset),
  .load_stall(load_stall),
  .branch_stall(branch_stall),
  .mul_stall(mul_stall),
  .dcache_stall(dcache_stall),
  .br_en(br_en),
  .br_addr(br_addr),
  //Outputs
  .fd_pc(fd_pc),
  .fd_instr(fd_instr),
  .icache_stall(icache_stall)
);

//D Stage
D_top D_top(
  //Inputs
  .clock(clock),
  .reset(reset),
  .dcache_stall(dcache_stall),
  .mul_stall(mul_stall),
  .icache_stall(icache_stall),
  .fd_pc(fd_pc),
  .fd_instr(fd_instr),
  .w_regfile(w_regfile),
  .sel_regfile(sel_regfile),
  .data_regfile(data_regfile),
  .ac_is_wb(ac_is_wb),
  .ac_write_sel(ac_write_sel),
  .ac_result(ALU_result),
  //Outputs
  .da_pc(da_pc),
  .load_stall(load_stall),
  .branch_stall(branch_stall),
  .da_write_sel(da_write_sel),
  .da_is_wb(da_is_wb),
  .da_read_sel1(da_read_sel1),
  .da_read_sel2(da_read_sel2),
  .da_data1(da_data1),
  .da_data2(da_data2),
  .da_imm32(da_imm32),
  .da_ALU_Control(da_ALU_Control),
  .branch_PC(br_addr),
  .branch_en(br_en),
  .da_is_load(da_is_load),
  .da_is_store(da_is_store),
  .da_is_imm(da_is_imm)
);

//A Stage
A_top A_top(
  //Inputs
  .clock(clock),
  .reset(reset),
  .dcache_stall(dcache_stall),
  .icache_stall(icache_stall),
  .da_pc(da_pc),
  .da_write_sel(da_write_sel),
  .da_is_wb(da_is_wb),
  .da_read_sel1(da_read_sel1),
  .da_read_sel2(da_read_sel2),
  .da_data1(da_data1),
  .da_data2(da_data2),
  .da_imm32(da_imm32),
  .da_ALU_Control(da_ALU_Control),
  .da_is_load(da_is_load),
  .da_is_store(da_is_store),
  .da_is_imm(da_is_imm),
  .cw_write_sel(cw_write_sel),
  .cw_result(cw_result),
  .cw_is_wb(cw_is_wb),
  //Outputs
  .ac_pc(ac_pc),
  .ac_write_sel(ac_write_sel),
  .ac_is_load(ac_is_load), 
  .ac_is_store(ac_is_store), 
  .ac_is_wb(ac_is_wb),
  .ALU_result(ALU_result),
  .ac_data2(ac_data2),
  .mul_stall(mul_stall)
);

//C Stage
C_top C_top(
  //Inputs
  .clock(clock),
  .reset(reset),
  .icache_stall(icache_stall),
  .mul_stall(mul_stall),
  .ac_pc(ac_pc),
  .ac_write_sel(ac_write_sel),
  .ALU_result(ALU_result),
  .ac_data2(ac_data2),
  .ac_is_load(ac_is_load), 
  .ac_is_store(ac_is_store), 
  .ac_is_wb(ac_is_wb),
  //Outputs
  .cw_pc(cw_pc),
  .cw_write_sel(cw_write_sel),
  .cw_result(cw_result),
  .cw_is_wb(cw_is_wb),
  .dcache_stall(dcache_stall)
);

//W Stage
W_top W_top(
  //Inputs
  .clock(clock),
  .reset(reset),
  .cw_pc(cw_pc),
  .cw_write_sel(cw_write_sel),
  .cw_result(cw_result),
  .cw_is_wb(cw_is_wb),
  //Outputs
  .w_write_sel(sel_regfile),
  .w_result(data_regfile),
  .w_is_wb(w_regfile)
);


endmodule