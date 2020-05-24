`timescale 1ns / 1ps

module Debounce(
  input         clk100_i,
  input         rstn_i,
  input         ev_i, 
  output        ev_o
  );

  reg [2:0] sync;
  
always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i ) begin
    sync <= 3'b0;
  end
  else begin
      sync[0] <= ev_i;
      sync[1] <= sync[0];
      sync[2] <= sync[1];
  end
end


assign ev_o = ~sync[2] & sync[1];


endmodule