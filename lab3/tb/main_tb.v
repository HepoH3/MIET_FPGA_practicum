`timescale 1ns / 1ps

module counter_tb(

);

localparam CLK_FREQ_MHZ   = 100;
localparam CLK_SEMIPERIOD = ( 1000 / CLK_FREQ_MHZ) / 2;     

reg          clk100_i;
reg   [9:0]  sw;
reg   [1:0]  key;
wire  [9:0]  ledr;
wire  [6:0]  hex0;
wire  [6:0]  hex1;
wire  [6:0]  hex2;
wire  [6:0]  hex3;

counter DUT   (
  .clk100_i   (  clk100_i          ),
  .sw_i       (  sw    [9:0]     ),
  .ledr_o     (  ledr  [9:0]     ),
  .key_i      (  key   [1:0]     ),
  .hex0_o     (  hex0  [6:0]     ),
  .hex1_o     (  hex1  [6:0]     ),
  .hex2_o     (  hex2  [6:0]     ),
  .hex3_o     (  hex3  [6:0]     )
);

initial begin
  clk100_i = 1'b1;
  forever
    #CLK_SEMIPERIOD clk100_i = ~clk100_i;
end

initial begin
  key[1] = 1'b1;
  #(2*CLK_SEMIPERIOD);
  key[1] = 1'b0;
  #(2*CLK_SEMIPERIOD);
  key[1] = 1'b1;
end

initial begin
  sw       = 10'b0;
  key[0]   = 1'b1;
  repeat(40)begin
    #(CLK_SEMIPERIOD - 1);
    sw     = $random();
    #(3*CLK_SEMIPERIOD);
    key[0] = 1'b0;
    #(3*CLK_SEMIPERIOD);
    key[0] = 1'b1;
  end
end    
    
endmodule