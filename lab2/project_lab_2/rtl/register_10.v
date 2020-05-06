`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2020 00:46:47
// Design Name: 
// Module Name: register_10
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

//Модуль register_10 (регистр на 10 позиций)
module register_10(
    input      [9:0] d_i,             //Вводимые 10 сигналов
    input            clk_i,           //Тактовый импульс
    input            rst_i,           //Сброс регистра в 0
    input            en_i,            //Сигнал на считывание вводимых сигналов
    output reg [9:0] register_o       //Вывод значений, запоминаемых регистром
    );
  
  //Обычный блок из 10 D-триггеров  
  always @(posedge clk_i or posedge rst_i) begin
      if (rst_i) register_o <= 0;
      else if (en_i) register_o <= d_i;
  end 
  
endmodule
