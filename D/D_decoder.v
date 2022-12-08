//include "core_defines.vh"

module decoder(
  // Inputs from Fetch
  input [31:0] PC,
  input [31:0] instruction,

  // Outputs to Reg File
  output [4:0] read_sel1,
  output [4:0] read_sel2,
  output [4:0] write_sel,
  output is_wb,

  // Outputs to Execute/ALU
  output [31:0] imm32,
  output [5:0] ALU_Control,
  output [31:0] target_PC,
  output is_branch,

  // Outputs to Memory
  output is_load, is_store

);


// internal wires
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
					 (opcode == 7'b1100011)? sb_imm_32: //Branches
					 0;  //default 


assign is_load = (opcode == 7'b0000011)? 1:
					0;

assign is_store = (opcode == 7'b0100011)? 1:
					0;

assign is_wb = ((opcode == 7'b0110011) || (opcode == 7'b0010011) || (opcode == 7'b0000011))? 1:
				0;

assign is_branch = (opcode == 7'b1100011)? 1:
					0;

assign ALU_Control = (opcode == 7'b0110011)? 6'b000000:  //add
					 (opcode == 7'b0010011)? 6'b000000:  //addi
					 (opcode == 7'b0000011)? 6'b000000:  //Load
					 (opcode == 7'b0100011)? 6'b000000:  //Store
					 ((opcode == 7'b1100011) && (funct3 == 3'b000))? 6'b010000: //beq
					 ((opcode == 7'b1100011) && (funct3 == 3'b001))? 6'b010001: //bne
					 0;  //default 


//target PC calculations 					 
assign target_PC = (opcode == 7'b1100011)? (PC + sb_imm_32[15:0]): //branch instructions 
						 0; 


endmodule