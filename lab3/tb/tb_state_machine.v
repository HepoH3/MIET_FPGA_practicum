`timescale 1ns / 1ps

module tb_state_machine;

  localparam PERIOD = 20;
  
  reg  start_stop_was_pressed;
  reg  set_was_pressed;
  reg  state;
  
  wire next_state;
  
  initial begin
    #PERIOD $finish;
  end
  
  state_machine DUT (
    .start_stop_was_pressed_i ( start_stop_was_pressed ),
    .set_was_pressed_i        ( set_was_pressed        ),
    .state_i                  ( state                  ),
    .next_state_o             ( next_state             )
  );
endmodule
