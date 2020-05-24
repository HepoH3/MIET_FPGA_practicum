`timescale 1ns / 1ps
module Counter_8(
    input            clk_i,     
    input            en_i,       
    input            rst_i,       
    output reg [7:0] counter_o   
    );
    
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) counter_o <= 0;
        else if (en_i) counter_o <= counter_o + 1;
    end
    
endmodule
