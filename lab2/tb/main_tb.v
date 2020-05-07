`timescale 1ns / 1ps


module main_tb();



reg [9:0]SW;
reg [1:0]KEY;
reg CLK50;
wire [9:0] LEDR;
wire [6:0] HEX0;
wire [6:0] HEX1;

main_dev DUT(
 .SW_i( SW [9:0] ),
 .KEY_i ( KEY [1:0] ),
 .CLK50_i ( CLK50 ),
 .LEDR_o ( LEDR [9:0] ),
 .HEX0_o ( HEX0 [6:0] ),
 .HEX1_o ( HEX1 [6:0] )
);

initial begin 
 CLK50<=1'b0;
 forever #10 CLK50<=~CLK50;
end

initial begin
 KEY[1]<=1'b0;
 # 20
  KEY[1]<=1'b1;
end

initial begin 
 SW[9:0]<=10'd14;
 repeat(15) begin
  #50;
  SW[9:0]<=SW[9:0]+1;
 end
end
 
initial begin
 KEY[0]<=1'b0;
forever #20 KEY[0]<=~KEY[0];   
 end 
endmodule


