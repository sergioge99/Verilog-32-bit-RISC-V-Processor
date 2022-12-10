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
  icache[1] <= 32'h08000213;
  icache[2] <= 32'h000000b3;
  icache[3] <= 32'h04000113;
  icache[4] <= 32'h000001b3;
  icache[5] <= 32'h00000297;
  icache[6] <= 32'h0002a283;//load
  icache[7] <= 0;//32'h005080b3;
  icache[8] <= 0;//32'h00118193;
  icache[9] <= 0;//32'h00410113;
  icache[10] <= 0;//32'hfe4196e3;
  icache[11] <= 0;//32'h00000017;
  icache[12] <= 0;//32'h00102023;
  icache[13] <= 0;
  icache[14] <= 0;
  icache[15] <= 0;
  icache[16] <= 0;
end

assign instr = icache[addr/4];


endmodule