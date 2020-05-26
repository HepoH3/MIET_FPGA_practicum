`timescale 1ns / 1ps

module pressButton(
  input         clk_i,
  input         arstn_i,
  input         button_i, 
  output        button_down_o
  );

reg [2:0] sync;

always @( posedge clk_i ) begin
  sync[0] <= button_i;
  sync[1] <= sync[0];
  sync[2] <= sync[1];
end

assign button_down_o = sync[2] & ~sync[1];


endmodule