module ram();

parameter size = 4096; //size of a ram in bits

reg [31:0] ram [0:size-1]; //data matrix for ram

integer i;

initial begin
  for (i = 0; i < size; i = i + 1) begin
		ram[i] = 0;
	end

  ram[0] = 32'h08000093;//addi x1 x0 128
  ram[1] = 32'h09000113;//addi x2 x0 144
  ram[2] = 32'h0A000193;//addi x3 x0 160
  ram[3] = 32'h00000233;//add x4 x0 x0
  ram[4] = 32'h000002B3;//add x5 x0 x0
  ram[5] = 32'h00000333;//add x6 x0 x0
  ram[6] = 32'h00200393;//addi x7 x0 2
  ram[7] = 32'h00100593;//addi x11 x0 1
  ram[8] = 32'h00B21433;//sll x8 x4 x11
  ram[9] = 32'h00B314B3;//sll x9 x6 x11
  ram[10] = 32'h00640433;//add x8 x8 x6
  ram[11] = 32'h005484B3;//add x9 x9 x5
  ram[12] = 32'h00241413;//slli x8 x8 2
  ram[13] = 32'h00249493;//slli x9 x9 2
  ram[14] = 32'h00140433;//add x8 x8 x1
  ram[15] = 32'h002484B3;//add x9 x9 x2
  ram[16] = 32'h00042403;//lw x8 0(x8)
  ram[18] = 32'h0004A483;//lw x9 0(x9)
  ram[19] = 32'h02940433;//mul x8 x8 x9
  ram[20] = 32'h00850533;//add x10 x10 x8
  ram[17] = 32'h00130313;//addi x6 x6 1
  ram[21] = 32'hFC7316E3;//bne x6 x7 -52
  ram[22] = 32'h00B21433;//sll x8 x4 x11
  ram[23] = 32'h00540433;//add x8 x8 x5
  ram[24] = 32'h00241413;//slli x8 x8 2
  ram[25] = 32'h00340433;//add x8 x8 x3
  ram[26] = 32'h00A42023;//sw x10 0(x8)
  ram[28] = 32'h00000533;//add x10 x0 x0
  ram[29] = 32'h00000333;//add x6 x0 x0
  ram[27] = 32'h00128293;//addi x5 x5 1
  ram[30] = 32'hFA7294E3;//bne x5 x7 -88
  ram[32] = 32'h000002B3;//add x5 x0 x0
  ram[31] = 32'h00120213;//addi x4 x4 1
  ram[33] = 32'hF8721EE3;//bne x4 x7 -100

  ram[128]=1;
  ram[132]=2;
  ram[136]=3;
  ram[140]=4;
  ram[144]=5;
  ram[148]=6;
  ram[152]=7;
  ram[156]=8;

end

endmodule