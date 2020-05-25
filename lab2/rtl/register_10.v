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

//������ register_10 (������� �� 10 �������)
module register_10(
    input        [9:0]  d_i,             //�������� 10 ��������
    input               clk_i,           //�������� �������
    input               rst_i,           //����� �������� � 0
    input               en_i,            //������ �� ���������� �������� ��������
    output  reg  [9:0]  register_o       //����� ��������, ������������ ���������
    );
  
  //������� ���� �� 10 D-���������  
  always @( posedge clk_i or posedge rst_i ) begin
    if ( rst_i )
      register_o <= 0;
    else if ( en_i ) 
      register_o <= d_i;
  end 
  
endmodule
