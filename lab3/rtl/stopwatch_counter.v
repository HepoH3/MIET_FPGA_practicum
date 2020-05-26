`timescale 1ns / 1ps

module stopwatch_counter(
input         clk_i,
input         arstn_i,
input         pulse_passed,
input  [3:0]  digit_counter,

output        senior_digit_passed,
output [3:0]  hex_number
    );
    
parameter  COUNTER_MAX = 4'd9;

reg    [3:0] digit_counter_buff = 4'd0;
wire         digit_passed = 
        ( ( digit_counter_buff == COUNTER_MAX ) & pulse_passed );

always @(digit_counter) begin
assign digit_counter_buff = digit_counter;
end

always @( posedge clk_i or negedge arstn_i ) begin
  if ( !arstn_i ) 
    digit_counter_buff <= { 4 { 1'b0 } };
  else if ( pulse_passed ) 
  begin
    if ( digit_passed )
      digit_counter_buff <= { 4 { 1'b0 } };
    else
      digit_counter_buff <= digit_counter_buff + 1;
  end
end

assign senior_digit_passed = digit_passed;
assign hex_number          = digit_counter_buff;
endmodule
