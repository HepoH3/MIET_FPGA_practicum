`timescale 1ns / 1ps

module counters (
  // External clock source
  input        clk100_i,
  
  // Reset input
  input        rstn_i,
  
  // Data inputs
  input        change_was_pressed_i,
  input        hundredth_of_second_passed_i,
  input  [2:0] state_i,
  
  // Data outputs
  output [3:0] ten_seconds_counter_o,
  output [3:0] seconds_counter_o,
  output [3:0] tenths_counter_o,
  output [3:0] hundredths_counter_o
);

  // For decimal notation
  localparam COUNTER_MAX = 9;
  
  // State machine parameters
  localparam IDLE                = 0;
  localparam CHANGE_0_DIGIT_MODE = 1;
  localparam CHANGE_1_DIGIT_MODE = 2;
  localparam CHANGE_2_DIGIT_MODE = 3;
  localparam CHANGE_3_DIGIT_MODE = 4;
  
  // Counters
  reg [3:0] ten_seconds_counter_data;
  reg [3:0] seconds_counter_data;
  reg [3:0] tenths_counter_data;
  reg [3:0] hundredths_counter_data;
  
  // Event flags
  reg       ten_seconds_passed;
  reg       second_passed;
  reg       tenth_of_second_passed;
  
  // Default mode
  always @( posedge clk100_i or negedge rstn_i ) begin
    if ( ~rstn_i ) begin
      ten_seconds_counter_data <= 0;
      seconds_counter_data     <= 0;
      tenths_counter_data      <= 0;
      hundredths_counter_data  <= 0;
    end
    else begin
      if ( ten_seconds_passed )
        ten_seconds_counter_data <= ten_seconds_counter_data == COUNTER_MAX ? 0 : ten_seconds_counter_data + 1;
      if ( second_passed )
        seconds_counter_data     <= ten_seconds_passed ? 0 : seconds_counter_data + 1;
      if ( tenth_of_second_passed )
        tenths_counter_data      <= second_passed ? 0 : tenths_counter_data + 1;
      if ( hundredth_of_second_passed_i )
        hundredths_counter_data  <= tenth_of_second_passed ? 0 : hundredths_counter_data + 1;
    end
  end
  
  always @( * ) begin
    ten_seconds_passed     <= seconds_counter_data == COUNTER_MAX & second_passed;
    second_passed          <= tenths_counter_data == COUNTER_MAX & tenth_of_second_passed;
    tenth_of_second_passed <= hundredths_counter_data == COUNTER_MAX & hundredth_of_second_passed_i;
  end
  
  // Set mode
  always @( posedge clk100_i ) begin
    if ( change_was_pressed_i & state_i != IDLE )
      if ( state_i == CHANGE_0_DIGIT_MODE )
        hundredths_counter_data  <= hundredths_counter_data != COUNTER_MAX ? hundredths_counter_data + 1 : 0;
      else if ( state_i == CHANGE_1_DIGIT_MODE )
        tenths_counter_data      <= tenths_counter_data != COUNTER_MAX ? tenths_counter_data + 1 : 0;
      else if ( state_i == CHANGE_2_DIGIT_MODE )
        seconds_counter_data     <= seconds_counter_data != COUNTER_MAX ? seconds_counter_data + 1 : 0;
      else if ( state_i == CHANGE_3_DIGIT_MODE )
        ten_seconds_counter_data <= ten_seconds_counter_data != COUNTER_MAX ? ten_seconds_counter_data + 1 : 0;
  end
  
  // Output data
  assign ten_seconds_counter_o = ten_seconds_counter_data;
  assign seconds_counter_o     = seconds_counter_data;
  assign tenths_counter_o      = tenths_counter_data;
  assign hundredths_counter_o  = hundredths_counter_data;
endmodule
