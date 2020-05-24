`timescale 1ns / 1ps
module KEY_Debounce(
    input clk,
    input i_btn,
    output reg o_state=0,
    output o_ondn,
    output o_onup
    );
    
   
    reg sync_0 = 0, sync_1 = 0;
    always @(posedge clk) sync_0 <= i_btn;
    always @(posedge clk) sync_1 <= sync_0;

   
    reg [1:0] counter = 2'd0;
    wire idle = (o_state == sync_1);
    wire max = &counter;

    always @(posedge clk)
    begin
        if (idle)
            counter <= 0;
        else
        begin
            counter <= counter + 1;
            if (max)
                o_state <= ~o_state;
        end
    end

    assign o_ondn = ~idle & max & ~o_state;
    assign o_onup = ~idle & max & o_state;
    
endmodule
