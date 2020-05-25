`timescale 1ns / 1ps

module tb_stopwatch;

  localparam CLK_FREQ_MHZ   = 100;
  localparam CLK_PERIOD     = 1000 / CLK_FREQ_MHZ;
  localparam CLK_SEMIPERIOD = 1000 / CLK_FREQ_MHZ / 2;
  
  reg        clk100;
  
  reg        rstn;
  
  reg        start_stop;
  reg        set;
  reg        change;
  
  wire [6:0] hex0;
  wire [6:0] hex1;
  wire [6:0] hex2;
  wire [6:0] hex3;
  
  
  // Clock generation
  initial begin
    clk100 = 1;
    forever
      #CLK_SEMIPERIOD clk100 = ~clk100;
  end
  
  // Reset device
  initial begin
    rstn = 0;
    #CLK_SEMIPERIOD
    rstn = 1;
  end
  
  // Start/Stop device
  initial begin
    #CLK_PERIOD start_stop = 1;
    #CLK_PERIOD start_stop = 0;
    #(CLK_PERIOD * 45) start_stop = 1;
    #CLK_PERIOD start_stop = 0;
  end
  
  stopwatch  DUT (
    .clk100_i                ( clk100     ),
    
    .rstn_i                  ( rstn       ),
    
    .start_stop_i            ( start_stop ),
    .set_i                   ( set        ),
    .change_i                ( change     ),
    
    .hex0_o                  ( hex0       ),
    .hex1_o                  ( hex1       ),
    .hex2_o                  ( hex2       ),
    .hex3_o                  ( hex3       )
  );
  
endmodule
