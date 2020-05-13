`timescale 1ns / 1ps

//Модуль KEY_Pressing (префикс - "KP")
//Назначение этого модуля - объединять одинаковые обработчики отдельных кнопок в один модуль
module KEY_Pressing(
  input   [1:0] KP_btn_i,         //Ввод кнопок
  input         KP_clk50_i,     //Ввод тактового импульса
  output  [1:0] KP_btn_ondn     //Вывод сигнала о том, что кнопка была НАЖАТА
    );
    
  wire [1:0]KP_btn_onup;        //Зарезервированный ввод ОТЖАТИЯ кнопок
  wire [1:0]KP_btn_state;       //Зарезервированный ввод СОСТОЯНИЯ кнопок
        
  KEY_Debounce u1(
    .i_btn   (KP_btn_i[0]),
    .o_onup  (KP_btn_onup[0]),
    .o_ondn  (KP_btn_ondn[0]),
    .o_state (KP_btn_state[0]),
    .clk     (KP_clk50_i)
  ); 
    KEY_Debounce u2(
    .i_btn   (KP_btn_i[1]),
    .o_onup  (KP_btn_onup[1]),
    .o_ondn  (KP_btn_ondn[1]),
    .o_state (KP_btn_state[1]),
    .clk     (KP_clk50_i)
  ); 
endmodule
