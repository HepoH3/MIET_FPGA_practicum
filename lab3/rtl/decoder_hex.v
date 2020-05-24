module decoder_hex(
  input       [3:0]  kod_i,
  output reg  [6:0]  hex_o
);

always @( * ) begin
  case ( kod_i )
    4'd0 : hex_o <= 7'b100_0000;
    4'd1 : hex_o <= 7'b111_1001;
    4'd2 : hex_o <= 7'b010_0100;
    4'd3 : hex_o <= 7'b011_0000;
    4'd4 : hex_o <= 7'b001_1001;
    4'd5 : hex_o <= 7'b001_0010;
    4'd6 : hex_o <= 7'b000_0010;
    4'd7 : hex_o <= 7'b111_1000;
    4'd8 : hex_o <= 7'b000_0000;
    4'd9 : hex_o <= 7'b001_0000;
    4'd10: hex_o <= 7'b000_1000;
    4'd11: hex_o <= 7'b000_0011;
    4'd12: hex_o <= 7'b100_0110;
    4'd13: hex_o <= 7'b010_0001;
    4'd14: hex_o <= 7'b000_0110;
    4'd15: hex_o <= 7'b000_1110;
    endcase
end

endmodule