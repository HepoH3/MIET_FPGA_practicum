`timescale 1ns / 1ps
module Register_10(
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
