`timescale 1ns / 1ps

module tb_lab2(

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

lab2 DUT (
  .clk100_i  (  clk100_i ),
  .sw_i      (  sw       ),
  .ledr_o    (  ledr     ),
  .key_i     (  key      ),
  .hex0_o    (  hex0     ),
  .hex1_o    (  hex1     ),
  .hex2_o    (  hex2     ),
  .hex3_o    (  hex3     )
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
