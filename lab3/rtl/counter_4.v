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

//������ counter_4 (4-������ �������)
module counter_4(
    input               en_i,         //������ �� ��������� �������� 
    input               rst_i,        //����� �������� � 0
    input               count_rst_i,  //����� �������� � 0
    //�����, �� ������� ������� ����������� (�.�. ��� 10 �� ��������� �� 9 � ��������� ������ ����� �� ������� �������)
    input        [3:0]  BDOC,
    output  reg  [3:0]  counter_o     //����� �������� �������� (4 ���)
    );
       
    always @( posedge rst_i or posedge count_rst_i or posedge en_i) begin
      if ( rst_i || count_rst_i ) 
        counter_o <= 4'd0;
      else if ( en_i && counter_o < BDOC ) 
        counter_o <= counter_o + 1;
    end
    
endmodule
