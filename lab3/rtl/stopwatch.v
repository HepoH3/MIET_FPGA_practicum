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

  // Based on frequency of 10 Hz
  localparam PULSE_MAX = 99;
  // Based on frequency of 100 MHz
  //localparam PULSE_MAX = 999999;
  
  // State machine parameters
  localparam IDLE                = 0;
  localparam CHANGE_0_DIGIT_MODE = 1;
  localparam CHANGE_1_DIGIT_MODE = 2;
  localparam CHANGE_2_DIGIT_MODE = 3;
  localparam CHANGE_3_DIGIT_MODE = 4;
  
  // Synchronization of processing of buttons
  wire       start_stop_was_pressed;
  wire       set_was_pressed;
  wire       change_was_pressed;
  
  // State machine state
  reg  [2:0] state;
  wire [2:0] next_state;
  
  always @( posedge clk100_i ) begin
    state <= next_state;
  end
  
  // Counters data
  wire [3:0] ten_seconds_counter_data;
  wire [3:0] seconds_counter_data;
  wire [3:0] tenths_counter_data;
  wire [3:0] hundredths_counter_data;
  
  // Impulse counter and 0,01 second sign
  reg  [19:0] pulse_counter;
  reg         hundredth_of_second_passed;
  
  always @( * ) begin
    hundredth_of_second_passed <= pulse_counter == PULSE_MAX;
  end
  
  // Generate sign of "device_running"
  reg device_running;
  
  always @(posedge clk100_i or negedge rstn_i ) begin
    if ( ~rstn_i )
      device_running <= 0;
    else if ( start_stop_was_pressed &  state == IDLE )
      device_running <= ~device_running;
  end
  
  // Pulse counter iterator
  always @(posedge clk100_i or negedge rstn_i ) begin
    if ( ~rstn_i )
      pulse_counter <= 0;
    else if ( device_running )
      pulse_counter <= hundredth_of_second_passed ? 0 : pulse_counter + 1;
  end
  
  // Synchronous logic modules  
  // Debouce remover for Start/Stop button
  debounce_remover debounce_remover2 (
    .clk100_i                ( clk100_i               ),
    .button_i                ( ~start_stop_i          ),
    .button_was_pressed_o    ( start_stop_was_pressed )
  );
  
  // Debouce remover for Set button
  debounce_remover debounce_remover1 (
    .clk100_i                ( clk100_i               ),
    .button_i                ( ~set_i                 ),
    .button_was_pressed_o    ( set_was_pressed        )
  );
  
  // Debouce remover for Change button
  debounce_remover debounce_remover0 (
    .clk100_i                ( clk100_i               ),
    .button_i                ( ~change_i              ),
    .button_was_pressed_o    ( change_was_pressed     )
  );
  
  // Counters module
  counters counters (
    .clk100_i                     ( clk100_i                   ),
    .rstn_i                       ( rstn_i                     ),
    .change_was_pressed_i         ( change_was_pressed         ),
    .hundredth_of_second_passed_i ( hundredth_of_second_passed ),
    .state_i                      ( state                      ),
    .ten_seconds_counter_o        ( ten_seconds_counter_data   ),
    .seconds_counter_o            ( seconds_counter_data       ),
    .tenths_counter_o             ( tenths_counter_data        ),
    .hundredths_counter_o         ( hundredths_counter_data    )
  );
  
  // Combinational logic modules
  // State machine
  state_machine state_machine (
    .set_was_pressed_i        ( set_was_pressed        ),
    .state_i                  ( state                  ),
    .next_state_o             ( next_state             )
  );
  
  // Decodes data for output to HEX3 - tens of seconds
  decoder decoder3 (
    .data_i                  ( ten_seconds_counter_data ),
    .hex_o                   ( hex3_o                   )
  );
  
  // Decodes data for output to HEX2 - seconds
  decoder decoder2 (
    .data_i                  ( seconds_counter_data     ),
    .hex_o                   ( hex2_o                   )
  );
  
  // Decodes data for output to HEX1 - tenths of second
  decoder decoder1 (
    .data_i                  ( tenths_counter_data      ),
    .hex_o                   ( hex1_o                   )
  );
  
  // Decodes data for output to HEX0 - hundredths of second
  decoder decoder0 (
    .data_i                  ( hundredths_counter_data  ),
    .hex_o                   ( hex0_o                   )
  );
endmodule
