`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.05.2020 19:49:59
// Design Name: 
// Module Name: decoder_4
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module decoder_4(
  input        [3:0]  bit4_i,
  output  reg  [6:0]  segment_o
  );
    
  always @( * ) begin
    case ( bit4_i[3:0] )   
      4'd0  : segment_o = 7'b100_0000;
      4'd1  : segment_o = 7'b111_1001;
      4'd2  : segment_o = 7'b010_0100;
      4'd3  : segment_o = 7'b011_0000;
      4'd4  : segment_o = 7'b001_1001;
      4'd5  : segment_o = 7'b001_0010;
      4'd6  : segment_o = 7'b000_0010;
      4'd7  : segment_o = 7'b111_1000;
      4'd8  : segment_o = 7'b000_0000;
      4'd9  : segment_o = 7'b001_0000;
      default: segment_o = 7'b111_1111;
    endcase
  end
endmodule
