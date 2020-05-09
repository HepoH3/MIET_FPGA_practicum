`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.05.2020 23:02:29
// Design Name: 
// Module Name: button_synchronizer
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


module button_synchronizer(
    input        clk_i,
    input        btn_i,
    input        rst_i,
    output       btn_clk_o
    );
    
    reg  [1:0]  sync;
    assign  btn_clk_o = sync[1];
    
    always @( posedge clk_i or posedge rst_i ) begin
      if ( rst_i ) begin
        sync <= 2'b00;
      end
      else begin
        sync[0] <= !btn_i;  
        sync[1] <= sync[0];
      end
    end
    
endmodule
