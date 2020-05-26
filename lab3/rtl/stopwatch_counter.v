`timescale 1ns / 1ps

module stopwatch_counter(
input        clk_i,
input        arstn_i,
input        pulse_passed,
input        digit_counter,

output [3:0] senior_digit_passed,
output [6:0] hex_number
    );
    
parameter  COUNTER_MAX = 4'd9;

reg        digit_counter_buff;
wire       digit_passed = 
        ( ( digit_counter_buff == COUNTER_MAX ) & pulse_passed );

always @( posedge clk_i or negedge arstn_i ) begin
  if ( !arstn_i ) 
    digit_counter_buff <= 0;
  else if ( pulse_passed ) 
  begin
    if ( digit_passed )
      digit_counter_buff <= 0;
    else
      digit_counter_buff <= digit_counter_buff + 1;
  end
end

assign senior_digit_passed = digit_passed;
assign hex_number          = digit_counter_buff;
endmodule
