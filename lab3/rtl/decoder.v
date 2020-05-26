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
  input  [3:0] counter_i,
  output [6:0] hex_o
);


reg [6:0] decoder;
always @( * ) begin
  case ( counter_i )      
    4'd0    : decoder = 7'b100_0000;
    4'd1    : decoder = 7'b111_1001;
    4'd2    : decoder = 7'b010_0100;
    4'd3    : decoder = 7'b011_0000;
    4'd4    : decoder = 7'b001_1001;
    4'd5    : decoder = 7'b001_0010;
    4'd6    : decoder = 7'b000_0010;
    4'd7    : decoder = 7'b111_1000;
    4'd8    : decoder = 7'b000_0000;
    4'd9    : decoder = 7'b001_0000;
    default : decoder = 7'b000_0000;
  endcase
end
assign hex_o = decoder;


endmodule
