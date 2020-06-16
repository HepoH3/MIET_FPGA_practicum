`timescale 1ns / 1ps

module counter(
  input         clk100_i,
  input         rstn_i,
  input   [9:0] sw_i,
  input   [1:0] key_i,
  
  output  [9:0] ledr_o,
  output  [6:0] hex0_o,
  output  [6:0] hex1_o,
  output  [6:0] hex2_o,
  output  [6:0] hex3_o
  );
  
  wire btn_was_pressed;
  
  keypress kp(
    .clk_i             ( clk100_i            ),
    .rstn_i            ( key_i           [1] ),
    .en_i              ( key_i           [0] ),
    .btn_was_pressed_o ( btn_was_pressed     ) 
  );
 
  register r(
    .data_i          ( sw_i            [9:0] ),
    .clk_i           ( clk100_i              ),
    .rstn_i          ( key_i           [1]   ),
    .data_o          ( ledr_o          [9:0] ),
    .btn_was_pressed ( btn_was_pressed       )
  );
  
  reg [15:0] counter;
 
  always @( posedge clk100_i or negedge key_i[1] )begin
    if( !key_i[1] ) 
      counter <= 0;
    else if( btn_was_pressed ) 
      counter <= counter + 1;
  end
  
  decoder d0( 
    .in  ( counter [3:0]  ),
    .out ( hex0_o         )
  );
  
  decoder d1( 
    .in  ( counter [7:4]  ),
    .out ( hex1_o         )
  );

  decoder d2( 
    .in  ( counter [11:8]  ),
    .out ( hex2_o          ) 
  );

  decoder d3( 
    .in  ( counter [15:12] ),
    .out ( hex3_o          )
  );

endmodule
