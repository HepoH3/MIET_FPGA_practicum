`timescale 1ns / 1ps
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


module test_clk_tb(
    );
  reg         clk_50m;  
  reg  [9:0]  sw;
  reg  [4:0]  btn;
  wire [9:0]  led;
  wire [6:0]  hex0;
  wire [6:0]  hex1;
  wire [7:0]  hex_on;
    
  mainframe DUT (
  .clk_50m (clk_50m),
  .sw     (sw),
  .btn    (btn),
  .led    (led),
  .hex0   (hex0),
  .hex1   (hex1),
  .hex_on (hex_on)
  );

 initial begin
    sw[9:0] = 10'b0000000000;
    btn[4:0] = 4'b1111;
    #50;
    
    //Стартовый сброс на key_3
    btn[3]=1'b0;
    #100;
    btn[3]=1'b1;
    
    #200;
    
    //Выставляем переключатели (есть УС)
    sw[9:0] = 10'b0000000111;
    
    #200
    
    //Первая запись в регистр на key_0
    btn[0]=1'b0;
    #100;
    btn[0]=1'b1;
    
    #200;
    
    //Вторая запись в регистр на key_0 (без изменения положения свичей
    btn[0]=1'b0;
    #100;
    btn[0]=1'b1;
    
    #200;
    
    sw[9:0] = 10'b0000000011;
    
    #200;
    
    btn[0]=1'b0;
    #100;
    btn[0]=1'b1;
    
    #200;
    
    btn[3]=1'b0;
    #100;
    btn[3]=1'b1;   
 end 
 
 //Симуляция CLK сигнала
 always begin //Создание 1-0 CLK сигнала
    clk_50m = 1'b1;
    #10;
    clk_50m = 1'b0;
    #10;
 end
    
endmodule
