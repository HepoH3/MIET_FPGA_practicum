`timescale 1ns / 1ps


module button_fix(
  input  clk100_i,
  input  reset_i,
  input  key_i,
  output ondn_o);

reg [1:0] sync;

always @( posedge clk100_i or negedge reset_i ) begin
  if( !reset_i )
    sync <= 2'b0;
  else
    begin
      sync[0] <= key_i;
      sync[1] <= sync[0];
    end
end

assign ondn_o = ~sync[1] & sync[0];

endmodule