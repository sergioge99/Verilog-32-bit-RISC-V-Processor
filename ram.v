module ram();

parameter size = 4096; //size of a ram in bits

reg [31:0] ram [0:size-1]; //data matrix for ram

integer i;

initial begin
  for (i = 0; i < size; i = i + 1) begin
		ram[i] = 0;
    if(i>63 && i<128) ram[i] = 1;
	end
  ram[0] = 32'h00B00213;//addi x4 x0 11
  ram[1] = 32'h000000b3;//add x1 x0 x0
  ram[2] = 32'h04000113;//addi x2 x0 64
  ram[3] = 32'h000001b3;//add x3 x0 x0
  ram[4] = 32'h00012283;//lw x5 0(x2)
  ram[5] = 32'h005080B3;//add x1 x1 x5
  ram[6] = 32'h00118193;//addi x3 x3 1
  ram[7] = 32'h00410113;//addi x2 x2 4
  ram[8] = 32'hFE4198E3;//bne x3 x4 -16
  ram[9] = 32'h00112023;//sw x1 0(x2)
end

endmodule