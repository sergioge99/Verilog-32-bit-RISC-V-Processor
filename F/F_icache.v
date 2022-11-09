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
  icache[0] <= 32'b00000000000000000000000000000000;
  icache[1] <= 32'b00000000000000000000000000000000;
  icache[2] <= 32'b00000000000000000000000000000000;
  icache[3] <= 32'b00000000000000000000000000000000;
  icache[4] <= 32'b00000000000000000000000000000000;
  icache[5] <= 32'b00000000000000000000000000000000;
end

always @(*) begin
  instr <= icache[addr];
end

endmodule