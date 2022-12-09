//include "core_defines.vh"

module dcache(
  input clock, reset,
  input [31:0] addr, 
  output [31:0] data
);

reg[63:0] dcache[31:0];//32 instrucciones de 32 bits de momento
integer i;

initial begin
  //Aqui se leerá de un fichero las instr
  //pero de momento...

    for(i = 0; i < 64; i = i + 1)begin
      dcache[i]=0;
    end

  dcache[8] <= 3;
  dcache[8] <= 2;
  dcache[8] <= 1;
end

assign data = dcache[addr/4];


endmodule