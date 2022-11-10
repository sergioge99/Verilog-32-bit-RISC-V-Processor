`include "core_defines.v"

module core_top(
  input clock, reset
);

//Branch wires
wire br_en;
wire br_addr;

//F-D wires
wire d_ready;
wire f_pc, instr;


//F Stage
F_top F_top(
  //Inputs
  .clock(clock),
  .reset(reset),
  .d_ready(d_ready),
  .br_en(br_en),
  .br_addr(br_addr),
  //Outputs
  .f_pc(f_pc),
  .instr(instr)
);

//W-D wires
wire w_regfile;
wire [4:0] sel_regfile;
wire [31:0] data_regfile;

//D-A wires
wire d_pc;
wire [31:0] dataA, dataB;
wire [3:0] op;
wire [4:0] regA, regB, regD;
wire [31:0] imm;
wire w_en;
wire mem_en;
wire [5:0] alu_ctl;
wire is_branch;
wire a_ready;

//D Stage
D_top D_top(
  //Inputs
  .clock(clock),
  .reset(reset),
  .d_pc(f_pc),
  .instr(instr),
  .a_ready(a_ready),
  .w_regfile(w_regfile),
  .sel_regfile(sel_regfile),
  .data_regfile(sel_regfile),
  //Outputs
  .d_pc_o(d_pc),
  .d_ready(d_ready),
  .dataA(dataA), 
  .dataB(dataB),
  .op(op),
  .regA(regA), 
  .regB(regB), 
  .regD(regD),
  .imm(imm),
  .w_en(w_en),
  .mem_en(mem_en),
  .alu_ctl(alu_ctl),
  .is_branch(is_branch)
);


//A Stage
A_top A_top(
  .clock(clock),
  .reset(reset),
  .a_pc(d_pc),
  .is_branch(is_branch),
  .ALU_Control(alu_ctl),
  .operand_A(dataA),
  .operand_B(dataB),
  .a_pc_o(),
  .a_ready(a_ready),
  .ALU_result(),
  .br_en(br_en)
);


//C Stage
C_top C_top(
  .clock(clock),
  .reset(reset)
);


//W Stage
W_top W_top(
  .clock(clock),
  .reset(reset)
);


endmodule