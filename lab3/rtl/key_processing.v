`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.05.2020 14:58:58
// Design Name: 
// Module Name: key_processing
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


module key_processing(
  input        clk100_i,
  input        rstn_i,
  input        start_stop_i,
  input        set_i,
  input        change_i,
  output  reg  start_stop_s_reg_o,
  output       set_s_o,
  output       change_s_o,
  output       rstn_s_o
  );
  
  assign  rstn_s_o  =  ~rstn_i;  
    
  button_synchronizer start_stop(
    .btn_i      (  start_stop_i    ),
    .rst_i      (  rstn_s_o        ),
    .btn_clk_o  (  start_stop_s_o  ),
    .clk_i      (  clk100_i        )  
  );
  
  always @( posedge clk100_i or posedge rstn_s_o ) begin
    if( rstn_s_o ) begin
      start_stop_s_reg_o <= 0;
    end
    else if( ~start_stop_s_reg_o & start_stop_s_o ) begin
      start_stop_s_reg_o <= 1;
    end
    else if( start_stop_s_reg_o & start_stop_s_o ) begin
      start_stop_s_reg_o <= 0;
    end    
  end
    
    
  button_synchronizer set(
    .btn_i      (  set_i     ),
    .rst_i      (  rstn_s_o  ),
    .btn_clk_o  (  set_s_o   ),
    .clk_i      (  clk100_i  )  
  );
    
    
  button_synchronizer change(
    .btn_i      (  change_i    ),
    .rst_i      (  rstn_s_o    ),
    .btn_clk_o  (  change_s_o  ),
    .clk_i      (  clk100_i    )  
  );
endmodule
