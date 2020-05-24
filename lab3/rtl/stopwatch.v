`timescale 1ns / 1ps

module stopwatch(
    input clk100_i,
    input rstn_i,
    input start_stop_i,
    input set_i,
    input change_i,
    output [6:0] hex0_o, //индикатор сотых долей секунды
    output [6:0] hex1_o, //индикатор десытых долей секунды
    output [6:0] hex2_o, //индикатор секунд
    output [6:0] hex3_o  //индикатор десятков секунд
);

// Часть 1
// нажатие кнопки "Старт/Стоп"
reg [2:0] button_syncroniser;
wire button_was_pressed;
always @( posedge clk100_i ) begin
  button_syncroniser[0] <= start_stop_i;
  button_syncroniser[1] <= button_syncroniser[0];
  button_syncroniser[2] <= button_syncroniser[1];
end

assign button_was_pressed = ~button_syncroniser[2] & button_syncroniser[1];

//Часть 2
//Самостоятельная работа студента
reg device_running;


//Часть 3
// Счётчик импульсов и признак истечения 0.01 сек
reg [16:0] pulse_counter = 17'd0;
wire hundredth_of_second_passed = (pulse_counter == 17'd259999);
always @(posedge clk100_i or posedge rstn_i) begin
  if ( rstn_i ) pulse_counter <= 0;
  else if ( device_running | hundredth_of_second_passed)
    if (hundredth_of_second_passed)
      pulse_counter <= 0;
    else pulse_counter <= pulse_counter + 1;
end

// Часть 4 - основные счётчики
reg [3:0]  hundredth_counter = 4'd0;
wire tenth_of_second_passed = ((hundredth_counter == 4'd9) & hundredth_of_second_passed);
always @(posedge clk100_i or posedge rstn_i) begin
  if ( rstn_i ) hundredth_counter <= 0;
  else if ( hundredth_of_second_passed )
    if ( tenth_of_second_passed )
      hundredth_counter <= 0;
    else hundredth_counter <= hundredth_counter + 1;
end

reg [3:0] tenth_counter = 4'd0;
wire second_passed = ((tenth_counter == 4'd9) & tenth_of_second_passed);
always @(posedge clk100_i or posedge rstn_i) begin
  if ( rstn_i ) tenth_counter <= 0;
  else if ( tenth_of_second_passed )
    if ( second_passed )
      tenth_counter <= 0;
    else tenth_counter <= tenth_counter + 1;
end
  
reg [3:0] second_counter = 4'd0;
wire tenth_seconds_passed = ((second_counter == 4'd9) & second_passed);
always @(posedge clk100_i or posedge rstn_i) begin
  if ( rstn_i ) second_counter <= 0;
  else if ( second_passed )
    if ( tenth_seconds_passed )
      second_counter <= 0;
    else second_counter <= second_counter + 1;
end

reg [3:0] ten_seconds_counter = 4'd0;
always @(posedge clk100_i or posedge rstn_i) begin
  if ( rstn_i ) ten_seconds_counter <= 0;
  else if ( tenth_seconds_passed )
    if ( ten_seconds_counter == 4'd9 )
     ten_seconds_counter <= 0;
    else ten_seconds_counter <= ten_seconds_counter + 1;
end

//Часть 5 дешифратор
reg [6:0] decoder_ten_seconds;
always @(*) begin
  case (ten_seconds_counter)
    4'd0:  decoder_ten_seconds <= 7'b0000001;
    4'd1:  decoder_ten_seconds <= 7'b1001111;
    4'd2:  decoder_ten_seconds <= 7'b0010010;
    4'd3:  decoder_ten_seconds <= 7'b0000110;
    4'd4:  decoder_ten_seconds <= 7'b1001100;
    4'd5:  decoder_ten_seconds <= 7'b0100100;
    4'd6:  decoder_ten_seconds <= 7'b0100000;
    4'd7:  decoder_ten_seconds <= 7'b0001111;
    4'd8:  decoder_ten_seconds <= 7'b0000000;
    4'd9:  decoder_ten_seconds <= 7'b0000100;
    default: decoder_ten_seconds <= 7'b1111111;
  endcase;
end
assign hex3 = decoder_ten_seconds;
reg [6:0] decoder_seconds;
always @(*) begin
  case (second_counter)
    4'd0:  decoder_seconds <= 7'b0000001;
    4'd1:  decoder_seconds <= 7'b1001111;
    4'd2:  decoder_seconds <= 7'b0010010;
    4'd3:  decoder_seconds <= 7'b0000110;
    4'd4:  decoder_seconds <= 7'b1001100;
    4'd5:  decoder_seconds <= 7'b0100100;
    4'd6:  decoder_seconds <= 7'b0100000;
    4'd7:  decoder_seconds <= 7'b0001111;
    4'd8:  decoder_seconds <= 7'b0000000;
    4'd9:  decoder_seconds <= 7'b0000100;
    default: decoder_seconds <= 7'b1111111;
  endcase;
end
assign hex2 = decoder_seconds;

reg [6:0] decoder_tenths;
always @(*) begin
  case (tenth_counter)
    4'd0:  decoder_tenths <= 7'b0000001;
    4'd1:  decoder_tenths <= 7'b1001111;
    4'd2:  decoder_tenths <= 7'b0010010;
    4'd3:  decoder_tenths <= 7'b0000110;
    4'd4:  decoder_tenths <= 7'b1001100;
    4'd5:  decoder_tenths <= 7'b0100100;
    4'd6:  decoder_tenths <= 7'b0100000;
    4'd7:  decoder_tenths <= 7'b0001111;
    4'd8:  decoder_tenths <= 7'b0000000;
    4'd9:  decoder_tenths <= 7'b0000100;
    default: decoder_tenths <= 7'b1111111;
  endcase;
end
assign hex1 = decoder_tenths;

reg [6:0] decoder_hundredths;
always @(*) begin
  case (hundredth_counter)
    4'd0:  decoder_hundredths <= 7'b0000001;
    4'd1:  decoder_hundredths <= 7'b1001111;
    4'd2:  decoder_hundredths <= 7'b0010010;
    4'd3:  decoder_hundredths <= 7'b0000110;
    4'd4:  decoder_hundredths <= 7'b1001100;
    4'd5:  decoder_hundredths <= 7'b0100100;
    4'd6:  decoder_hundredths <= 7'b0100000;
    4'd7:  decoder_hundredths <= 7'b0001111;
    4'd8:  decoder_hundredths <= 7'b0000000;
    4'd9:  decoder_hundredths <= 7'b0000100;
    default: decoder_hundredths <= 7'b1111111;
  endcase;
end
assign hex0 = decoder_hundredths;

endmodule