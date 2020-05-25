`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2020 01:44:33
// Design Name: 
// Module Name: counter_8
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

//Модуль counter_8 (8-битный счётчик)
module counter_8(
    input               clk_i,       //Тактовый импульс
    input               en_i,        //Сигнал на включение счётчика (произошло УС)
    input               rst_i,       //Сброс счётчика в 0
    output  reg  [7:0]  counter_o    //Вывод значения счётчика (8 бит)
    );
    
    always @( posedge clk_i or posedge rst_i ) begin
      if ( rst_i ) 
        counter_o <= 8'd55;
      else if ( en_i ) 
        counter_o <= counter_o + 1;
    end
    
endmodule
