`timescale 1ns / 1ps

module button_pullup(
  input   clk100_i,
  input   rstn_i,
  input   button_i,
  output  button_o
  );

reg  [2:0] button_sync;

always @(posedge clk100_i or posedge rstn_i ) begin
  if ( rstn_i )
    button_sync <= 3'd0;
  else begin
  button_sync[0] <= ~button_i;
  button_sync[1] <= button_sync[0];
  button_sync[2] <= button_sync[1];
  end
end

assign button_o = ~button_sync[2] & button_sync[1];

endmodule
