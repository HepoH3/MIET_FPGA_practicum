`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.05.2020 13:47:53
// Design Name: 
// Module Name: mode_selector
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


module mode_selector(
  input               clk100_i,
  input               rstn_s_i,
  input               start_stop_s_reg_i,
  input               set_s_i,
  output  reg  [2:0]  main_selector_o
  );
  
  parameter NUM_OF_HEX = 3'b100;  
  wire selecting_input;
  assign selecting_input = ~start_stop_s_reg_i & set_s_i;
  
  always @( posedge clk100_i or posedge rstn_s_i ) begin
    if( rstn_s_i || start_stop_s_reg_i) begin
      main_selector_o <= 3'b000;
    end
    else if( selecting_input && !( main_selector_o[2:0] >= NUM_OF_HEX ) ) begin
      main_selector_o <= main_selector_o + 1;
    end
    else if( selecting_input && ( main_selector_o[2:0] >= NUM_OF_HEX ) ) begin
      main_selector_o <= 3'b000;
    end    
  end  
    
endmodule
