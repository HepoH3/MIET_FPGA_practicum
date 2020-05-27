`timescale  1ns / 1ps

module tb_decoder;

  localparam PERIOD = 20;
  
  reg  [3:0] counter_data;
  
  wire [6:0] hex;
  
  initial begin
    counter_data = 0;
    #PERIOD counter_data =  1;
    #PERIOD counter_data =  2;
    #PERIOD counter_data =  3;
    #PERIOD counter_data =  4;
    #PERIOD counter_data =  5;
    #PERIOD counter_data =  6;
    #PERIOD counter_data =  7;
    #PERIOD counter_data =  8;
    #PERIOD counter_data =  9;
    #PERIOD counter_data = 10;
    #PERIOD counter_data = 11;
    #PERIOD counter_data = 12;
    #PERIOD counter_data = 13;
    #PERIOD counter_data = 14;
    #PERIOD counter_data = 15;
    #PERIOD $finish;
  end
  
  decoder  DUT (
    .counter_i               ( counter_data [3:0] ),
    .hex_o                   ( hex          [6:0] )
  );
endmodule
