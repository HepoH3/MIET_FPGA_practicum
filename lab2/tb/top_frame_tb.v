`timescale 1ns / 1ps


module top_frame_tb();

reg [9:0]  sw;
reg [1:0]  KEY;
reg        clk_50;
wire [9:0]  led;
wire [6:0]  hex0;
wire [6:0]  hex1;

top_frame DUT(
.sw(sw),
.KEY(KEY),
.clk_50(clk_50),
.led(led),
.hex0(hex0),
.hex1(hex1)
);

initial begin 
  clk_50<=1'b0;
  forever #11 clk_50<=~clk_50;
end

initial begin
  KEY[0]<=1'b0;
  #20
  KEY[0]<=1'b1;
end

initial begin 
  sw[9:0]<=0;
  repeat(15) begin
    #9;
    sw[9:0]<=$random()/100;
  end
end

initial begin
  KEY[1] <= 0;
  forever #63 KEY[1]<=$random();
 end 

endmodule
