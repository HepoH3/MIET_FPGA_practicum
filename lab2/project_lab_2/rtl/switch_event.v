`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.05.2020 18:25:31
// Design Name: 
// Module Name: switch_event
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


module switch_event(
    input       [9:0]   sw_i,                  //Ввод данных c переключателей в обработчик УС
    input               clk_50m,            //Ввод тактового импульса
    input               btn_sync_i,        //Ввод кнопки (эта кнопка одновременно даёт сигнал на заполнение регистра и на проверку на УС)
    
    output reg          synced_event_o = 0 //Вывод УС
      );
    
    reg         sw_event = 0;            //регистр уникального события
    reg  [2:0]  event_sync_reg = 3'b000;     //синхронизирующий регистр 1         
    parameter   EV_CONST = 4'd2;
    // Обработчик уникального события (индивидуальное задание)
    // Проверка наличия уникального события в момент изменения содержимого регистра KEY[0]
    always @(sw_i[9:0])
        if (sw_i[0]+sw_i[1]+sw_i[2]+sw_i[3]+sw_i[4]+sw_i[5]+sw_i[6]+sw_i[7]+sw_i[8]+sw_i[9]>EV_CONST) 
            sw_event <= 1'b1; 
        else 
            sw_event <= 1'b0;
    //Состояние sw_event показывает, произошло ли уникальное событие при последнем изменении положения переключателей
    
    
    //Состояние  sw_event синхронизируется в 2 этапа
    //Этап 1 - синхронизация Reg_sw_event с clk_50m
    //Этот этап требуется чтобы связать постоянный (при отсутствии переключения sw_i) сигнал с тактовым импульсом
    //(Он всё ещё постоянный, но 0->1 происходит одновременно с тактовым)
    always @(posedge clk_50m) begin
        event_sync_reg[2]   <= sw_event;
        event_sync_reg[1:0] <= event_sync_reg[2:1];
    end
    
    //Этап 2 - синхронизация Reg_sw_event с btn_sync_i
    //Этот этап требуется чтобы связать синхронизированный с тактовым сигнал Reg_sw_event с импульсом от нажатия кнопки
    //(Превращая постоянный сигнал от обработчика УС в отдельный единичный импульс по нажатию кнопки)
    always @(posedge btn_sync_i) begin
        synced_event_o <= event_sync_reg[1] & event_sync_reg[0];
        #20;
        synced_event_o <= 1'b0; 
    end
    //После всех синхронизаций из модуля выходит synced_event
endmodule