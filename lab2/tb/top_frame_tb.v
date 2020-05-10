`timescale 1ns / 1ps


module top_frame_tb();

reg  [9:0]  sw;
reg  [1:0]  key_i;
reg        clk_50;
wire [9:0]  led_o;
wire [6:0]  hex0_o;
wire [6:0]  hex1_o;

top_frame DUT(
  .sw(sw),
  .key_i(  key_i  ),
  .clk_50( clk_50 ),
  .led_o(  led_o  ),
  .hex0_o( hex0_o ),
  .hex1_o( hex1_o )
);

initial begin 
  clk_50<=1'b0;
  forever #11 clk_50<=~clk_50;
end

initial begin
  key_i[1]<=1'b1;
  #20
  key_i[1]<=1'b0;
  #20
  key_i[1]<=1'b1;
  #140
  key_i[1]<=1'b0;
  #150
  key_i[1]<=1'b1;
  
end

initial begin 
  sw[9:0]<=0;
  repeat(15) begin
    #9;
    sw[9:0]<=$random()/100;
  end
end

initial begin
  key_i[0] <= 1;
  forever #32 key_i[0]<= $random();
 end 

endmodule
