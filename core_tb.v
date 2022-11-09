module core_tb();
  
  reg clock,reset;
  
  initial begin
    $display ("hello world");	
    clock = 1;       // initial value of clock
    reset = 0;       // initial value of reset
  end

  always begin
    #10 clock=~clock;
  end
  
  core_top core_top(clock,reset);

endmodule
