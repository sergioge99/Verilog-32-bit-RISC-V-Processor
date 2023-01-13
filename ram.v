module ram();

parameter size = 4096; //size of a ram in bits

reg [31:0] ram [0:size-1]; //data matrix for ram

integer i;

initial begin
    for (i = 0; i < size; i = i + 1) begin
		ram[i] = 0;
        if(i>63 && i<128) ram[i]=1;
	end
end

endmodule