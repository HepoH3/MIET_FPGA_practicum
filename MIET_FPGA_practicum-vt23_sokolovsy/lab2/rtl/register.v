`timescale 1ns / 1ps

module register(
  input      [9:0]  data_i,             
  input             clk_i,           
  input             rstn_i,           
  input             btn_was_pressed, 
    
  output reg [9:0]  data_o       
  );
  
  wire [9:0] res;
  
  assign res = data_i & ( - data_i );
  
  always @( posedge clk_i or negedge rstn_i ) begin
    if ( !rstn_i ) 
      data_o <= 0;
    else if ( btn_was_pressed ) 
      data_o <= res;
  end 
 
endmodule
