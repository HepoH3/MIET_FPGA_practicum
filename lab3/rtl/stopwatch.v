`timescale 1ns / 1ps

module stopwatch(
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

localparam PULSE_MAX       = 20'd259999;
localparam HUNDREDTH_MAX   = 4'd9;
localparam TENTH_MAX       = 4'd9;
localparam SECONDS_MAX     = 4'd9;
localparam TEN_SECONDS_MAX = 4'd9;
    
reg  [2:0] button_syncroniser;
wire       button_was_pressed;
// синхронизация обработки нажатия кнопки СтартСтоп
always @( posedge clk100_i or negedge rstn_i ) 
  begin
    if ( !rstn_i )
      button_syncroniser    <= 3'b0;
    else
      button_syncroniser[0] <= !start_stop_i;
      button_syncroniser[1] <= button_syncroniser[0];
      button_syncroniser[2] <= button_syncroniser[1];
  end

assign button_was_pressed = !button_syncroniser[2] & button_syncroniser[1];
//Выработка признака device_running
reg  device_running;

always @( posedge clk100_i or negedge rstn_i )
  begin
    if ( !rstn_i )
      device_running <= 0;
    else if ( button_was_pressed & ( state_regulation == STATE_DEFAULT ) )
      device_running <= !device_running;
  end
  
// счетчик импульсов и признак истечени 0.01 сек
reg  [19:0] pulse_counter = 20'd0;
wire        hundredth_of_second_passed = ( pulse_counter == PULSE_MAX );

always @( posedge clk100_i or negedge rstn_i ) 
  begin
    if ( !rstn_i ) 
      pulse_counter <= 0;
    else if ( device_running | hundredth_of_second_passed )
      if ( hundredth_of_second_passed )
        pulse_counter <= 0;
      else 
        pulse_counter <= pulse_counter + 1;
  end    
// счетчики десятых секунд и десятисекунд
reg [3:0] hundredths_counter      = 4'd0;
wire      tenth_of_second_passed = ( ( hundredths_counter == HUNDREDTH_MAX ) & hundredth_of_second_passed );

always @( posedge clk100_i or negedge rstn_i ) 
  begin
    if ( !rstn_i )
      hundredths_counter <= 0;
    else if ( hundredth_of_second_passed )
      if ( tenth_of_second_passed )
        hundredths_counter <= 0;
      else
        hundredths_counter <= hundredths_counter + 1;
  end

reg [3:0] tenths_counter = 4'd0;
wire      second_passed  = ( ( tenths_counter == TENTH_MAX ) & tenth_of_second_passed );

always @( posedge clk100_i or negedge rstn_i ) 
  begin
    if ( !rstn_i )
      tenths_counter <= 0;
    else if ( tenth_of_second_passed )
      if ( second_passed )
        tenths_counter <= 0;
      else
        tenths_counter <= tenths_counter + 1;
  end

reg [3:0] seconds_counter    = 4'd0;
wire      ten_seconds_passed = ( ( seconds_counter == SECONDS_MAX ) & second_passed );         

always @( posedge clk100_i or negedge rstn_i ) 
  begin
    if ( !rstn_i )
      seconds_counter <= 0;
    else if ( second_passed )
      if ( ten_seconds_passed )
        seconds_counter <= 0;
      else
        seconds_counter <= seconds_counter + 1;
  end

reg [3:0] ten_seconds_counter = 4'd0;

always @( posedge clk100_i or negedge rstn_i ) 
  begin
    if ( !rstn_i )
      ten_seconds_counter <= 0;
    else if ( ten_seconds_passed )
      if ( ten_seconds_counter == TEN_SECONDS_MAX )
        ten_seconds_counter <= 0;
      else
        ten_seconds_counter <= ten_seconds_counter + 1;
  end

hex hex3 (
  .in  ( ten_seconds_counter ),
  .out ( hex3_o              )
  );
 
hex hex2 (
  .in  ( seconds_counter     ),
  .out ( hex2_o              )
  );
  
hex hex1 (
  .in  ( tenths_counter      ),
  .out ( hex1_o              )
  );  

hex hex0 (
  .in  ( hundredths_counter  ),
  .out ( hex0_o              )
  );
// синхронизация обработки нажатия кнопки Set
reg  [2:0] set_synchroniser;
wire       set_was_pressed;

always@  ( posedge clk100_i or negedge rstn_i ) 
  begin
    if ( !rstn_i )
      set_synchroniser    <= 3'b0;
    else
      set_synchroniser[0] <= !set_i;
      set_synchroniser[1] <= set_synchroniser[0];
      set_synchroniser[2] <= set_synchroniser[1];
  end

assign set_was_pressed = !set_synchroniser[2] & set_synchroniser[1];
// синхронизация обработки нажатия кнопки Change
reg  [2:0] change_synchroniser;
wire       change_was_pressed;

always@  ( posedge clk100_i or negedge rstn_i ) 
  begin
    if ( !rstn_i )
      change_synchroniser    <= 3'b0;
    else
      change_synchroniser[0] <= !change_i;
      change_synchroniser[1] <= change_synchroniser[0];
      change_synchroniser[2] <= change_synchroniser[1];
  end
  
assign change_was_pressed = !change_synchroniser[2] & change_synchroniser[1];  
// описание состояний
reg [2:0] state_regulation;
reg [2:0] next_state_regulation;
 
localparam STATE_DEFAULT = 3'd0;
localparam STATE_1       = 3'd1;
localparam STATE_2       = 3'd2;
localparam STATE_3       = 3'd3;
localparam STATE_4       = 3'd4;
 
always @(*) 
   begin
     case ( state_regulation )
       STATE_DEFAULT : if ( ( !device_running ) & ( set_was_pressed ) ) 
                         next_state_regulation = STATE_1;
                       else 
                         next_state_regulation = STATE_DEFAULT;

       STATE_1 : if ( set_was_pressed ) 
                   next_state_regulation = STATE_2;
                 else if ( change_was_pressed ) 
                   begin
                     if ( hundredths_counter == HUNDREDTH_MAX )
                       hundredths_counter = 4'd0;
                     else
                       hundredths_counter = hundredths_counter + 1;
                       next_state_regulation = STATE_1;
                   end
                 else 
                   next_state_regulation = STATE_1;

       STATE_2 : if ( set_was_pressed ) 
                   next_state_regulation = STATE_3;
                 else if ( change_was_pressed ) 
                   begin
                     if ( tenths_counter == TENTH_MAX )
                       tenths_counter = 4'd0;
                     else
                       tenths_counter = tenths_counter + 1;
                       next_state_regulation = STATE_2;
                   end
                 else 
                   next_state_regulation = STATE_2;

       STATE_3 : if ( set_was_pressed ) 
                   next_state_regulation = STATE_4;
                 else if ( change_was_pressed ) 
                   begin
                     if ( seconds_counter == SECONDS_MAX )
                       seconds_counter = 4'd0;
                     else
                       seconds_counter = seconds_counter + 1;
                       next_state_regulation = STATE_3;
                   end
                 else 
                   next_state_regulation = STATE_3;

       STATE_4 : if ( set_was_pressed )
                   next_state_regulation = STATE_DEFAULT;
                 else if ( change_was_pressed ) 
                   begin
                     if ( ten_seconds_counter == HUNDREDTH_MAX )
                       ten_seconds_counter = 4'd0;
                     else
                       ten_seconds_counter = ten_seconds_counter + 1;
                       next_state_regulation = STATE_4;
                   end
                 else 
                   next_state_regulation = STATE_4;

       default : next_state_regulation = STATE_DEFAULT;
     endcase
   end 
 
always @( posedge clk100_i or negedge rstn_i )
  begin
   if ( !rstn_i )
     state_regulation <= STATE_DEFAULT;
   else
     state_regulation <= next_state_regulation;
  end 
 
endmodule
