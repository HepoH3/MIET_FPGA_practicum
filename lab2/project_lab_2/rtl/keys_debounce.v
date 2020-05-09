`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.02.2020 14:43:01
// Design Name: 
// Module Name: keys_debounce
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

//Модуль keys_debounce (префикс - "KP")
//Назначение этого модуля - объединять одинаковые обработчики отдельных кнопок в один модуль
module keys_debounce(
  input          deb_on_i,      //Ввод переключения режима работы кнопок
  input   [4:0]  btn_i,         //Ввод кнопок
  input          clk_50m,       //Ввод тактового импульса
  output  [3:0]  btn_o,          
  output         btn_rst_o
    );
    
  wire    [3:0]  btn_clk;     // Cинхронизированныt с clk_50m сигналы кнопок
  wire    [3:0]  btn_deb;     // Синхронизированные и не дребезжащие сигналы кнопок
  assign  btn_o[0] = ( btn_clk[0] & ~deb_on_i ) || ( btn_deb[0] & deb_on_i );
  assign  btn_o[1] = ( btn_clk[1] & ~deb_on_i ) || ( btn_deb[1] & deb_on_i );
  assign  btn_o[2] = ( btn_clk[2] & ~deb_on_i ) || ( btn_deb[2] & deb_on_i );
  assign  btn_o[3] = ( btn_clk[3] & ~deb_on_i ) || ( btn_deb[3] & deb_on_i );
  
// Модули синхронизации кнопок [4:0] btn_i (без функции debounce) 
    button_synchronizer u1(
      .btn_i      (  btn_i[0]      ),
      .rst_i      (  btn_rst_o     ),
      .btn_clk_o  (  btn_clk[0]    ),
      .clk_i      (  clk_50m       )  
    );// Кнопка btn_i[0] или KEY[0]
    
    button_synchronizer u2(
      .btn_i      (  btn_i[1]      ),
      .rst_i      (  btn_rst_o     ),
      .btn_clk_o  (  btn_clk[1]    ),
      .clk_i      (  clk_50m       )  
    );// Кнопка btn_i[1]
      
    button_synchronizer u3(
      .btn_i      (  btn_i[2]      ),
      .rst_i      (  btn_rst_o     ),
      .btn_clk_o  (  btn_clk[2]    ),
      .clk_i      (  clk_50m       )  
    );// Кнопка btn_i[2]   
      
    button_synchronizer u4(
      .btn_i      (  btn_i[3]      ),
      .rst_i      (  btn_rst_o     ),
      .btn_clk_o  (  btn_clk[3]    ),
      .clk_i      (  clk_50m       )  
    );// Кнопка btn_i[3]   
        
    // Инвертер кнопки btn[4]/key1 (aka асинхронный сброс)
    assign  btn_rst_o  =  ~btn_i[4];  
           
  debouncer u5(
    .btn_i  (  btn_i[0]   ),
    .rst_i  ( btn_rst_o   ),
    .btn_o  ( btn_deb[0]  ),
    .clk_i  (  clk_50m    )
  );// Кнопка btn_i[0] или KEY[0]
  
    debouncer u6(
    .btn_i  (  btn_i[1]   ),
    .rst_i  ( btn_rst_o   ),
    .btn_o  ( btn_deb[1]  ),
    .clk_i  (  clk_50m    )
  );// Кнопка btn_i[1]
  
    debouncer u7(
    .btn_i  (  btn_i[2]   ),
    .rst_i  ( btn_rst_o   ),
    .btn_o  ( btn_deb[2]  ),
    .clk_i  (  clk_50m    )
  );// Кнопка btn_i[2]  
  
    debouncer u8(
    .btn_i  (  btn_i[3]   ),
    .rst_i  ( btn_rst_o   ),
    .btn_o  ( btn_deb[3]  ),
    .clk_i  (  clk_50m    )
  );// Кнопка btn_i[3]  
  
endmodule