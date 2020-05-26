`timescale 1ns / 1ps

module hex_decoder (
     input      [3:0] data_i,
     output reg [6:0] data_o 
     );

always @( * ) begin
case ( data_i )
  4'd0:    data_o = 7'b1000000;
  4'd1:    data_o = 7'b1111001;
  4'd2:    data_o = 7'b0100100;
  4'd3:    data_o = 7'b0110000;
  4'd4:    data_o = 7'b0011001;
  4'd5:    data_o = 7'b0010010;
  4'd6:    data_o = 7'b0000010;
  4'd7:    data_o = 7'b1111000;
  4'd8:    data_o = 7'b0000000;
  4'd9:    data_o = 7'b0010000;
  4'd10:   data_o = 7'b0000110; // E for OVERLOAD_VALUE
  default: data_o = 7'b1111111; 
endcase
end
endmodule
