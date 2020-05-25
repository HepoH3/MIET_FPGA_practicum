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

//������ keys_debounce (������� - "KP")
//���������� ����� ������ - ���������� ���������� ����������� ��������� ������ � ���� ������
module keys_debounce(
  input          deb_on_i,      //���� ������������ ������ ������ ������
  input   [4:0]  btn_i,         //���� ������
  input          clk_50m,       //���� ��������� ��������
  output  [3:0]  btn_o,          
  output         btn_rst_o
    );
    
  wire    [3:0]  btn_clk;     // C����������������t � clk_50m ������� ������
  wire    [3:0]  btn_deb;     // ������������������ � �� ����������� ������� ������
  assign  btn_o[0] = ( btn_clk[0] & ~deb_on_i ) || ( btn_deb[0] & deb_on_i );
  assign  btn_o[1] = ( btn_clk[1] & ~deb_on_i ) || ( btn_deb[1] & deb_on_i );
  assign  btn_o[2] = ( btn_clk[2] & ~deb_on_i ) || ( btn_deb[2] & deb_on_i );
  assign  btn_o[3] = ( btn_clk[3] & ~deb_on_i ) || ( btn_deb[3] & deb_on_i );
  
// ������ ������������� ������ [4:0] btn_i (��� ������� debounce) 
  button_synchronizer u1(
    .btn_i      (  btn_i[0]      ),
    .rst_i      (  btn_rst_o     ),
    .btn_clk_o  (  btn_clk[0]    ),
    .clk_i      (  clk_50m       )  
  );// ������ btn_i[0] ��� KEY[0]
    
  button_synchronizer u2(
    .btn_i      (  btn_i[1]      ),
    .rst_i      (  btn_rst_o     ),
    .btn_clk_o  (  btn_clk[1]    ),
    .clk_i      (  clk_50m       )  
  );// ������ btn_i[1]
      
  button_synchronizer u3(
    .btn_i      (  btn_i[2]      ),
    .rst_i      (  btn_rst_o     ),
    .btn_clk_o  (  btn_clk[2]    ),
    .clk_i      (  clk_50m       )  
  );// ������ btn_i[2]   
      
  button_synchronizer u4(
    .btn_i      (  btn_i[3]      ),
    .rst_i      (  btn_rst_o     ),
    .btn_clk_o  (  btn_clk[3]    ),
    .clk_i      (  clk_50m       )  
  );// ������ btn_i[3]   
        
  // �������� ������ btn[4]/key1 (aka ����������� �����)
  assign  btn_rst_o  =  ~btn_i[4];  
           
  debouncer u5(
    .btn_i  (  btn_i[0]   ),
    .rst_i  ( btn_rst_o   ),
    .btn_o  ( btn_deb[0]  ),
    .clk_i  (  clk_50m    )
  );// ������ btn_i[0] ��� KEY[0]
  
    debouncer u6(
    .btn_i  (  btn_i[1]   ),
    .rst_i  ( btn_rst_o   ),
    .btn_o  ( btn_deb[1]  ),
    .clk_i  (  clk_50m    )
  );// ������ btn_i[1]
  
    debouncer u7(
    .btn_i  (  btn_i[2]   ),
    .rst_i  ( btn_rst_o   ),
    .btn_o  ( btn_deb[2]  ),
    .clk_i  (  clk_50m    )
  );// ������ btn_i[2]  
  
    debouncer u8(
    .btn_i  (  btn_i[3]   ),
    .rst_i  ( btn_rst_o   ),
    .btn_o  ( btn_deb[3]  ),
    .clk_i  (  clk_50m    )
  );// ������ btn_i[3]  
  
endmodule