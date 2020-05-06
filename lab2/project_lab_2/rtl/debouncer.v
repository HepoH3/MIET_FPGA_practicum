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
    input clk_i,
    input btn_i,
    output reg state_o=0,
    output ondn_o,
    output onup_o
    );
    
    // sync with clock and combat metastability
    reg sync_0 = 0, sync_1 = 0;
    always @(posedge clk_i) sync_0 <= btn_i;
    always @(posedge clk_i) sync_1 <= sync_0;

    // 2.6 ms counter at 50 MHz
    reg [1:0] counter = 2'd0;
    wire idle = (state_o == sync_1);
    wire max = &counter;

    always @(posedge clk_i)
    begin
        if (idle)
            counter <= 0;
        else
        begin
            counter <= counter + 1;
            if (max)
                state_o <= ~state_o;
        end
    end

    assign ondn_o = ~idle & max & ~state_o;
    assign onup_o = ~idle & max & state_o;
    
endmodule