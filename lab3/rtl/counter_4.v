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

//Модуль counter_4 (4-битный счётчик)
module counter_4(
    input               en_i,         //Сигнал на включение счётчика 
    input               rst_i,        //Сброс счётчика в 0
    input               count_rst_i,  //Сброс счётчика в 0
    output  reg  [3:0]  counter_o     //Вывод значения счётчика (4 бит)
    );

    parameter BIT_DEPTH_OF_CLOCK = 4'd10;
       
    always @( posedge rst_i or posedge count_rst_i or posedge en_i) begin
      if ( rst_i || count_rst_i ) 
        counter_o <= 4'd0;
      else if ( en_i && counter_o < BIT_DEPTH_OF_CLOCK ) 
        counter_o <= counter_o + 1;
    end
    
endmodule
