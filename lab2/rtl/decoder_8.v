`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.05.2020 19:49:59
// Design Name: 
// Module Name: decoder_8
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


module decoder_8(
    input        [3:0]  bit4_0_i,
    input        [3:0]  bit4_1_i,
    output  reg  [6:0]  segment_0_o,
    output  reg  [6:0]  segment_1_o
    );
    
  always @( * ) begin
    case ( bit4_0_i[3:0] )        //На первый индикатор выводятся первые 4 бита счётчика
      4'd0  : segment_0_o = 7'b100_0000;
      4'd1  : segment_0_o = 7'b111_1001;
      4'd2  : segment_0_o = 7'b010_0100;
      4'd3  : segment_0_o = 7'b011_0000;
      4'd4  : segment_0_o = 7'b001_1001;
      4'd5  : segment_0_o = 7'b001_0010;
      4'd6  : segment_0_o = 7'b000_0010;
      4'd7  : segment_0_o = 7'b111_1000;
      4'd8  : segment_0_o = 7'b000_0000;
      4'd9  : segment_0_o = 7'b001_0000;
      4'd10 : segment_0_o = 7'b000_1000;
      4'd11 : segment_0_o = 7'b000_0011;
      4'd12 : segment_0_o = 7'b100_0110;
      4'd13 : segment_0_o = 7'b010_0001;
      4'd14 : segment_0_o = 7'b000_0110;
      4'd15 : segment_0_o = 7'b000_1110;
    endcase
    case ( bit4_1_i[3:0] )        //На второй индикатор выводятся вторые 4 бита счётчика
      4'd0  : segment_1_o = 7'b100_0000;
      4'd1  : segment_1_o = 7'b111_1001;
      4'd2  : segment_1_o = 7'b010_0100;
      4'd3  : segment_1_o = 7'b011_0000;
      4'd4  : segment_1_o = 7'b001_1001;
      4'd5  : segment_1_o = 7'b001_0010;
      4'd6  : segment_1_o = 7'b000_0010;
      4'd7  : segment_1_o = 7'b111_1000;
      4'd8  : segment_1_o = 7'b000_0000;
      4'd9  : segment_1_o = 7'b001_0000;
      4'd10 : segment_1_o = 7'b000_1000;
      4'd11 : segment_1_o = 7'b000_0011;
      4'd12 : segment_1_o = 7'b100_0110;
      4'd13 : segment_1_o = 7'b010_0001;
      4'd14 : segment_1_o = 7'b000_0110;
      4'd15 : segment_1_o = 7'b000_1110;
    endcase
  end
endmodule
