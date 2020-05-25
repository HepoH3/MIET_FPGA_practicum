`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.05.2020 18:12:18
// Design Name: 
// Module Name: counter_array
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


module counter_array(
  input          clk100_i,
  input          rstn_s_i,
  input          start_stop_s_reg_i,
  input          change_s_i,
  input   [2:0]  main_selector_i,
  output  [3:0]  ms10_counter_o,
  output  [3:0]  ms100_counter_o,
  output  [3:0]  s1_counter_o,
  output  [3:0]  s10_counter_o
  );
   
  wire  [3:0]  reset_array;
  wire  [3:0]  enable_array;
  wire  [3:0]  counter_almost_full;
  wire         timer_full;
   
  assign enable_array[0] = ( start_stop_s_reg_i & timer_full     & ( main_selector_i == 3'b000) ) || ( ~start_stop_s_reg_i & ( main_selector_i == 3'b001) & change_s_i );
  assign enable_array[1] = ( start_stop_s_reg_i & reset_array[0] & ( main_selector_i == 3'b000) ) || ( ~start_stop_s_reg_i & ( main_selector_i == 3'b010) & change_s_i );
  assign enable_array[2] = ( start_stop_s_reg_i & reset_array[1] & ( main_selector_i == 3'b000) ) || ( ~start_stop_s_reg_i & ( main_selector_i == 3'b011) & change_s_i );
  assign enable_array[3] = ( start_stop_s_reg_i & reset_array[2] & ( main_selector_i == 3'b000) ) || ( ~start_stop_s_reg_i & ( main_selector_i == 3'b100) & change_s_i );
   
  reset_block resets_for_counters(
    .clk100_i           (  clk100_i              ),
    .rstn_s_i           (  rstn_s_i              ),
    .ms10_counter_i     (  ms10_counter_o[3:0]   ),
    .ms100_counter_i    (  ms100_counter_o[3:0]  ),
    .s1_counter_i       (  s1_counter_o[3:0]     ),
    .s10_counter_i      (  s10_counter_o[3:0]    ),
    .reset_array        (  reset_array[3:0]      )
  ); 
  
  ms10_timer timer(
    .clk_i         (  clk100_i            ),
    .rst_i         (  rstn_s_i            ),
    .en_i          (  start_stop_s_reg_i  ),
    .timer_full_o  (  timer_full          )
  ); 
      
  counter_4 ms10(
    .rst_i        (  rstn_s_i             ),
    .count_rst_i  (  reset_array[0]       ),
    .en_i         (  enable_array[0]      ),
    .counter_o    (  ms10_counter_o[3:0]  )
  ); 
  
  counter_4 ms100(
    .rst_i        (  rstn_s_i              ),
    .count_rst_i  (  reset_array[1]        ),
    .en_i         (  enable_array[1]       ),
    .counter_o    (  ms100_counter_o[3:0]  )
  ); 
  
  counter_4 s1(
    .rst_i        (  rstn_s_i           ),
    .count_rst_i  (  reset_array[2]     ),
    .en_i         (  enable_array[2]    ),
    .counter_o    (  s1_counter_o[3:0]  )
  ); 
  
  counter_4 s10(
    .rst_i        (  rstn_s_i            ),
    .count_rst_i  (  reset_array[3]      ),
    .en_i         (  enable_array[3]     ),
    .counter_o    (  s10_counter_o[3:0]  )
  ); 
  
endmodule
