`timescale 1ns / 1ps

module stopwatch (
  // External clock source
  input        clk100_i,
  
  // Reset input
  input        rstn_i,
  
  // Data inputs
  input        start_stop_i,
  input        set_i,
  input        change_i,
  
  // Data outputs
  output [6:0] hex3_o,
  output [6:0] hex2_o,
  output [6:0] hex1_o,
  output [6:0] hex0_o
);


  // Based on frequency of 100 MHz
  localparam PULSE_MAX = 999999;
  
  // For decimal notation
  localparam COUNTER_MAX = 9;
  
  // HEX data
  wire [6:0] hex3_data;
  wire [6:0] hex2_data;
  wire [6:0] hex1_data;
  wire [6:0] hex0_data;
  
  
  // Part I - synchronization of processing of Start/Stop button
  reg [2:0] button_synchronizer;
  wire      button_was_pressed;
  
  always @( posedge clk100_i ) begin
    button_synchronizer[0] <= start_stop_i;
    button_synchronizer[1] <= button_synchronizer[0];
    button_synchronizer[2] <= button_synchronizer[1];
  end
  
  assign button_was_pressed = ~button_synchronizer[2] & button_synchronizer[1];
  
  
  // Part II - generate sign of "device_running"
  reg device_running = 1;
  
  
  // Part III - impulse counter and 0,01 second sign
  reg [19:0] pulse_counter;
  wire       hundredth_of_second_passed;
  
  assign hundredth_of_second_passed = pulse_counter == PULSE_MAX;
  
  always @(posedge clk100_i or negedge rstn_i ) begin
    if ( ~rstn_i | hundredth_of_second_passed )
      pulse_counter <= 0;
    else if ( device_running )
      pulse_counter <= pulse_counter + 1;
  end
  
  
  // Part IV - main counters
  
  // Event flags
  wire      ten_seconds_passed;
  wire      second_passed;
  wire      tenth_of_second_passed;
  
  // Counters
  reg [3:0] ten_seconds_counter;
  reg [3:0] seconds_counter;
  reg [3:0] tenths_counter;
  reg [3:0] hundredths_counter;
  
  assign ten_seconds_passed     = seconds_counter    == COUNTER_MAX & second_passed;
  assign second_passed          = tenths_counter     == COUNTER_MAX & tenth_of_second_passed;
  assign tenth_of_second_passed = hundredths_counter == COUNTER_MAX & hundredth_of_second_passed;
  
  always @( posedge clk100_i or negedge rstn_i ) begin
    if ( ~rstn_i )
      ten_seconds_counter <= 0;
    else if ( ten_seconds_passed )
      if ( ten_seconds_counter == COUNTER_MAX )
           ten_seconds_counter <= 0;
      else ten_seconds_counter <= ten_seconds_counter + 1;
  end
  
  always @( posedge clk100_i or negedge rstn_i ) begin
    if ( ~rstn_i )
      seconds_counter <= 0;
    else if ( second_passed )
      if ( ten_seconds_passed )
           seconds_counter <= 0;
      else seconds_counter <= seconds_counter + 1;
  end
  
  always @( posedge clk100_i or negedge rstn_i ) begin
    if ( ~rstn_i )
      tenths_counter <= 0;
    else if ( tenth_of_second_passed )
      if ( second_passed )
           tenths_counter <= 0;
      else tenths_counter <= tenths_counter + 1;
  end
  
  always @( posedge clk100_i or negedge rstn_i ) begin
    if ( ~rstn_i )
      hundredths_counter <= 0;
    else if ( hundredth_of_second_passed )
      if ( tenth_of_second_passed )
           hundredths_counter <= 0;
      else hundredths_counter <= hundredths_counter + 1;
  end
  
  
  // Part V - decoders for display main registers data on seven-self displays
  
  // Data output to HEX
  assign hex3_o = hex3_data;
  assign hex2_o = hex2_data;
  assign hex1_o = hex1_data;
  assign hex0_o = hex0_data;
  
  // Decodes data for output to HEX3 - tens of seconds
  decoder decoder3(
    .data_i                  ( ten_seconds_counter ),
    .hex_o                   ( hex3_data           )
  );
  
  // Decodes data for output to HEX2 - seconds
  decoder decoder2(
    .data_i                  ( seconds_counter     ),
    .hex_o                   ( hex2_data           )
  );
  
  // Decodes data for output to HEX1 - tenths of second
  decoder decoder1(
    .data_i                  ( tenths_counter      ),
    .hex_o                   ( hex1_data           )
  );
  
  // Decodes data for output to HEX0 - hundredths of second
  decoder decoder0(
    .data_i                  ( hundredths_counter  ),
    .hex_o                   ( hex0_data           )
  );
  
endmodule
