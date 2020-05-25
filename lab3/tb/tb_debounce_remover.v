`timescale 1ns / 1ps

module tb_debounce_remover;

  localparam CLK_FREQ_MHZ   = 100;
  localparam CLK_PERIOD     = 1000 / CLK_FREQ_MHZ;
  localparam CLK_SEMIPERIOD = 1000 / CLK_FREQ_MHZ / 2;
  
  reg  clk100;
  
  reg  rstn;
  
  reg  button;
  
  wire button_was_pressed;
  
  
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
  
  // Press button contact
  initial begin
    repeat ( 3 ) begin
      #(CLK_PERIOD * 4) button = 1;
      #(CLK_SEMIPERIOD) button = 0;
    end
    #(CLK_SEMIPERIOD) rstn = 1;
    #(CLK_SEMIPERIOD) rstn = 0;
    repeat ( 3 ) begin
      #(CLK_PERIOD * 4) button = 1;
      #(CLK_SEMIPERIOD) button = 0;
    end
  end
  
  debounce_remover DUT (
    .clk100_i                ( clk100             ),
    
    .rstn_i                  ( rstn               ),
    
    .button_i                ( button             ),
    
    .button_was_pressed_o    ( button_was_pressed )
  );
  
endmodule
