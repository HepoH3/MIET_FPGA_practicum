`timescale 1ns / 1ps

module tb_state_machine;

  localparam PERIOD = 20;
  
  // State machine parameters
  localparam IDLE                = 0;
  localparam CHANGE_0_DIGIT_MODE = 1;
  localparam CHANGE_1_DIGIT_MODE = 2;
  localparam CHANGE_2_DIGIT_MODE = 3;
  localparam CHANGE_3_DIGIT_MODE = 4;
  
  reg        set_was_pressed;
  reg  [2:0] state;
  
  wire [2:0] next_state;
  
  initial begin
    state = CHANGE_3_DIGIT_MODE + 1;
    set_was_pressed = 1;
    #PERIOD
    set_was_pressed = 0;
    #PERIOD
    state = IDLE;
    #PERIOD
    set_was_pressed = 1;
    #PERIOD
    set_was_pressed = 0;
    $finish;
  end
  
  state_machine DUT (
    .set_was_pressed_i        ( set_was_pressed        ),
    .state_i                  ( state                  ),
    .next_state_o             ( next_state             )
  );
endmodule
