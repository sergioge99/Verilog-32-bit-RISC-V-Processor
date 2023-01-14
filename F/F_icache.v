`include "ram.v"

module icache(
  input clk, reset,
  input [31:0] addr,    
  output [31:0] out,
  output stall
);

// 26 bit tag + 2 bit index + 2 bit word + 2 bit byte

//cache
reg [127:0] cache [3:0]; //registers for the data in cache
reg [26:0] tag_array [3:0]; // for all tags in cache
reg valid_array [3:0]; //0 - there is no data 1 - there is data

//stall countdown
reg [3:0] stall_countdown=0;

//wires
wire [26:0] tag;	// for keeping tag of current address
wire [1:0] index;	// for keeping index of current address
wire [1:0] word;

//main memory
ram ram();

integer i;

//initial values
initial begin
    
		for (i = 0; i < 4; i = i + 1)
		begin
			valid_array[i] = 1'b0;
			tag_array[i] = 6'b000000;
		end
end

//address fields
assign tag = addr[31:6];
assign index = addr[5:4];
assign word = addr[3:2];

//reading the right word
assign out = (word==0) ? cache[index][31:0] :
			(word==1) ? cache[index][63:32] :
			(word==2) ? cache[index][95:64] :
			(word==3) ? cache[index][127:96] :
			0;

//stop pipeline when main memory is accessed
assign stall = 	(valid_array[index] != 1 || tag_array[index] != tag)? 1:
				(stall_countdown>0)? 1:
				0;


always @(posedge clk)
begin
	if(stall_countdown>0) begin
		stall_countdown = stall_countdown -1;
	end

					//write new data to the relevant cache's block, because the one we addressing to will be possibly addressed one more time soon
					if (valid_array[index] != 1 || tag_array[index] != tag)
						begin
							stall_countdown = 9;
							valid_array[index] = 1;
							tag_array[index] = tag;
							cache[index][31:0] = ram.ram[{tag,index,2'b00}];
							cache[index][63:32] = ram.ram[{tag,index,2'b01}];
							cache[index][95:64] = ram.ram[{tag,index,2'b10}];
							cache[index][127:96] = ram.ram[{tag,index,2'b11}];
						end

end

endmodule 