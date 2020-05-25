`timescale 1ns / 1ps

module lab2(
  input        clk100_i,
   
  input  [9:0] sw_i,
  input  [1:0] key_i,
    
  output [9:0] ledr_o,
    
  output [6:0] hex0_o,
  output [6:0] hex1_o,
  output [6:0] hex2_o,
  output [6:0] hex3_o
);

reg   [2:0]  button_sync;
wire         key_pressed_true;

always @( posedge clk100_i or negedge key_i[1] ) 
  begin
    if ( ~key_i[1] )
      button_sync    <= 0;
    else
      button_sync[0] <= ~key_i[0];
      button_sync[1] <= button_sync[0];
      button_sync[2] <= button_sync[1];
  end

assign key_pressed_true = ~button_sync[2] & button_sync[1];

reg  [9:0]      reg_mass;
assign ledr_o = reg_mass;

reg  [15:0]     lab2;

always @( posedge clk100_i or negedge key_i[1] ) 
  begin
    if ( ~key_i[1] )
      begin
        lab2  <= 0; 
        reg_mass <= 0;
      end
    else if ( key_pressed_true )
      begin
        lab2  <= lab2 + 1; 
        reg_mass <= sw_i & (sw_i-1);
      end
  end


hex hex0 ( 
  .hex_i  ( lab2[3:0]    ),
  .hex_o ( hex0_o          )
 );

hex hex1 ( 
  .hex_i  ( lab2[7:4]    ),
  .hex_o ( hex1_o          )
 ); 
 
hex hex2 ( 
  .hex_i  ( lab2[11:8]   ),
  .hex_o ( hex2_o          )
 ); 
 
 hex hex3 ( 
   .hex_i  ( lab2[15:12] ),
   .hex_o ( hex3_o         )
 );
  
endmodule