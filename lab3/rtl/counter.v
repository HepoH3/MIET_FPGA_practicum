`timescale 1ns / 1ps

module counter(
  input            clk_i,
  input            rstn_i,
  input            type_of_time1_i,
  input            type_of_time2_i,
  
  output reg [3:0] counter_o
  );
    
always @( posedge clk_i or negedge rstn_i ) begin
  if ( !rstn_i )
    counter_o <= 0;
  else if ( type_of_time1_i )
    if ( type_of_time2_i )
      counter_o <= 0;
    else 
      counter_o <= counter_o + 1;
end
    
    
endmodule
