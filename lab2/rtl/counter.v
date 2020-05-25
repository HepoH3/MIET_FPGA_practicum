`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.05.2020 15:03:47
// Design Name: 
// Module Name: counter
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

//Абсолютно бесполезный модуль counter, не делающий ничего, кроме адаптации чужого тестбенча.
module counter(
input             clk_100_i,                //Ввод тактового сигнала частотой 50 МГц (100МГц???)
  input   [10:0]  sw_i,                     //Ввод переключателей
  //Ввод кнопок (btn[0]=key0=key_i[0], btn[4]=key1=key_i[1], btn[1]=key2, btn[2] и btn[3] - резервные)
  input   [1:0]   key_i,                     
  output  [9:0]   ledr_o,                   //Вывод на светодиоды 
  output  [6:0]   hex0_o,                   //Вывод на первый семисигментный индикатор
  output  [6:0]   hex1_o                    //Вывод на второй семисигментный индикатор          
    );

wire  [7:0]  hex_on_o; //Выбор используемого семисегментного индикатора из 8 (0 - активный)
wire  [6:0]  hex2_o;
wire  [6:0]  hex3_o;
wire  [4:0]  btn_i;
assign btn_i[0] = key_i[0];
assign btn_i[4] = key_i[1];

  mainframe u1 (
    .sw_i      (  sw_i[10:0]     ),                   
    .btn_i     (  btn_i[4:0]     ),                    
    .clk_50m   (  clk_100_i      ),                
    .ledr_o    (  ledr_o[9:0]    ),                  
    .hex0_o    (  hex0_o[6:0]    ),                  
    .hex1_o    (  hex1_o[6:0]    ),                   
    .hex2_o    (  hex2_o[6:0]    ),                   
    .hex3_o    (  hex3_o[6:0]    ),                   
    .hex_on_o  (  hex_on_o[7:0]  )                     
  );
  
endmodule