module HEX(
  input      [3:0] HEX_i,
  output reg [6:0] HEX_o
    );

  always @( * ) begin
    case ( HEX_i )
      4'h0:    HEX_o = 7'b1000000;
      4'h1:    HEX_o = 7'b1111001;
      4'h2:    HEX_o = 7'b0100100;
      4'h3:    HEX_o = 7'b0110000;
      4'h4:    HEX_o = 7'b0011001;
      4'h5:    HEX_o = 7'b0010010;
      4'h6:    HEX_o = 7'b0000010;
      4'h7:    HEX_o = 7'b1111000;
      4'h8:    HEX_o = 7'b0000000;
      4'h9:    HEX_o = 7'b0010000;
      4'ha:    HEX_o = 7'b0001000;
      4'hb:    HEX_o = 7'b0000011;
      4'hc:    HEX_o = 7'b1000110;
      4'hd:    HEX_o = 7'b0100001;
      4'he:    HEX_o = 7'b0000110;
      4'hf:    HEX_o = 7'b0001110;
      default: HEX_o = 7'b1111111;
    endcase
  end

endmodule
