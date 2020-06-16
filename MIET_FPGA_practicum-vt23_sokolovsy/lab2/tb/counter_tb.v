`timescale 1ns / 1ps



module counter_tb();
       
  reg  [9:0]   sw;
  reg  [1:0]   key;
  reg          clk100;
  wire [9:0]   ledr;
  wire [6:0]   hex0;
  wire [6:0]   hex1;
  wire [6:0]   hex2;
  wire [6:0]   hex3;

  counter DUT(
   .sw_i     ( sw     [9:0] ),
   .key_i    ( key    [1:0] ),
   .clk100_i ( clk100       ),
   .ledr_o   ( ledr   [9:0] ),
   .hex0_o   ( hex0   [6:0] ),
   .hex1_o   ( hex1   [6:0] ),
   .hex2_o   ( hex2   [6:0] ),
   .hex3_o   ( hex3   [6:0] )
  );

  initial begin 
    clk100 <= 1'b1;
    forever #5 clk100 <= ~clk100;
  end

  initial begin
    key[1] <= 1'b1;
    #11
    key[1] <= 1'b0; 
  end

  initial begin 
    sw[9:0] <= 10'd0;
    repeat(15)
    begin
      #50;
      sw[9:0] = $random();
    end
  end
 
  initial begin
    key[0] <= 1'b1;
    forever #22 key[0] <= ~key[0];   
  end 
  
endmodule
