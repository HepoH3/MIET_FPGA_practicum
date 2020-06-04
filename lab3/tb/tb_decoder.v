`timescale  1ns / 1ps

module tb_decoder;

  localparam PERIOD = 20;
  
  reg  [3:0] data;
  
  wire [6:0] hex;
  
  initial begin
    data = 0;
    #PERIOD data =  1;
    #PERIOD data =  2;
    #PERIOD data =  3;
    #PERIOD data =  4;
    #PERIOD data =  5;
    #PERIOD data =  6;
    #PERIOD data =  7;
    #PERIOD data =  8;
    #PERIOD data =  9;
    #PERIOD data = 10;
    #PERIOD data = 11;
    #PERIOD data = 12;
    #PERIOD data = 13;
    #PERIOD data = 14;
    #PERIOD data = 15;
    #PERIOD $finish;
  end
  
  decoder  DUT (
    .data_i                  ( data [3:0] ),
    .hex_o                   ( hex          [6:0] )
  );
endmodule
