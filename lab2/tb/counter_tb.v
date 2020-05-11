`timescale 1ns / 1ps


module counter_tb();

reg  [9:0]  sw_i;
reg  [1:0]  key_i;
reg        clk100_i;
wire [9:0]  ledr_o;
wire [6:0]  hex0_o;
wire [6:0]  hex1_o;

counter DUT(
  .sw_i(     sw_i     ),
  .key_i(    key_i    ),
  .clk100_i( clk100_i ),
  .ledr_o(   ledr_o   ),
  .hex0_o(   hex0_o   ),
  .hex1_o(   hex1_o   )
); 

initial begin 
  clk100_i<=1'b0;
  forever #11 clk100_i<=~clk100_i;
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
  sw_i[9:0]<=0;
  repeat(15) begin
    #9;
    sw_i[9:0]<=$random()/100;
  end
end

initial begin
  key_i[0] <= 1;
  forever #32 key_i[0]<= $random();
 end 

endmodule
