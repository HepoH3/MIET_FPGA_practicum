`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.05.2020 17:05:39
// Design Name: 
// Module Name: decoder
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


module decoder(
  input  [3:0] hundredths_counter,
  input  [3:0] tenths_counter,
  input  [3:0] seconds_counter,
  input  [3:0] ten_seconds_counter,
  output [6:0] hex0_o,
  output [6:0] hex1_o,
  output [6:0] hex2_o,
  output [6:0] hex3_o
);


reg [6:0] decoder_ten_seconds;
always @( * ) begin
  case ( ten_seconds_counter )      
    4'd0    : decoder_ten_seconds = 7'b100_0000;
    4'd1    : decoder_ten_seconds = 7'b111_1001;
    4'd2    : decoder_ten_seconds = 7'b010_0100;
    4'd3    : decoder_ten_seconds = 7'b011_0000;
    4'd4    : decoder_ten_seconds = 7'b001_1001;
    4'd5    : decoder_ten_seconds = 7'b001_0010;
    4'd6    : decoder_ten_seconds = 7'b000_0010;
    4'd7    : decoder_ten_seconds = 7'b111_1000;
    4'd8    : decoder_ten_seconds = 7'b000_0000;
    4'd9    : decoder_ten_seconds = 7'b001_0000;
    default : decoder_ten_seconds = 7'b000_0000;
  endcase
end
assign hex3_o = decoder_ten_seconds;


reg [6:0] decoder_seconds;
always @( * ) begin
  case ( seconds_counter )      
    4'd0    : decoder_seconds = 7'b100_0000;
    4'd1    : decoder_seconds = 7'b111_1001;
    4'd2    : decoder_seconds = 7'b010_0100;
    4'd3    : decoder_seconds = 7'b011_0000;
    4'd4    : decoder_seconds = 7'b001_1001;
    4'd5    : decoder_seconds = 7'b001_0010;
    4'd6    : decoder_seconds = 7'b000_0010;
    4'd7    : decoder_seconds = 7'b111_1000;
    4'd8    : decoder_seconds = 7'b000_0000;
    4'd9    : decoder_seconds = 7'b001_0000;
    default : decoder_seconds = 7'b000_0000;
  endcase
end
assign hex2_o = decoder_seconds;


reg [6:0] decoder_tenths;
always @( * ) begin
  case ( tenths_counter )      
    4'd0    : decoder_tenths = 7'b100_0000;
    4'd1    : decoder_tenths = 7'b111_1001;
    4'd2    : decoder_tenths = 7'b010_0100;
    4'd3    : decoder_tenths = 7'b011_0000;
    4'd4    : decoder_tenths = 7'b001_1001;
    4'd5    : decoder_tenths = 7'b001_0010;
    4'd6    : decoder_tenths = 7'b000_0010;
    4'd7    : decoder_tenths = 7'b111_1000;
    4'd8    : decoder_tenths = 7'b000_0000;
    4'd9    : decoder_tenths = 7'b001_0000;
    default : decoder_tenths = 7'b000_0000;
  endcase
end
assign hex1_o = decoder_tenths;


reg [6:0] decoder_hundredths;
always @( * ) begin
  case ( hundredths_counter )      
    4'd0    : decoder_hundredths = 7'b100_0000;
    4'd1    : decoder_hundredths = 7'b111_1001;
    4'd2    : decoder_hundredths = 7'b010_0100;
    4'd3    : decoder_hundredths = 7'b011_0000;
    4'd4    : decoder_hundredths = 7'b001_1001;
    4'd5    : decoder_hundredths = 7'b001_0010;
    4'd6    : decoder_hundredths = 7'b000_0010;
    4'd7    : decoder_hundredths = 7'b111_1000;
    4'd8    : decoder_hundredths = 7'b000_0000;
    4'd9    : decoder_hundredths = 7'b001_0000;
    default : decoder_hundredths = 7'b000_0000;
  endcase
end
assign hex0_o = decoder_hundredths;


endmodule
