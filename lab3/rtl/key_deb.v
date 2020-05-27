`timescale 1ns / 1ps

module key_deb(
  input  btn_i,
  input  rst_i,
  input  clk_i,
  output btn_down_o);

reg [1:0] sync;

always @( posedge clk_i or negedge rst_i ) begin
  if ( !rst_i )
    sync <= 2'b0;
  else
    begin
      sync[0] <= btn_i;
      sync[1] <= sync[0];
    end
end

assign btn_down_o = ~sync[1] & sync[0];

endmodule
