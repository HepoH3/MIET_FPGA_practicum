`timescale 1ns / 1ps

module stopwatch (
  // External clock source
  input        clk100_i,
  
  // Reset and control inputs
  input        rstn_i,
  input        start_stop_i,
  input        set_i,
  input        change_i,
  
  // Data outputs
  output [6:0] hex3_o,
  output [6:0] hex2_o,
  output [6:0] hex1_o,
  output [6:0] hex0_o
);

  wire [6:0] hex3_data;
  wire [6:0] hex2_data;
  wire [6:0] hex1_data;
  wire [6:0] hex0_data;
  
  decoder decoder3(
    .data_i                  ( 0         ),
    .hex_o                   ( hex3_data )
  );
  
  decoder decoder2(
    .data_i                  ( 0         ),
    .hex_o                   ( hex2_data )
  );
  
  decoder decoder1(
    .data_i                  ( 0         ),
    .hex_o                   ( hex1_data )
  );
  
  decoder decoder0(
    .data_i                  ( 0         ),
    .hex_o                   ( hex0_data )
  );
  
  assign hex3_o = hex3_data;
  assign hex2_o = hex2_data;
  assign hex1_o = hex1_data;
  assign hex0_o = hex0_data;
endmodule
