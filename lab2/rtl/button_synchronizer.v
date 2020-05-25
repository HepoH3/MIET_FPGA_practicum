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
    output  reg  btn_clk_o
    );
    
    reg  sync;
    reg  sync_block;
    
    always @( posedge clk_i or posedge rst_i ) begin
      if ( rst_i ) begin
        sync        <=  1'b0;
        sync_block  <=  1'b0;
        btn_clk_o   <=  1'b0;
      end
      else begin
        sync <= !btn_i;
        if( sync && !sync_block ) begin
          btn_clk_o   <= sync;
          sync_block  <= 1'b1;
        end
        else if( sync_block ) begin
          btn_clk_o   <= 1'b0;
        end
        else if( !sync && sync_block ) begin
          sync_block  <= 1'b0;
        end
      end
    end
    
endmodule
