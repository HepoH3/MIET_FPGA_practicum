`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2020 21:13:05
// Design Name: 
// Module Name: debouncer
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


module debouncer(
    input   clk_i,
    input   btn_i,
    input   rst_i,
    output  btn_o
    );
    
    // sync with clock and combat metastability
    reg         state_o = 0;
    reg  [1:0]  sync;
    // 2.6 ms counter at 50 MHz   
    always @( posedge clk_i or posedge rst_i ) begin
      if ( rst_i ) begin
        sync <= 2'b00;
      end
      else begin
        sync[0] <= !btn_i;
        sync[1] <= sync[0];
      end
    end
    
    reg [1:0] counter;
    wire      idle;
    assign idle = ( state_o == sync[1] );
    wire      max;
    assign max = &counter;
    assign btn_o = ~idle & max & ~state_o; 
    
    always @( posedge clk_i ) begin
      if ( idle )
        counter <= 0;
      else begin
        counter <= counter + 1;
        if ( max )
          state_o <= ~state_o;
        end
    end
         
endmodule