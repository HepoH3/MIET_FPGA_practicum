`timescale 1ns / 1ps

module button_sync(
  input   clk100_i,
  input   rstn_i,
  input   btn_i,
  output  btn_o
  );
  
reg [2:0] button_syncroniser;

always @( posedge clk100_i or negedge rstn_i ) 
  begin
    if ( !rstn_i )
      button_syncroniser    <= 3'b0;
    else
      button_syncroniser[0] <= btn_i;
      button_syncroniser[1] <= button_syncroniser[0];
      button_syncroniser[2] <= button_syncroniser[1];
  end

assign btn_o = !button_syncroniser[2] & button_syncroniser[1];
 
endmodule
