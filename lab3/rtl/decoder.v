`timescale 1ns / 1ps

module decoder(
  input   [3:0] in,
  
  output  [6:0] out
);

reg [6:0] dec;
always @ ( * ) begin
  case ( in )
    4'd0:    dec = 7'b0000001;
    4'd1:    dec = 7'b1001111;
    4'd2:    dec = 7'b0010010;
    4'd3:    dec = 7'b0000110;
    4'd4:    dec = 7'b1001100;
    4'd5:    dec = 7'b0100100;
    4'd6:    dec = 7'b0100000;
    4'd7:    dec = 7'b0001111;
    4'd8:    dec = 7'b0000000;
    4'd9:    dec = 7'b0000100;
    default: dec = 7'b1111111;
  endcase
end

assign out = dec;

endmodule