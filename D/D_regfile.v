//include "core_defines.vh"

module regfile(
  input clock, reset,
  input wEn,
  input [31:0] write_data,
  input [4:0] read_sel1,
  input [4:0] read_sel2,
  input [4:0] write_sel,
  output [31:0] read_data1,
  output [31:0] read_data2
);

  reg[31:0] reg_file[31:0];
  integer i,j;

  initial begin
    for(i = 0; i < 32; i = i + 1)begin
          reg_file[i]=0;
    end
  end

  always@(negedge clock) begin
    if (reset) begin 
      for(i = 0; i < 32; i = i + 1)begin
            reg_file[i]=0;
      end
	  end else begin 
  	  if ( wEn && (write_sel != 5'b00000)) begin 
		    reg_file[write_sel] <= write_data;
		  end 
	  end
  end
  
  
  assign read_data1 = reg_file[read_sel1];
  assign read_data2 = reg_file[read_sel2];	 
  
endmodule