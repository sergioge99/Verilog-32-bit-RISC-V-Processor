//include "core_defines.vh"

module icache(
  input clock, reset,
  input [31:0] addr, 
  output [31:0] instr
);

reg[31:0] icache[31:0];//32 instrucciones de 32 bits de momento
integer i;

initial begin
  //Aqui se leerá de un fichero las instr
  //pero de momento...

    for(i = 0; i < 32; i = i + 1)begin
      icache[i]=0;
    end

  icache[0] <= 0;
  icache[1] <= 32'h00B00213;//addi x4 x0 11
  icache[2] <= 32'h000000b3;//add x1 x0 x0
  icache[3] <= 32'h04000113;//addi x2 x0 64
  icache[4] <= 32'h000001b3;//add x3 x0 x0
  icache[5] <= 32'h00012283;//lw x5 0(x2)
  icache[6] <= 32'h005080B3;//add x1 x1 x5
  icache[7] <= 32'h00118193;//addi x3 x3 1
  icache[8] <= 32'h00410113;//addi x2 x2 4
  icache[9] <= 32'hFE4198E3;//bne x3 x4 -16
  icache[10] <= 32'h00112023;//sw x1 0(x2)
  icache[11] <= 0;
  icache[12] <= 0;
  icache[13] <= 0;
  icache[14] <= 0;
  icache[15] <= 0;
  icache[16] <= 0;
end

assign instr = icache[addr/4];


endmodule