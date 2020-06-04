`timescale 1ns / 1ps

module stopwatch (

  
  input        clk100_i,
  
 
  input        rstn_i,
  
  
  input        start_stop_i,
  input        set_i,
  input        change_i,
  

  output [6:0] hex3_o,
  output [6:0] hex2_o,
  output [6:0] hex1_o,
  output [6:0] hex0_o
);

 
  localparam PULSE_MAX = 99;

  
  
  localparam IDLE                = 0;
  localparam CHANGE_0_DIGIT_MODE = 1;
  localparam CHANGE_1_DIGIT_MODE = 2;
  localparam CHANGE_2_DIGIT_MODE = 3;
  localparam CHANGE_3_DIGIT_MODE = 4;
  
 
  wire       start_stop_was_pressed;
  wire       set_was_pressed;
  wire       change_was_pressed;
  
  
  reg  [2:0] state;
  wire [2:0] next_state;
  
  always @( posedge clk100_i ) begin
    state <= next_state;
  end
  
  wire [3:0] ten_seconds_counter_data;
  wire [3:0] seconds_counter_data;
  wire [3:0] tenths_counter_data;
  wire [3:0] hundredths_counter_data;
  
 
  reg  [19:0] pulse_counter;
  reg         hundredth_of_second_passed;
  
  always @( * ) begin
    hundredth_of_second_passed <= pulse_counter == PULSE_MAX;
  end
  
  
  reg device_running;
  
  always @(posedge clk100_i or negedge rstn_i ) begin
    if ( ~rstn_i )
      device_running <= 0;
    else if ( start_stop_was_pressed &  state == IDLE )
      device_running <= ~device_running;
  end
  
 
  always @(posedge clk100_i or negedge rstn_i ) begin
    if ( ~rstn_i )
      pulse_counter <= 0;
    else if ( device_running )
      pulse_counter <= hundredth_of_second_passed ? 0 : pulse_counter + 1;
  end
  

  debounce_remover debounce_remover2 (
    .clk100_i                ( clk100_i               ),
    .button_i                ( ~start_stop_i          ),
    .button_was_pressed_o    ( start_stop_was_pressed )
  );
  
  debounce_remover debounce_remover1 (
    .clk100_i                ( clk100_i               ),
    .button_i                ( ~set_i                 ),
    .button_was_pressed_o    ( set_was_pressed        )
  );
  
 
  debounce_remover debounce_remover0 (
    .clk100_i                ( clk100_i               ),
    .button_i                ( ~change_i              ),
    .button_was_pressed_o    ( change_was_pressed     )
  );
  

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
  

  state_machine state_machine (
    .set_was_pressed_i        ( set_was_pressed        ),
    .state_i                  ( state                  ),
    .next_state_o             ( next_state             )
  );
  
  
  decoder decoder3 (
    .data_i                  ( ten_seconds_counter_data ),
    .hex_o                   ( hex3_o                   )
  );
  
  
  decoder decoder2 (
    .data_i                  ( seconds_counter_data     ),
    .hex_o                   ( hex2_o                   )
  );
  
 
  decoder decoder1 (
    .data_i                  ( tenths_counter_data      ),
    .hex_o                   ( hex1_o                   )
  );
  
  
  decoder decoder0 (
    .data_i                  ( hundredths_counter_data  ),
    .hex_o                   ( hex0_o                   )
  );
endmodule
