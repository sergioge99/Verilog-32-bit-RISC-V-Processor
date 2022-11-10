//include "core_defines.vh"

module icache(
  input clock, reset,
  input [31:0] addr, 
  output reg [31:0] instr
);

reg [31:0] icache[31:0];//32 instrucciones de 32 bits de momento

initial begin
  //Aqui se leerá de un fichero las instr
  //pero de momento...
  icache[0] <= 32'h3e800093;
  icache[1] <= 32'h7d008113;
  icache[2] <= 32'hc1810193;
  icache[3] <= 32'h83018213;
  icache[4] <= 32'h3e820293;
  icache[5] <= 32'b00000000000000000000000000000000;
end

always @(*) begin
  instr <= icache[addr/4];
end

endmodule