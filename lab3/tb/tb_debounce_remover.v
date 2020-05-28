`timescale 1ns / 1ps

module tb_debounce_remover;

  localparam CLK_FREQ_MHZ   = 100;
  localparam CLK_PERIOD     = 1000 / CLK_FREQ_MHZ;
  localparam CLK_SEMIPERIOD = 1000 / CLK_FREQ_MHZ / 2;
  
  reg  clk100;
  reg  button;
  
  wire button_was_pressed;
  
  // Clock generation
  initial begin
    clk100 = 1;
    forever
      #CLK_SEMIPERIOD clk100 = ~clk100;
  end
  
  // Press button
  initial begin
    #( CLK_PERIOD * 4 ) button = 1;
    #( CLK_SEMIPERIOD ) button = 0;
    #( CLK_PERIOD * 4 ) $finish;
  end
  
  debounce_remover DUT (
    .clk100_i                ( clk100             ),
    .button_i                ( button             ),
    .button_was_pressed_o    ( button_was_pressed )
  );
endmodule
