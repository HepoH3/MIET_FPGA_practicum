`timescale 1ns / 1ps
 
module stopwatch #(
  parameter PULSE_MAX  = 17'd259999,
            HUNTHS_MAX = 4'd9,
            TENTHS_MAX = 4'd9,
            SEC_MAX    = 4'd9,
            TENS_MAX   = 4'd9
            )
(
  input        clk100_i,
  input        rstn_i,
  input        start_stop_i,
  input        set_i,
  input        change_i,
  
  output [6:0] hex0_o,
  output [6:0] hex1_o,
  output [6:0] hex2_o,
  output [6:0] hex3_o
  );

localparam  RUN_STATE  = 1'd1;
localparam  SET_STATE  = 1'd0;
reg   state_stopwatch  = RUN_STATE;

// синхронизация обработки
// нажатия кнопки «СтартСтоп»
wire start_stop_was_pressed;
 
keypress start_stop( 
  .clk100_i          ( clk100_i               ),
  .rstn_i            ( rstn_i                 ),
  .en_i              ( start_stop_i           ),
  .btn_was_pressed_o ( start_stop_was_pressed )
);
 
reg  device_running;
wire set_was_pressed;
wire change_was_pressed;

keypress set( 
  .clk100_i          ( clk100_i        ),
  .rstn_i            ( rstn_i          ),
  .en_i              ( set_i           ),
  .btn_was_pressed_o ( set_was_pressed )
);

keypress change( 
  .clk100_i          ( clk100_i           ),
  .rstn_i            ( rstn_i             ),
  .en_i              ( change_i           ),
  .btn_was_pressed_o ( change_was_pressed )
);

wire [3:0] ten_sec_count;

initial_state_stopwatch iss(
  .clk_i                ( clk100_i                   ),
  .rstn_i               ( rstn_i                     ),
  .dev_run_i            ( device_running             ),
  .set_was_pressed_i    ( set_was_pressed_i          ),
  .change_was_pressed_i ( change_was_pressed_i       ),
  .hund                 ( hundredths_counter   [3:0] ),
  .tenth                ( tenths_counter       [3:0] ),
  .sec                  ( seconds_counter      [3:0] ),
  .ten                  ( ten_sec_count        [3:0] ) 
);  

//выработка признака «device_running »

always @( posedge clk100_i )
  if( set_was_pressed_i && ~device_running )
    state_stopwatch <= SET_STATE;

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    device_running <= 0;
  else if ( start_stop_was_pressed && state_stopwatch == RUN_STATE )
    device_running <= ~device_running;
end

 // счётчик импульсов
 // и признак истечения 0,01 сек
reg [16:0] pulse_counter = 17'd0;
wire hundredth_of_second_passed = ( pulse_counter == PULSE_MAX );

always @ ( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i )
    pulse_counter <= 0;
  else if ( device_running | hundredth_of_second_passed )
    if ( hundredth_of_second_passed )
      pulse_counter <= 0;
    else 
      pulse_counter <= pulse_counter + 1;
end

// основные счётчики
wire [3:0] hundredths_counter;
wire tenth_of_second_passed = ( ( hundredths_counter == HUNTHS_MAX ) & hundredth_of_second_passed );

counter hunths(
  .clk_i           ( clk100_i                         ),
  .rstn_i          ( rstn_i                           ),
  .type_of_time1_i ( hundredth_of_second_passed       ),
  .type_of_time2_i ( tenth_of_second_passed           ),
  .counter_o       ( hundredths_counter         [3:0] )
);

wire [3:0] tenths_counter;
wire second_passed = ( ( tenths_counter == TENTHS_MAX ) & tenth_of_second_passed );

counter tenths(
  .clk_i           ( clk100_i                     ),
  .rstn_i          ( rstn_i                       ),
  .type_of_time1_i ( tenth_of_second_passed       ),
  .type_of_time2_i ( second_passed                ),
  .counter_o       ( tenths_counter         [3:0] )
);

wire [3:0] seconds_counter;
wire ten_seconds_passed = ( ( seconds_counter == SEC_MAX ) & second_passed );

counter seconds(
  .clk_i           ( clk100_i                 ),
  .rstn_i          ( rstn_i                   ),
  .type_of_time1_i ( second_passed            ),
  .type_of_time2_i ( ten_seconds_passed       ),
  .counter_o       ( seconds_counter    [3:0] )
);


reg [3:0] ten_seconds_counter;
assign ten_sec_count = ten_seconds_counter;

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) 
    ten_seconds_counter <= 0;
  else if ( ten_seconds_passed )
    if ( ten_seconds_counter == TENS_MAX )
      ten_seconds_counter <= 0;
    else 
      ten_seconds_counter <= ten_seconds_counter + 1;
end

// дешифраторы для отображения
// содержимого основных регистров
// на семисегментных индикаторах
wire [6:0] decoder_ten_seconds;

decoder d1(
  .in  ( ten_seconds_counter [3:0] ),
  .out ( decoder_ten_seconds [6:0] )
);

assign hex3_o = decoder_ten_seconds;

wire [6:0] decoder_seconds;

decoder d2(
  .in  ( seconds_counter [3:0] ),
  .out ( decoder_seconds [6:0] )
);

assign hex2_o = decoder_seconds;

wire [6:0] decoder_tenths;

decoder d3(
  .in  ( tenths_counter [3:0] ),
  .out ( decoder_tenths [6:0] )
);

assign hex1_o = decoder_tenths;

wire [6:0] decoder_hundredths;

decoder d4(
  .in  ( hundredths_counter [3:0] ),
  .out ( decoder_hundredths [6:0] )
);

assign hex0_o = decoder_hundredths;

endmodule
