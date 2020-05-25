`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.05.2020 13:06:12
// Design Name: 
// Module Name: ms10_timer
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


module ms10_timer(
  input           clk_i,      //Тактовый импульс
  input           en_i,       //Сигнал на включение счётчика 
  input           rst_i,      //Сброс счётчика в 0
  input   [19:0]  TL,
  output          timer_full_o     //Вывод сигнала таймера
  );
   
   reg   [19:0]  timer;
   
   assign timer_full_o = ( timer == TL );
   
   always @( posedge clk_i or posedge rst_i ) begin
     if ( rst_i || timer_full_o ) 
       timer <= 20'd0;
     else if ( en_i && ( timer < TL ) ) 
       timer <= timer + 1;
   end  
    
endmodule
