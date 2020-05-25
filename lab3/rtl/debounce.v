`timescale 1ns / 1ps

module debounce(
  input  clk_i,
  input  rst_i,
  input  btn_i,
  output btn_o);

reg [1:0] sync;

always @( posedge clk_i or negedge rst_i ) begin
  if( !rst_i )
    sync <= 2'b0;
  else
    begin
      sync[0] <= btn_i;
      sync[1] <= sync[0];
    end
end

assign btn_o = ~sync[1] & sync[0];

endmodule