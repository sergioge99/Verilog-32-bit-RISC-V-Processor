//include "core_defines.vh"

module dcache(
  input clock, reset,
  input [31:0] addr, 
  output [31:0] data
);

reg[31:0] dcache[63:0];//32 instrucciones de 32 bits de momento
integer i;

initial begin
  //Aqui se leerá de un fichero las instr
  //pero de momento...

    for(i = 0; i < 64; i = i + 1)begin
      dcache[i]=0;
    end

  dcache[14] <= 4;
  dcache[15] <= 3;

  dcache[16] <= 2;
  dcache[17] <= 1;
  dcache[16] <= 7;
  dcache[17] <= 8;//18
end

assign data = dcache[addr>>2];


endmodule