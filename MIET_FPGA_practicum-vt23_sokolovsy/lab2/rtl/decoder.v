`timescale 1ns / 1ps

module decoder(
  input      [3:0] in,
  output reg [6:0] out
  );
    
  always @ ( * ) begin
    case( in )
      4'd0:   out = 7'b100_0000;
      4'd1:   out = 7'b111_1001;
      4'd2:   out = 7'b010_0100;
      4'd3:   out = 7'b011_0000;
      4'd4:   out = 7'b001_1001;
      4'd5:   out = 7'b001_0010;
      4'd6:   out = 7'b000_0010;
      4'd7:   out = 7'b111_1000;
      4'd8:   out = 7'b000_0000;
      4'd9:   out = 7'b001_0000;
      4'd10:  out = 7'b000_1000;
      4'd11:  out = 7'b000_0011;
      4'd12:  out = 7'b100_0110;
      4'd13:  out = 7'b010_0001;
      4'd14:  out = 7'b000_0110;
      4'd15:  out = 7'b000_1110; 
    endcase
  end     
  
endmodule

