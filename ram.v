module ram();

parameter size = 4096; //size of a ram in bits

reg [31:0] ram [0:size-1]; //data matrix for ram

integer i;

initial begin
  for (i = 0; i < size; i = i + 1) begin
		ram[i] = 0;
	end

  ram[0] = 32'h08000093;//addi x1 x0 128
  ram[1] = 32'h00000133;//add x2 x0 x0
  ram[2] = 32'h000001B3;//add x3 x0 x0
  ram[3] = 32'h00308233;//add x4 x1 x3
  ram[4] = 32'h00022283;//lw x5 0(x4)
  ram[5] = 32'h00510133;//add x2 x2 x5
  ram[6] = 32'h00118193;//addi x3 x3 1
  ram[7] = 32'hFE1198E3;//bne x3 x1 -16
  ram[8] = 32'h00308233;//add x4 x1 x3
  ram[9] = 32'h00222023;//sw x2 0(x4)


end

endmodule