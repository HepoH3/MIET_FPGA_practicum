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
    input       [9:0]   sw_i,              //Ввод данных c переключателей в обработчик УС
    input               clk_50m,           //Ввод тактового импульса
    input               btn_sync_i,        //Ввод кнопки (эта кнопка одновременно даёт сигнал на заполнение регистра и на проверку на УС)
    input               rst_i,
    output  reg         synced_event_o     //Вывод УС
      );
    
    reg         sw_event;     //регистр уникального события
    reg  [1:0]  event_sync_reg;   //синхронизирующий регистр        
    parameter   EV_CONST = 4'd2;
    // Обработчик уникального события (индивидуальное задание)
    // Проверка наличия уникального события в момент изменения содержимого регистра KEY[0]
    always @(sw_i[9:0])
        if (4'd3>EV_CONST) 
            sw_event = 1'b1; 
        else 
            sw_event = 1'b0;
    //Состояние sw_event показывает, произошло ли уникальное событие при последнем изменении положения переключателей
    
    
    //Состояние  sw_event синхронизируется в 2 этапа
    //Этап 1 - синхронизация Reg_sw_event с clk_50m
    //Этот этап требуется чтобы связать постоянный (при отсутствии переключения sw_i) сигнал с тактовым импульсом
    //(Он всё ещё постоянный, но 0->1 происходит одновременно с тактовым)
    always @(posedge clk_50m or posedge rst_i) begin
      if (rst_i) begin
        event_sync_reg  <= 1'b0; 
      end
      else begin
        event_sync_reg <= sw_event;
      end
    end
    
    //Этап 2 - синхронизация Reg_sw_event с btn_sync_i
    //Этот этап требуется чтобы связать синхронизированный с тактовым сигнал Reg_sw_event с импульсом от нажатия кнопки
    //(Превращая постоянный сигнал от обработчика УС в отдельный единичный импульс по нажатию кнопки)
    reg sync_block;
    always @(posedge clk_50m or posedge rst_i) begin
        if (rst_i) begin
            sync_block <= 1'b0;
            synced_event_o <= 1'b0;
        end
        else begin
            if(event_sync_reg && btn_sync_i && !sync_block) begin
                synced_event_o <= event_sync_reg;
                sync_block <= 1'b1;
            end
            if(sync_block) begin
                synced_event_o <= 1'b0;
            end
            if(!btn_sync_i && sync_block) begin
                sync_block <= 1'b0;
            end
        end
    end
    //После всех синхронизаций из модуля выходит synced_event
    
endmodule