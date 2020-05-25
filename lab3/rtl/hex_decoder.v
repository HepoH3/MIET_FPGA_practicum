`timescale 1ns / 1ps

module hex_decoder(
  input  [3:0] counter,
  output [6:0] hex
    );
    
    
reg [6:0] decoder;
always @( * ) begin
  case ( counter )
    4'd0:  decoder = 7'b0000001;
    4'd1:  decoder = 7'b1001111;
    4'd2:  decoder = 7'b0010010;
    4'd3:  decoder = 7'b0000110;
    4'd4:  decoder = 7'b1001100;
    4'd5:  decoder = 7'b0100100;
    4'd6:  decoder = 7'b0100000;
    4'd7:  decoder = 7'b0001111;
    4'd8:  decoder = 7'b0000000;
    4'd9:  decoder = 7'b0000100;
  default: decoder = 7'b1111111;
  endcase
end
assign hex = decoder;


endmodule
