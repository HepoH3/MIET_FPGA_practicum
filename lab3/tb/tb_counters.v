`timescale 1ns / 1ps

module tb_counters;

  localparam CLK_FREQ_MHZ   = 100;
  localparam CLK_PERIOD     = 1000 / CLK_FREQ_MHZ;
  localparam CLK_SEMIPERIOD = 1000 / CLK_FREQ_MHZ / 2;
  
  // State machine parameters
  localparam IDLE                = 0;
  localparam CHANGE_0_DIGIT_MODE = 1;
  localparam CHANGE_1_DIGIT_MODE = 2;
  localparam CHANGE_2_DIGIT_MODE = 3;
  localparam CHANGE_3_DIGIT_MODE = 4;
  
  reg        clk100;
  reg        rstn;
  
  reg        hundredth_of_second_passed;
  reg        change_was_pressed;
  reg  [2:0] state;
  
  wire [3:0] ten_seconds_counter;
  wire [3:0] seconds_counter;
  wire [3:0] tenths_counter;
  wire [3:0] hundredths_counter;
  
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
  
  initial begin
    hundredth_of_second_passed = 0;
    repeat ( 10 ) begin
      #CLK_PERIOD
      hundredth_of_second_passed = 1;
      #CLK_SEMIPERIOD
      hundredth_of_second_passed = 0;
    end
    state = CHANGE_0_DIGIT_MODE;
    repeat ( 10 ) begin
      change_was_pressed = 1;
      #CLK_PERIOD
      change_was_pressed = 0;
      #CLK_PERIOD;
    end
    #( CLK_PERIOD * 10 );
    $finish;
  end
  
  counters DUT (
    .clk100_i                     ( clk100                     ),
    .rstn_i                       ( rstn                       ),
    .change_was_pressed_i         ( change_was_pressed         ),
    .hundredth_of_second_passed_i ( hundredth_of_second_passed ),
    .state_i                      ( state                      ),
    .ten_seconds_counter_o        ( ten_seconds_counter        ),
    .seconds_counter_o            ( seconds_counter            ),
    .tenths_counter_o             ( tenths_counter             ),
    .hundredths_counter_o         ( hundredths_counter         )
  );
endmodule
