`timescale 1ns / 1ps

module stopwatch #(
  parameter PULSE_MAX  = 17'd999999,
            HUNS_MAX   = 4'd9,
            TENTHS_MAX = 4'd9,
            SEC_MAX    = 4'd9,
            TENS_MAX   = 4'd9
            )
(
  input clk100_i,
  input rstn_i,
  input start_stop_i,
  input set_i,
  input change_i,
  output [6:0] hex0_o,
  output [6:0] hex1_o,
  output [6:0] hex2_o,
  output [6:0] hex3_o  
  ); 
 
localparam IDLE        = 3'd0;
localparam CHANGING_H  = 3'd1;
localparam CHANGING_TS = 3'd2;
localparam CHANGING_S  = 3'd3;
localparam CHANGING_T  = 3'd4;
 
 
 
 // Часть I - синхронизация обработки
 // нажатия кнопки «СтартСтоп»/
reg [2:0] button_syncroniser;
wire button_was_pressed;

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) begin
    button_syncroniser[0] <= 1'b0;
    button_syncroniser[1] <= 1'b0;
    button_syncroniser[2] <= 1'b0;
  end
  else begin
    button_syncroniser[0] <= start_stop_i;
    button_syncroniser[1] <= button_syncroniser[0];
    button_syncroniser[2] <= button_syncroniser[1];
  end
end

assign button_was_pressed = ~ button_syncroniser[2] && button_syncroniser[1];



reg [2:0] set_sync;
wire set_was_pressed;

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) begin
    set_sync[0] <= 1'b0;
    set_sync[1] <= 1'b0;
    set_sync[2] <= 1'b0;
  end
  else begin
    set_sync[0] <= set_i;
    set_sync[1] <= set_sync[0];
    set_sync[2] <= set_sync[1];
  end
end

assign set_was_pressed = ~ set_sync[2] && set_sync[1];


reg [2:0] change_sync;
wire change_was_pressed;

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) begin
    change_sync[0] <= 1'b0;
    change_sync[1] <= 1'b0;
    change_sync[2] <= 1'b0;
  end
  else begin
    change_sync[0] <= change_i;
    change_sync[1] <= change_sync[0];
    change_sync[2] <= change_sync[1];
  end
end

assign change_was_pressed = ~ change_sync[2] && change_sync[1];


 // Часть II - выработка признака «device_running »
 // Самостоятельная работа студента!
reg device_running;

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    device_running <= 1'b0;
  if ( passed_all )
      device_running <= 1'b1;
  else if ( fsm_state == IDLE )
    if ( button_was_pressed )
      device_running <= ~device_running;
end


 // Часть III - счётчик импульсов
 // и признак истечения 0,01 сек
reg [16:0] pulse_counter;

wire hundredth_of_second_passed;
assign hundredth_of_second_passed = ( pulse_counter == PULSE_MAX );

always @(posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) 
    pulse_counter <= 4'd0;
  else if ( device_running || hundredth_of_second_passed ) 
    if ( hundredth_of_second_passed )
      pulse_counter <= 4'd0;
    else 
      pulse_counter <= pulse_counter + 1;
end


 // Часть IV - основные счётчики
reg [3:0] hundredths_counter;
wire tenth_of_second_passed;
assign tenth_of_second_passed = ( ( hundredths_counter == HUNS_MAX ) && hundredth_of_second_passed );

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i )
    hundredths_counter <= 4'd0;
  else if ( hundredth_of_second_passed ) begin
    if ( tenth_of_second_passed )
      hundredths_counter <= 4'd0;
    else 
      hundredths_counter <= hundredths_counter + 1;
  end
  else if ( fsm_state == CHANGING_H && increment )
    hundredths_counter <= hundredths_counter + 1;
end


reg [3:0] tenths_counter;
wire second_passed = (( tenths_counter == TENTHS_MAX ) && tenth_of_second_passed );

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) 
    tenths_counter <= 4'd0;
  else if ( tenth_of_second_passed ) begin
    if ( second_passed ) 
      tenths_counter <= 4'd0;
    else 
      tenths_counter <= tenths_counter + 1;
  end
  else if ( fsm_state == CHANGING_TS && increment )
    tenths_counter <= tenths_counter + 1;
end

reg [3:0] seconds_counter;
wire ten_seconds_passed = ( ( seconds_counter == SEC_MAX ) & second_passed );

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i )
    seconds_counter <= 4'd0;
  else if ( second_passed ) begin
    if ( ten_seconds_passed ) 
      seconds_counter <= 4'd0;
    else 
      seconds_counter <= seconds_counter + 1;
  end
  else if ( fsm_state == CHANGING_S && increment )
    seconds_counter <= seconds_counter + 1;
end

reg [3:0] ten_seconds_counter;

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) 
    ten_seconds_counter <= 4'd0;
  else if ( ten_seconds_passed ) begin
    if ( ten_seconds_counter == TENS_MAX )
      ten_seconds_counter <= 4'd0;
    else 
      ten_seconds_counter <= ten_seconds_counter + 1;
  end
  else if ( fsm_state == CHANGING_T && increment )
    ten_seconds_counter <= ten_seconds_counter + 1;
end




// Часть V - дешифраторы для отображения
// содержимого основных регистров
// на семисегментных индикаторах

dec_to_hex to_hex3(
  .dec_i ( ten_seconds_counter ),
  .hex_o ( hex3_o              )
  );


dec_to_hex to_hex2(
  .dec_i ( seconds_counter ),
  .hex_o ( hex2_o          )
  );


dec_to_hex to_hex1(
  .dec_i ( tenths_counter ),
  .hex_o ( hex1_o         )
  );


dec_to_hex to_hex0(
  .dec_i ( hundredths_counter ),
  .hex_o ( hex0_o             )
  );


wire [2:0] fsm_state;
wire       increment;
wire       passed_all;


stopw_finstate fsm(
  .clk_i        ( clk100_i           ),
  .rstn_i       ( rstn_i             ),
  .dev_run_i    ( device_running     ),
  .set_i        ( set_was_pressed    ),
  .change_i     ( change_was_pressed ),
  .state_value_o( fsm_state          ),
  .inc_this_o   ( increment          ),
  .passed_all   ( passed_all         )
);

//always @( * ) begin
//  if ( fsm_state != IDLE )
//    if( increment )
//      case ( fsm_state )
//        CHANGING_T  : ten_seconds_counter <= ten_seconds_counter + 1;
//        CHANGING_S  : seconds_counter     <= seconds_counter     + 1;
//        CHANGING_TS : tenths_counter      <= tenths_counter      + 1;
//        CHANGING_H  : hundredths_counter  <= hundredths_counter  + 1;
//      endcase
//end
  

endmodule
