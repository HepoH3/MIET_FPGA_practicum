`timescale 1ns / 1ps

module decoder (

  // Data input
  input  [3:0] data_i,
  
  // Data output
  output [6:0] hex_o
);

  reg [6:0] hex_data;
  
  always @( * ) begin
    case ( data_i )
      0  : hex_data = 7'b1000000;
      1  : hex_data = 7'b1111001;
      2  : hex_data = 7'b0100100;
      3  : hex_data = 7'b0110000;
      4  : hex_data = 7'b0011001;
      5  : hex_data = 7'b0010010;
      6  : hex_data = 7'b0000010;
      7  : hex_data = 7'b1111000;
      8  : hex_data = 7'b0000000;
      9  : hex_data = 7'b0010000;
      10 : hex_data = 7'b0001000;
      11 : hex_data = 7'b0000011;
      12 : hex_data = 7'b1000110;
      13 : hex_data = 7'b0100001;
      14 : hex_data = 7'b0000110;
      15 : hex_data = 7'b0001110;
    endcase
  end
  
  assign hex_o = hex_data;
endmodule
