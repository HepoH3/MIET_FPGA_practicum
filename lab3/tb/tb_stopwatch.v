`timescale 1ns / 1ps

module tb_stopwatch;

  localparam CLK_FREQ_MHZ   = 100;
  localparam CLK_PERIOD     = 1000 / CLK_FREQ_MHZ;
  localparam CLK_SEMIPERIOD = 1000 / CLK_FREQ_MHZ / 2;
  
  reg        clk100;
  
  reg        rstn;
  reg        start_stop;
  
  wire [6:0] hex0;
  wire [6:0] hex1;
  wire [6:0] hex2;
  wire [6:0] hex3;
  
  initial begin
    clk100 = 1;
    forever
      #CLK_SEMIPERIOD clk100 = ~clk100;
  end
  
  stopwatch  DUT (
    .clk100_i                ( clk100     ),
    
    .rstn_i                  ( rstn       ),
    .start_stop_i            ( start_stop ),
    
    .hex0_o                  ( hex0       ),
    .hex1_o                  ( hex1       ),
    .hex2_o                  ( hex2       ),
    .hex3_o                  ( hex3       )
  );
endmodule
