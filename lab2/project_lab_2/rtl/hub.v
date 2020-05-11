`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2020 23:26:34
// Design Name: 
// Module Name: KEY_Switching
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

//Модуль hub 
//Всё назначение данного модуля - соединять несколько подмодулей. при желании код можно переделать, и все сигналы соединять в mainframe
module hub(               //модуль hub 
input   [10:0]  sw_i,              //Ввод переключателей
input   [4:0]   btn_i,             //Ввод кнопок 
input           clk_50m,           //Ввод тактового сигнала частотой 50 МГц
output  [9:0]   register_o,        //Вывод регистра
output  [7:0]   counter_1_o,        //Вывод счётчика
output  [7:0]   counter_2_o        //Вывод счётчика
    );
  
  wire          synced_event;    //Ввод сигнала о произошедшем УС
  wire  [4:0]   btn_push; 
  
  //Выбор используемого счётчика
  reg   [1:0]   counter_sw_reg;
  wire  [1:0]   counter_sw; 
  assign counter_sw[0] = counter_sw_reg[0] && synced_event;
  assign counter_sw[1] = counter_sw_reg[1] && synced_event;
  
  //Адаптер для двух кнопок проверки УС для switch event
  wire btn_sync;
  assign btn_sync = btn_push[0] | btn_push[1];
    
 //Ввод/вывод сигналов от модуля KEY_Pressing (префикс - "KP")
  keys_debounce u1(
    .deb_on_i    (  sw_i[10]       ),
    .btn_i       (  btn_i[4:0]     ),
    .clk_50m     (  clk_50m        ),
    .btn_o       (  btn_push[3:0]  ),
    .btn_rst_o   (  btn_push[4]    )
  ); // Ввод кнопок
  
  //Ввод/вывод сигналов от модуля Register_10 (регистр на 10 позиций)
  register_10 u2(
    .d_i         (  sw_i[9:0]        ),                 
    .clk_i       (  clk_50m          ),              
    .rst_i       (  btn_push[4]      ),           
    .en_i        (  btn_push[0]      ),            
    .register_o  (  register_o[9:0]  )     
  );
  
  // Схема переключения между счётчиками в зависимости от нажатой кнопки
  always @(posedge clk_50m) begin
    if (btn_push[4] || synced_event) begin
      counter_sw_reg[1:0] <= 2'b00;
    end
    if (btn_push[0] || btn_push[1]) begin
      counter_sw_reg[0] <= btn_push[0];
      counter_sw_reg[1] <= btn_push[1];
    end
  end
  
  //Ввод/вывод сигналов от модуля Counter_8 (первый 8-битный счётчик)
  counter_8 u3(
    .clk_i       (  clk_50m           ),
    .rst_i       (  btn_push[4]       ),
    .en_i        (  counter_sw[0]     ),
    .counter_o   (  counter_1_o[7:0]  )
  ); 
  
  //Ввод/вывод сигналов от модуля Counter_8 (второй 8-битный счётчик)
  counter_8 u4(
    .clk_i       (  clk_50m           ),
    .rst_i       (  btn_push[4]       ),
    .en_i        (  counter_sw[1]     ),
    .counter_o   (  counter_2_o[7:0]  )
  ); 
  
  //Ввод/вывод сигналов от модуля REG_Event (префикс - "REG")(проверка наличия УС)
  switch_event u5(
    .sw_i            (  sw_i[9:0]     ),
    .clk_50m         (  clk_50m       ),
    .synced_event_o  (  synced_event  ),
    .rst_i           (  btn_push[4]   ),
    .btn_sync_i      (  btn_sync      )
  );
  
  
endmodule