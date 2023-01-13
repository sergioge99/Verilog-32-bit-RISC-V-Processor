`include "core_defines.v"

module D_top(
  input clock, reset,
  input dcache_stall,
  //Inputs from WB
  input w_regfile,
  input [4:0] sel_regfile,
  input [31:0] data_regfile,
  
  // Inputs from Fetch
  input [31:0] fd_pc,
  input [31:0] fd_instr,

  // Outputs to Fetch
  output stall, branch_en,
  output [31:0] branch_PC,

  // Outputs to WB
  output reg [4:0] da_write_sel=0,
  output reg da_is_wb=0,

  // Outputs to Execute/ALU
  output reg [31:0] da_pc=0,
  output reg [4:0] da_read_sel1=0,
  output reg [4:0] da_read_sel2=0,
  output reg [31:0] da_data1=0,
  output reg [31:0] da_data2=0,
  output reg [31:0] da_imm32=0,
  output reg [5:0] da_ALU_Control=0,

  // Outputs to Memory
  output reg da_is_load=0, da_is_store=0, da_is_imm=0
);



// Internal wires
wire [4:0] write_sel;
wire [4:0] read_sel1;
wire [4:0] read_sel2;
wire [31:0] data1;
wire [31:0] data2;
wire [31:0] imm32;
wire [5:0] ALU_Control;
wire is_load, is_store, is_wb, is_imm;
wire[31:0] instruction = fd_instr;
wire[11:0] i_imm_orig;
wire[12:0] sb_imm_orig;
wire[31:0] sb_imm_32;
wire[31:0] i_imm_32;
wire [6:0] opcode;
wire [6:0] funct7;
wire [2:0] funct3;


// Read registers
assign read_sel2  = instruction[24:20];
assign read_sel1  = instruction[19:15];

/* Instruction decoding */
assign opcode = instruction[6:0];
assign funct7 = instruction[31:25];
assign funct3 = instruction[14:12];

/* Write register */
assign write_sel = instruction[11:7];

//immediates calculations 
assign i_imm_orig = instruction[31:20];
assign i_imm_32 = { {20{i_imm_orig[11]}}, i_imm_orig}; // I-type
assign sb_imm_orig = {instruction[31], instruction[7], instruction[30:25], instruction[11:8], 1'b0};
assign sb_imm_32 = { {19{sb_imm_orig[12]}}, sb_imm_orig}; //SB-type

assign imm32 =  (opcode == 7'b0010011)? i_imm_32:  //I-type
					 (opcode == 7'b0000011)? i_imm_32:  //Load
					 0;  //default 


assign is_load = (opcode == 7'b0000011)? 1:
					0;
assign is_store = (opcode == 7'b0100011)? 1:
					0;
assign is_wb = ((opcode == 7'b0110011) || (opcode == 7'b0010011) || (opcode == 7'b0000011))? 1:
				0;
assign is_imm = (opcode == 7'b0010011)? 1:  //addi
					 0;  //default 

assign ALU_Control = (opcode == 7'b0110011)? 6'b000000:  //add
					 (opcode == 7'b0010011)? 6'b000000:  //addi
					 (opcode == 7'b0000011)? 6'b000000:  //Load
					 (opcode == 7'b0100011)? 6'b000000:  //Store
					 0;  //default 

//branch PC calculations 					 
assign branch_PC = (opcode == 7'b1100011)? (fd_pc + sb_imm_32): //branch instructions 
						 0; 


//REGFILE
regfile regfile(
.clock(clock), 
.reset(reset),
.wEn(w_regfile),
.write_data(data_regfile),
.read_sel1(read_sel1),
.read_sel2(read_sel2),
.write_sel(sel_regfile),
.read_data1(data1),
.read_data2(data2)
);

// Stall control
assign stall = (da_is_load && (read_sel1==da_write_sel || read_sel2==da_write_sel))? 1:
              0;

//branch test
assign branch_en = ((opcode == 7'b1100011) && (funct3 == 3'b000) && (data1 == data2))? 1: //beq
					 ((opcode == 7'b1100011) && (funct3 == 3'b001)  && (data1 != data2))? 1: //bne
           0;

//Updating decode registers
always @(posedge clock) begin
  if(!stall && !dcache_stall)begin
    if(!branch_en)begin
      da_pc <= fd_pc;
      da_write_sel <= write_sel;
      da_is_wb <= is_wb;
      da_read_sel1 <= read_sel1;
      da_read_sel2 <= read_sel2;
      da_data1 <= data1;
      da_data2 <= data2;
      da_imm32 <= imm32;
      da_ALU_Control <= ALU_Control;
      da_is_load <= is_load;
      da_is_store <= is_store;
      da_is_imm <= is_imm;
    end
    else begin
      da_pc <= 0;
      da_write_sel <= 0;
      da_is_wb <= 0;
      da_read_sel1 <= 0;
      da_read_sel2 <= 0;
      da_data1 <= 0;
      da_data2 <= 0;
      da_imm32 <= 0;
      da_ALU_Control <= 0;
      da_is_load <= 0;
      da_is_store <= 0;
      da_is_imm <= 0;
    end
  end
  else begin
      da_pc <= 0;
      da_write_sel <= 0;
      da_is_wb <= 0;
      da_read_sel1 <= 0;
      da_read_sel2 <= 0;
      da_data1 <= 0;
      da_data2 <= 0;
      da_imm32 <= 0;
      da_ALU_Control <= 0;
      da_is_load <= 0;
      da_is_store <= 0;
      da_is_imm <= 0;
  end
end



endmodule
