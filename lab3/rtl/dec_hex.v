module dec_hex (
  input        [3:0]    in,
  output reg   [6:0]    ex);

always @( * ) begin
  case( in )
    4'h0 : ex = 7'b1000000;
    4'h1 : ex = 7'b1111001;
    4'h2 : ex = 7'b0100100;
    4'h3 : ex = 7'b0110000;
    4'h4 : ex = 7'b0011001;
    4'h5 : ex = 7'b0010010;
    4'h6 : ex = 7'b0000010;
    4'h7 : ex = 7'b1111000;
    4'h8 : ex = 7'b0000000;
    4'h9 : ex = 7'b0010000;
    4'ha : ex = 7'b0001000;
    4'hb : ex = 7'b0000011;
    4'hc : ex = 7'b1000110;
    4'hd : ex = 7'b0100001;
    4'he : ex = 7'b0000110;
    4'hf : ex = 7'b0001110;
  endcase
end

endmodule