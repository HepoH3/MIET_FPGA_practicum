`timescale 1ns / 1ps
module Counter_8(
    input            clk_i,       //Тактовый импульс
    input            en_i,        //Сигнал на включение счётчика (произошло УС)
    input            rst_i,       //Сброс счётчика в 0
    output reg [7:0] counter_o    //Вывод значения счётчика (8 бит)
    );
    
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) counter_o <= 0;
        else if (en_i) counter_o <= counter_o + 1;
    end
    
endmodule