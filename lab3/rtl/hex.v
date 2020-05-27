`timescale 1ns / 1ps

module hex(
  input  [3:0] counter_i,
  output [6:0] hex_o
);


reg [6:0] hex_to_out;
always @( * ) begin
  case ( counter_i )      
    4'd0    : hex_to_out = 7'b1000000;
    4'd1    : hex_to_out = 7'b1111001;
    4'd2    : hex_to_out = 7'b0100100;
    4'd3    : hex_to_out = 7'b0110000;
    4'd4    : hex_to_out = 7'b0011001;
    4'd5    : hex_to_out = 7'b0010010;
    4'd6    : hex_to_out = 7'b0000010;
    4'd7    : hex_to_out = 7'b1111000;
    4'd8    : hex_to_out = 7'b0000000;
    4'd9    : hex_to_out = 7'b0010000;
    default : hex_to_out = 7'b0000000;
  endcase
end
assign hex_o = hex_to_out;


endmodule