`timescale 1ns / 1ps


module main_dev(
 input [9:0]SW_i,
 input [1:0]KEY_i,
 input CLK50_i,
  output [9:0] LEDR_o,
 output reg [6:0] HEX0_o,
 output reg [6:0] HEX1_o
    );

 dff_leds dff(
  .data_i( SW_i[9:0] ),
  .clk_i ( CLK50_i ),
  .rstn_i ( KEY_i[1] ),
  .en_i  ( KEY_i[0] ),
  . q_o  ( LEDR_o )
 );
 
wire [7:0] counter;

count_event count(
 . CLK50_i( CLK50_i ),
 . en_i ( KEY_i[0] ),
 . resetn_i ( KEY_i[1] ),
 . SW_i ( SW_i[9:0] ),
 . counter_o ( counter[7:0] )
);

always @( posedge CLK50_i )begin
 case( counter [3:0] )
    4'd0:   HEX0_o=7'b1000000;
    4'd1:   HEX0_o=7'b1111001;
    4'd2:   HEX0_o=7'b0100100;
    4'd3:   HEX0_o=7'b0110000;
    4'd4:   HEX0_o=7'b0011001;
    4'd5:   HEX0_o=7'b0010010;
    4'd6:   HEX0_o=7'b0000010;
    4'd7:   HEX0_o=7'b1111000;
    4'd8:   HEX0_o=7'b0000000;
    4'd9:   HEX0_o=7'b0010000;
    4'd10:  HEX0_o=7'b0001000;
    4'd11:  HEX0_o=7'b0000011;
    4'd12:  HEX0_o=7'b1000110;
    4'd13:  HEX0_o=7'b0100001;
    4'd14:  HEX0_o=7'b0000110;
    4'd15:  HEX0_o=7'b0001110; 
    endcase
 end
 always @( posedge CLK50_i )begin   
 case( counter [7:4] )
    4'd0:   HEX1_o=7'b1000000;
    4'd1:   HEX1_o=7'b1111001;
    4'd2:   HEX1_o=7'b0100100;
    4'd3:   HEX1_o=7'b0110000;
    4'd4:   HEX1_o=7'b0011001;
    4'd5:   HEX1_o=7'b0010010;
    4'd6:   HEX1_o=7'b0000010;
    4'd7:   HEX1_o=7'b1111000;
    4'd8:   HEX1_o=7'b0000000;
    4'd9:   HEX1_o=7'b0010000;
    4'd10:  HEX1_o=7'b0001000;
    4'd11:  HEX1_o=7'b0000011;
    4'd12:  HEX1_o=7'b1000110;
    4'd13:  HEX1_o=7'b0100001;
    4'd14:  HEX1_o=7'b0000110;
    4'd15:  HEX1_o=7'b0001110; 
    endcase
end
  
endmodule
