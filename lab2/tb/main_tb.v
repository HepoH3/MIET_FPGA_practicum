`timescale 1ns / 1ps

module main_tb(
    );
  localparam CLK_FREQ_MHZ = 50;
  localparam CLK_SEMIPERIOD =( 1000 / CLK_FREQ_MHZ ) / 2;
  
  reg        CLK;
  reg  [1:0] key;
  reg  [9:0] sw;
  wire [9:0] ledr;
  wire [6:0] hex;
  wire [1:0] hex_on;
  
  main DUT(
   .CLK50(CLK),
   .sw(sw),
   .key(key),
   .ledr(ledr),
   .hex(hex),
   .hex_on(hex_on)
   );
   
 //Clock gen
 initial begin
    CLK = 1'b1;
    forever begin
      #CLK_SEMIPERIOD CLK=~CLK;
    end
 end
 //Reset gen
 initial begin
      key[1]=1'b0;
      forever begin
        #( 10 * CLK_SEMIPERIOD ) key[1]=1'b1;
        #( 10 * CLK_SEMIPERIOD ) key[1]=1'b0;
      end
 end
 //Signals gen
 initial begin
     key[0]   = 1'b0;
     sw [9:0] = 10'b0000000000;
     forever begin
        #( 2 * CLK_SEMIPERIOD ) 
        key[0]=1'b1;
        #( 2 * CLK_SEMIPERIOD ) 
        key[0]=1'b0;
        sw[9:0]=$random%1024;
     end
 end
endmodule
