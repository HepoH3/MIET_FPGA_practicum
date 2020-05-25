`timescale 1ns / 1ps

module btn_press(
  input         clk100_i,
  input         rstn_i,
  input         en_i, 
  output        en_down_o
  );

  reg [1:0] sync;

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i )
    sync <= 2'b0;
  else
    begin
      sync[0] <= en_i;
      sync[1] <= sync[0];
    end
end


assign en_down_o = ~sync[1] & sync[0];


endmodule 