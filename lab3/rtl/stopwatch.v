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
  
  // State machine parameters
  localparam IDLE                = 0;
  localparam CHANGE_0_DIGIT_MODE = 1;
  localparam CHANGE_1_DIGIT_MODE = 2;
  localparam CHANGE_2_DIGIT_MODE = 3;
  localparam CHANGE_3_DIGIT_MODE = 4;
  localparam STOPWATCH_MODE      = 5;
  
  // Synchronization of processing of buttons
  wire      start_stop_was_pressed;
  wire      set_was_pressed;
  wire      change_was_pressed;
  
  // State machine state
  reg [2:0] state;
  reg [2:0] next_state;
  
  always @( posedge clk100_i or posedge rstn_i ) begin
    state <= next_state;
  end
  
  // Generate sign of "device_running"
  reg device_running;
  
  always @( posedge clk100_i or negedge rstn_i )
  begin
    if      ( ~rstn_i )                                                             device_running <= 0;
    else if ( start_stop_was_pressed & ( state == IDLE | state == STOPWATCH_MODE )) device_running <= ~device_running;
  end
  
  
  // Impulse counter and 0,01 second sign
  reg [19:0] pulse_counter;
  wire       hundredth_of_second_passed;
  
  assign hundredth_of_second_passed = pulse_counter == PULSE_MAX;
  
  always @(posedge clk100_i or negedge rstn_i ) begin
    if      ( ~rstn_i | hundredth_of_second_passed ) pulse_counter <= 0;
    else if ( device_running )                       pulse_counter <= pulse_counter + 1;
  end
  
  
  // Main counters
  reg [3:0] ten_seconds_counter;
  reg [3:0] seconds_counter;
  reg [3:0] tenths_counter;
  reg [3:0] hundredths_counter;
  
  wire      ten_seconds_passed;
  wire      second_passed;
  wire      tenth_of_second_passed;
  
  assign ten_seconds_passed     = seconds_counter    == COUNTER_MAX & second_passed;
  assign second_passed          = tenths_counter     == COUNTER_MAX & tenth_of_second_passed;
  assign tenth_of_second_passed = hundredths_counter == COUNTER_MAX & hundredth_of_second_passed;
  
  always @( posedge clk100_i or negedge rstn_i ) begin
    if ( ~rstn_i ) ten_seconds_counter <= 0;
    else if ( ten_seconds_passed )
      if ( ten_seconds_counter == COUNTER_MAX ) ten_seconds_counter <= 0;
      else                                      ten_seconds_counter <= ten_seconds_counter + 1;
  end
  
  // ==========================================================================
  
  always @( posedge clk100_i or negedge rstn_i ) begin
    if ( ~rstn_i ) seconds_counter <= 0;
    else if ( second_passed )
      if ( ten_seconds_passed ) seconds_counter <= 0;
      else                      seconds_counter <= seconds_counter + 1;
  end
  
  // ==========================================================================
  
  always @( posedge clk100_i or negedge rstn_i ) begin
    if ( ~rstn_i ) tenths_counter <= 0;
    else if ( tenth_of_second_passed )
      if ( second_passed ) tenths_counter <= 0;
      else                 tenths_counter <= tenths_counter + 1;
  end
  
  // ==========================================================================
  
  always @( posedge clk100_i or negedge rstn_i ) begin
    if ( ~rstn_i ) hundredths_counter <= 0;
    else if ( hundredth_of_second_passed )
      if ( tenth_of_second_passed ) hundredths_counter <= 0;
      else                          hundredths_counter <= hundredths_counter + 1;
  end
  
  // Change mode
  always @( * ) begin
    if ( change_was_pressed )
    
      if ( state == CHANGE_0_DIGIT_MODE )
        if ( hundredths_counter != COUNTER_MAX )
          hundredths_counter <= hundredths_counter + 1;
        else
          hundredths_counter <= 0;
      
      //===================================================
      
      else if ( state == CHANGE_1_DIGIT_MODE )
        if ( tenths_counter != COUNTER_MAX )
          tenths_counter <= tenths_counter + 1;
        else
          tenths_counter <= 0;
      
      //===================================================
      
      else if ( state == CHANGE_2_DIGIT_MODE )
        if ( seconds_counter != COUNTER_MAX )
          seconds_counter <= seconds_counter + 1;
        else
          seconds_counter <= 0;
      
      //===================================================
      
      else if ( state == CHANGE_3_DIGIT_MODE )
        if ( seconds_counter != COUNTER_MAX )
          seconds_counter <= seconds_counter + 1;
        else
          seconds_counter <= 0;
  end
  
  // State machine
  state_machine state_machine (
    .start_stop_was_pressed_i ( start_stop_was_pressed ),
    .set_was_pressed_i        ( set_was_pressed        ),
    .state_i                  ( state                  ),
    .next_state_o             ( next_state             )
  );
  
  // Debouce remover for Start/Stop button
  debounce_remover debounce_remover2 (
    .clk100_i                ( clk100_i               ),
    .rstn_i                  ( rstn_i                 ),
    .button_i                ( ~start_stop_i          ),
    .button_was_pressed_o    ( start_stop_was_pressed )
  );
  
  // Debouce remover for Set button
  debounce_remover debounce_remover1 (
    .clk100_i                ( clk100_i               ),
    .rstn_i                  ( rstn_i                 ),
    .button_i                ( ~set_i                 ),
    .button_was_pressed_o    ( set_was_pressed        )
  );
  
  // Debouce remover for Change button
  debounce_remover debounce_remover0 (
    .clk100_i                ( clk100_i               ),
    .rstn_i                  ( rstn_i                 ),
    .button_i                ( ~change_i              ),
    .button_was_pressed_o    ( change_was_pressed     )
  );
  
  // Decodes data for output to HEX3 - tens of seconds
  decoder decoder3 (
    .data_i                  ( ten_seconds_counter ),
    .hex_o                   ( hex3_o              )
  );
  
  // Decodes data for output to HEX2 - seconds
  decoder decoder2 (
    .data_i                  ( seconds_counter     ),
    .hex_o                   ( hex2_o              )
  );
  
  // Decodes data for output to HEX1 - tenths of second
  decoder decoder1 (
    .data_i                  ( tenths_counter      ),
    .hex_o                   ( hex1_o              )
  );
  
  // Decodes data for output to HEX0 - hundredths of second
  decoder decoder0 (
    .data_i                  ( hundredths_counter  ),
    .hex_o                   ( hex0_o              )
  );
endmodule
