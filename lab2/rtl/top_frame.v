`timescale 1ns / 1ps


module top_frame(
  input      [9:0]  sw,                     
  input      [1:0]  KEY,                    
  input             clk_50, 
                
  output     [9:0]  led,                    
  output reg [6:0]  hex0,                    
  output reg [6:0]  hex1 
    );

wire [7:0] counter_value; 

counter counter_elem(
.en_i(KEY[0]),
.clk_i(clk_50),
.rstn_i(KEY[1]),
.sw_i(sw),
.counter_o(counter_value)
);

reg_10_bit register(
.data_i(sw),
.clk_i(clk_50),
.rstn_i(KEY[1]),
.en_i(KEY[0]),
.register_o(led)
);

always @( posedge clk_50 ) begin
  case ( counter_value [3:0] )  
    4'd0:   hex0=7'b1000000;
    4'd1:   hex0=7'b1111001;
    4'd2:   hex0=7'b0100100;
    4'd3:   hex0=7'b0110000;
    4'd4:   hex0=7'b0011001;
    4'd5:   hex0=7'b001001;
    4'd6:   hex0=7'b0000010;
    4'd7:   hex0=7'b1111000;
    4'd8:   hex0=7'b0000000;
    4'd9:   hex0=7'b0010000;
    4'd10:  hex0=7'b0001000;
    4'd11:  hex0=7'b0100001;
    4'd12:  hex0=7'b1000110;
    4'd13:  hex0=7'b0000011;
    4'd14:  hex0=7'b0000110;
    4'd15:  hex0=7'b0001110;  
  endcase
end

always @( posedge clk_50 ) begin
  case ( counter_value [7:4] )  
    4'd0:   hex1=7'b1000000;
    4'd1:   hex1=7'b1111001;
    4'd2:   hex1=7'b0100100;
    4'd3:   hex1=7'b0110000;
    4'd4:   hex1=7'b0011001;
    4'd5:   hex1=7'b001001;
    4'd6:   hex1=7'b0000010;
    4'd7:   hex1=7'b1111000;
    4'd8:   hex1=7'b0000000;
    4'd9:   hex1=7'b0010000;
    4'd10:  hex1=7'b0001000;
    4'd11:  hex1=7'b0100001;
    4'd12:  hex1=7'b1000110;
    4'd13:  hex1=7'b0000011;
    4'd14:  hex1=7'b0000110;
    4'd15:  hex1=7'b0001110;  
  endcase
end


endmodule
