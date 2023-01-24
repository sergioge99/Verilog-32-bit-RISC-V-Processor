
module alu (
  input [5:0]  ALU_Control,
  input [31:0] operand_A,
  input [31:0] operand_B,
  output [31:0] ALU_result
);


//Determine output of ALU
assign ALU_result = (ALU_Control == 6'b000000) ? (operand_A + operand_B): //Add (LUI,AUIPC,LW,SW,ADDI,ADD)
						  (ALU_Control == 6'b001000) ? (operand_A - operand_B): //Sub (SUB)
						  
						  (ALU_Control == 6'b000110) ? (operand_A | operand_B): //Or (OR,ORI)
						  (ALU_Control == 6'b000100) ? (operand_A ^ operand_B): //Xor (XORI,XOR)
						  (ALU_Control == 6'b000111) ? (operand_A & operand_B): //And (ANDI,AND)
						  
						  (ALU_Control == 6'b000001) ? (operand_A << operand_B): //Logical Shift Left (SLLI,SLL)
						  (ALU_Control == 6'b000101) ? (operand_A >> operand_B): //Logical Shift Right (SRLI,SRL)
						  (ALU_Control == 6'b001101) ? (operand_A >>> operand_B): //Arithmetic Shift Right (SRAI,SRA)
						  
						  (ALU_Control == 6'b010000) ? (operand_A == operand_B): //Equals	(BEQ)
						  (ALU_Control == 6'b010001) ? (operand_A != operand_B): //Not Equals (BNE)
						  
						  (ALU_Control == 6'b011111 || ALU_Control == 6'b111111) ? (operand_A): //Passthrough
							
							1'b0; //Default Case

endmodule