`timescale 1ns / 1ps

module stopwatch(
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

  // синхронизация кнопки start_stop_i
  reg [2:0] btn_start_sync;
  wire      btn_start_pressed;
  
  always @ ( posedge clk100_i ) begin
    btn_start_sync[0] <= start_stop_i;
    btn_start_sync[1] <= btn_start_sync[0];
    btn_start_sync[2] <= btn_start_sync[1];
  end
  assign btn_start_pressed = ~btn_start_sync[2] & btn_start_sync[1];
  
  // синхронизация кнопки set_i
  reg [2:0] btn_set_sync;
  wire      btn_set_pressed;
  
  always @ ( posedge clk100_i ) begin
    btn_set_sync[0] <= set_i;
    btn_set_sync[1] <= btn_set_sync[0];
    btn_set_sync[2] <= btn_set_sync[1];
  end
  assign btn_set_pressed = ~btn_set_sync[2] & btn_set_sync[1];
  
  // синхронизация кнопки change_i
  reg [2:0] btn_change_sync;
  wire      btn_change_pressed;
  
  always @ ( posedge clk100_i ) begin
    btn_change_sync[0] <= change_i;
    btn_change_sync[1] <= btn_change_sync[0];
    btn_change_sync[2] <= btn_change_sync[1];
  end
  assign btn_change_pressed = ~btn_change_sync[2] & btn_change_sync[1];



  // состояние stopwatch
  reg state_stopwatch;
  reg next_state_stopwatch;
  
  localparam STATE_DEF       = 1'd0;
  localparam STATE_SET       = 1'd1;
  
  localparam STATE_SET_0_01S = 2'd0;
  localparam STATE_SET_0_1S  = 2'd1;
  localparam STATE_SET_1S    = 2'd2;
  localparam STATE_SET_10S   = 2'd3;
  
  always @ ( * ) begin
    case ( state_stopwatch )
      STATE_DEF:  if ( btn_set_pressed )   next_state_stopwatch = STATE_SET;
      STATE_SET:  if ( btn_start_pressed ) next_state_stopwatch = STATE_DEF;
    endcase
  end
  
  always @ ( posedge clk100_i or negedge rstn_i ) begin
    if ( !rstn_i )
      state_stopwatch <= STATE_DEF;
    else
      state_stopwatch <= next_state_stopwatch;
  end
  
  reg [1:0] state_set;
  reg [1:0] next_state_set;
  
  always @ ( * ) begin
    if ( state_stopwatch )
      case ( state_set )
                        
        STATE_SET_0_01S:  if ( btn_set_pressed ) next_state_set = STATE_SET_0_1S;
                          //else next_state_set = STATE_SET_0_01S;                  
                        
        STATE_SET_0_1S:   if ( btn_set_pressed ) next_state_set = STATE_SET_1S;
                          //else next_state_set = STATE_SET_0_01S;
                        
        STATE_SET_1S:     if ( btn_set_pressed ) next_state_set = STATE_SET_10S;
                          //else next_state_set = STATE_SET_0_01S;
                        
        STATE_SET_10S:    if ( btn_set_pressed ) next_state_set = STATE_SET_0_01S;
                          //else next_state_set = STATE_SET_0_01S;
      endcase
  end

  always @ ( posedge clk100_i or negedge rstn_i) begin
      if ( !rstn_i )
        state_set <= STATE_SET_0_01S;
      else
        state_set <= next_state_set;
  end

  // вкл/выкл девайса
  reg dev_run = 1'b0;
  always @ ( posedge clk100_i ) begin
    if ( state_stopwatch == STATE_DEF )
      if ( btn_start_pressed )
        dev_run <= ~dev_run;
  end



  // счетчик импульсов и признак истечения 0.01с 
  reg [19:0] pulse_counter = 20'd0;
  wire hundredth_of_second_passed = ( pulse_counter == 20'd249999 );
  
  always @ ( posedge clk100_i or negedge rstn_i) begin
    if ( !rstn_i )
      pulse_counter <= 0; 
    else if ( state_stopwatch == STATE_DEF )
     if ( dev_run | hundredth_of_second_passed )
       if ( hundredth_of_second_passed )
         pulse_counter <= 0;
       else
         pulse_counter <= pulse_counter + 1;
  end
  
  // счетчик сотых секунды
  reg [3:0] hundredths_counter = 4'd0;
  wire tenth_of_second_passed = ( ( hundredths_counter == 4'd9 ) & hundredth_of_second_passed );
   
  always @ ( posedge clk100_i or negedge rstn_i ) begin
    if ( !rstn_i )
       hundredths_counter <= 0;
    else if ( state_stopwatch == STATE_SET & state_set == STATE_SET_0_01S )
      begin
        if ( hundredths_counter == 4'd9 ) 
            hundredths_counter <= 0; 
        if ( btn_change_pressed )
          hundredths_counter <= hundredths_counter + 1;
      end
    else if ( state_stopwatch == STATE_DEF )
      if ( hundredth_of_second_passed )
        if ( tenth_of_second_passed )
          hundredths_counter <= 0;
        else
          hundredths_counter <= hundredths_counter + 1;
  end
  
  // счетчик десятых секунды 
  reg [3:0] tenths_counter = 4'd0;
  wire second_passed = ( ( tenths_counter == 4'd9 ) & tenth_of_second_passed );
   
  always @ ( posedge clk100_i or negedge rstn_i)  begin
    if ( !rstn_i )
      tenths_counter <= 0;
    else if ( state_stopwatch == STATE_SET & state_set == STATE_SET_0_1S )
      begin
        if ( tenths_counter == 4'd9 ) 
            tenths_counter <= 0; 
        if ( btn_change_pressed )
          tenths_counter <= tenths_counter + 1;
      end
    else if ( state_stopwatch == STATE_DEF )
      if ( tenth_of_second_passed )
        if ( second_passed ) 
          tenths_counter <= 0; 
        else
          tenths_counter <= tenths_counter + 1;
  end
  
  // счетчик секунд
  reg [3:0] seconds_counter = 4'd0;
  wire ten_seconds_passed = ( ( seconds_counter == 4'd9 ) & second_passed );
   
  always @ ( posedge clk100_i or negedge rstn_i)  begin
    if ( !rstn_i )
      seconds_counter <= 0;
    else if ( state_stopwatch == STATE_SET & state_set == STATE_SET_1S )
      begin
        if ( seconds_counter == 4'd9 ) 
          seconds_counter <= 0; 
        if ( btn_change_pressed )
          seconds_counter <= seconds_counter + 1;
      end
    else if ( state_stopwatch == STATE_DEF )
      if  ( second_passed )
        if ( ten_seconds_passed ) 
          seconds_counter <= 0; 
        else
          seconds_counter <= seconds_counter + 1;
  end
  
  // счетчик десятков секунд
  reg [3:0] ten_seconds_counter = 4'd0;
   
  always @ ( posedge clk100_i or negedge rstn_i)  begin
    if ( !rstn_i )
      ten_seconds_counter <= 0;
    else if ( state_stopwatch == STATE_SET & state_set == STATE_SET_10S )
      begin
        if ( ten_seconds_counter == 4'd9 ) 
            ten_seconds_counter <= 0; 
        if ( btn_change_pressed )
          ten_seconds_counter <= ten_seconds_counter + 1;
      end
    else if ( state_stopwatch == STATE_DEF )
      if ( ten_seconds_passed )
        if ( ten_seconds_counter == 4'd9 ) 
          ten_seconds_counter <= 0; 
        else
          ten_seconds_counter <= ten_seconds_counter + 1;
  end
  
  // Вывод значений на индикаторы hex[3:0]
  reg [6:0] decoder_ten_seconds;
  always @ ( * ) begin
    case ( ten_seconds_counter )
      4'd0:    decoder_ten_seconds <= 7'b1000000;
      4'd1:    decoder_ten_seconds <= 7'b1111001;
      4'd2:    decoder_ten_seconds <= 7'b0100100;
      4'd3:    decoder_ten_seconds <= 7'b0110000;
      4'd4:    decoder_ten_seconds <= 7'b0011001;
      4'd5:    decoder_ten_seconds <= 7'b0010010;
      4'd6:    decoder_ten_seconds <= 7'b0000010;
      4'd7:    decoder_ten_seconds <= 7'b1111000;
      4'd8:    decoder_ten_seconds <= 7'b0000000;
      4'd9:    decoder_ten_seconds <= 7'b0010000;
      default: decoder_ten_seconds <= 7'b1111111;
    endcase
  end
  assign hex3_o = decoder_ten_seconds;
   
  reg [6:0] decoder_seconds;
  always @ ( * ) begin
    case ( seconds_counter )
      4'd0:    decoder_seconds <= 7'b1000000;
      4'd1:    decoder_seconds <= 7'b1111001;
      4'd2:    decoder_seconds <= 7'b0100100;
      4'd3:    decoder_seconds <= 7'b0110000;
      4'd4:    decoder_seconds <= 7'b0011001;
      4'd5:    decoder_seconds <= 7'b0010010;
      4'd6:    decoder_seconds <= 7'b0000010;
      4'd7:    decoder_seconds <= 7'b1111000;
      4'd8:    decoder_seconds <= 7'b0000000;
      4'd9:    decoder_seconds <= 7'b0010000;
      default: decoder_seconds <= 7'b1111111;
    endcase
  end
  assign hex2_o = decoder_seconds; 
  
  reg [6:0] decoder_tenths;
  always @ ( * ) begin
    case ( tenths_counter )
      4'd0:    decoder_tenths <= 7'b1000000;
      4'd1:    decoder_tenths <= 7'b1111001;
      4'd2:    decoder_tenths <= 7'b0100100;
      4'd3:    decoder_tenths <= 7'b0110000;
      4'd4:    decoder_tenths <= 7'b0011001;
      4'd5:    decoder_tenths <= 7'b0010010;
      4'd6:    decoder_tenths <= 7'b0000010;
      4'd7:    decoder_tenths <= 7'b1111000;
      4'd8:    decoder_tenths <= 7'b0000000;
      4'd9:    decoder_tenths <= 7'b0010000;
      default: decoder_tenths <= 7'b1111111;
    endcase
  end
  assign hex1_o = decoder_tenths; 
   
  reg [6:0] decoder_hundredths; 
  always @ ( * ) begin
    case ( hundredths_counter )
      4'd0:    decoder_hundredths <= 7'b1000000;
      4'd1:    decoder_hundredths <= 7'b1111001;
      4'd2:    decoder_hundredths <= 7'b0100100;
      4'd3:    decoder_hundredths <= 7'b0110000;
      4'd4:    decoder_hundredths <= 7'b0011001;
      4'd5:    decoder_hundredths <= 7'b0010010;
      4'd6:    decoder_hundredths <= 7'b0000010;
      4'd7:    decoder_hundredths <= 7'b1111000;
      4'd8:    decoder_hundredths <= 7'b0000000;
      4'd9:    decoder_hundredths <= 7'b0010000;
      default: decoder_hundredths <= 7'b1111111;
    endcase
  end
  assign hex0_o = decoder_hundredths; 
  
endmodule