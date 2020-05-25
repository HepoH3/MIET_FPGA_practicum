`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.05.2020 18:49:34
// Design Name: 
// Module Name: reset_block
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


module reset_block(
  input               clk100_i,
  input               rstn_s_i,
  input        [3:0]  ms10_counter_i,
  input        [3:0]  ms100_counter_i,
  input        [3:0]  s1_counter_i,
  input        [3:0]  s10_counter_i,
  output  reg  [3:0]  reset_array
  );
  
  parameter BIT_DEPTH_OF_CLOCK = 4'd10;
  wire  [3:0]  is_counter_full;
  
  assign is_counter_full[0] = ( ms10_counter_i == BIT_DEPTH_OF_CLOCK );
  assign is_counter_full[1] = ( ms100_counter_i == BIT_DEPTH_OF_CLOCK );
  assign is_counter_full[2] = ( s1_counter_i == BIT_DEPTH_OF_CLOCK );
  assign is_counter_full[3] = ( s10_counter_i == BIT_DEPTH_OF_CLOCK );
  
  always @( negedge clk100_i or posedge is_counter_full[0] or posedge is_counter_full[1] or posedge is_counter_full[2] or posedge is_counter_full[3] or posedge rstn_s_i) begin
    if ( rstn_s_i ) begin
      reset_array <= 4'd0;
    end
    else begin
    
      if ( is_counter_full[0] ) begin
        reset_array[0] <= 1'b1;
      end    
      if ( is_counter_full[1] ) begin
        reset_array[1] <= 1'b1;
      end
      if ( is_counter_full[2] ) begin
        reset_array[2] <= 1'b1;
      end
      if ( is_counter_full[3] ) begin
        reset_array[3] <= 1'b1;
      end
      
      if (reset_array[0] & ~clk100_i ) begin
        reset_array[0] <= 1'b0;
      end
      if (reset_array[1] & ~clk100_i ) begin
        reset_array[1] <= 1'b0;
      end
      if (reset_array[2] & ~clk100_i ) begin
        reset_array[2] <= 1'b0;
      end
      if (reset_array[3] & ~clk100_i ) begin
        reset_array[3] <= 1'b0;
      end
      
    end
  end
  
//  always @( negedge clk100_i ) begin
//    if (reset_array[0] & ~clk100_i ) begin
//        reset_array[0] <= 1'b0;
//    end
//    if (reset_array[1] & ~clk100_i ) begin
//        reset_array[1] <= 1'b0;
//    end
//    if (reset_array[2] & ~clk100_i ) begin
//        reset_array[2] <= 1'b0;
//    end
//    if (reset_array[3] & ~clk100_i ) begin
//        reset_array[3] <= 1'b0;
//    end
//  end
endmodule
