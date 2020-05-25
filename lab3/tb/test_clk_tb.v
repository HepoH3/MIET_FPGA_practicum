`timescale 1ns / 100ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.02.2020 13:05:30
// Design Name: 
// Module Name: test_clk_tb
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


module test_clk_tb;

  realtime delay = 5;
  
  reg           clk100 = 0;  
  reg           rstn;
  reg           start_stop;
  reg           set;
  reg           change;  
  wire  [6:0]   hex0;
  wire  [6:0]   hex1;
  wire  [6:0]   hex2;
  wire  [6:0]   hex3;
  
   //Симуляция CLK сигнала
  always begin //Создание 1-0 CLK сигнала
    #delay clk100 = ~clk100;
  end
  
 stopwatch DUT (
  .clk100_i      (  clk100      ),
  .rstn_i        (  rstn        ),
  .start_stop_i  (  start_stop  ),
  .set_i         (  set         ),
  .change_i      (  change      ),
  .hex0_o        (  hex0        ),
  .hex1_o        (  hex1        ),
  .hex2_o        (  hex2        ),
  .hex3_o        (  hex3        )
  );

 initial begin
   #5;
   rstn = 1'b1;
   start_stop = 1'b1;
   set = 1'b1;
   change = 1'b1;
   
   #20;
   
   rstn = 1'b0;
   #20;
   rstn = 1'b1;
   
   #20; 
   
   set = 1'b0;
   #20;
   set = 1'b1;
   
   #20;
    
   start_stop = 1'b0;
   #20;
   start_stop = 1'b1;
   
   #20; 
   
   set = 1'b0;
   #20;
   set = 1'b1;
   
   #20; 
   
   change = 1'b0;
   #20;
   change = 1'b1;
   
   #20;
   
   set = 1'b0;
   #20;
   set = 1'b1;
   
   #20; 
   
   change = 1'b0;
   #20;
   change = 1'b1;
   
   #20;
   
   set = 1'b0;
   #20;
   set = 1'b1;
   
   #20; 
   
   set = 1'b0;
   #20;
   set = 1'b1;
   
   #1000;
   
   start_stop = 1'b0;
   #20;
   start_stop = 1'b1;
   
   #20000000; 
   
   start_stop = 1'b0;
   #20;
   start_stop = 1'b1;
   
   
 end 
    
endmodule
