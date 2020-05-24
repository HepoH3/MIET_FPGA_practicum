module stopwatch (
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

localparam DATA_WIDTH          = 4;
localparam PULSE_WIDTH         = 18;
localparam PULSE_MAX           = 18'd259999;
localparam COUNTER_MAX         = 4'd9;

//Часть I - синхронизация обработки нажатия кнопки «СтартСтоп»/
wire bwp;

Debounce deb(
  .clk100_i   ( clk100_i           ),
  .rstn_i     ( rstn_i             ),
  .en_i       ( !start_stop_i      ),
  .en_down_o  ( bwp                ) 
  );

//Часть II - выработка признака «device_running » Самостоятельная работа студента!
reg device_running = 1'b0;

always @( posedge clk100_i ) begin
  if ( bwp && ( state == STATE_DEFAULT )) begin
    device_running <= ~device_running;  
  end
end

//Часть III - счётчик импульсов и признак истечения 0,01 сек
reg [PULSE_WIDTH - 1:0] pulse_counter              = {PULSE_WIDTH{1'b0}};
wire                    hundredth_of_second_passed = ( pulse_counter == PULSE_MAX );

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) pulse_counter <= 0;
  else 
      if ( device_running | hundredth_of_second_passed )
        if ( hundredth_of_second_passed ) pulse_counter <= 0;
      else pulse_counter <= pulse_counter + 1;
end


//Часть IV - основные счётчики
reg [DATA_WIDTH-1:0] hundredths_counter     = {DATA_WIDTH{1'b0}};
wire                 tenth_of_second_passed = ((hundredths_counter == COUNTER_MAX) & hundredth_of_second_passed);

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) hundredths_counter <= 0;
  else if ( hundredth_of_second_passed )
         if ( tenth_of_second_passed ) hundredths_counter <= 0;
       else hundredths_counter <= hundredths_counter + 1;
end


reg [DATA_WIDTH-1:0] tenths_counter = {DATA_WIDTH{1'b0}};
wire                 second_passed = ((tenths_counter == COUNTER_MAX) & tenth_of_second_passed);

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) tenths_counter <= 0;
  else if ( tenth_of_second_passed )
         if ( second_passed ) tenths_counter <= 0;
       else tenths_counter <= tenths_counter + 1;
end

reg  [DATA_WIDTH-1:0] seconds_counter    = {DATA_WIDTH{1'b0}};
wire                  ten_seconds_passed = (( seconds_counter == COUNTER_MAX ) & second_passed );
always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) seconds_counter <= 0;
  else if ( second_passed )
         if ( ten_seconds_passed ) seconds_counter <= 0;
       else seconds_counter <= seconds_counter + 1;
end

reg [DATA_WIDTH-1:0] ten_seconds_counter = {DATA_WIDTH{1'b0}};
always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) ten_seconds_counter <= 0;
  else if ( ten_seconds_passed )
          if ( ten_seconds_counter == COUNTER_MAX ) ten_seconds_counter <= 0;
       else ten_seconds_counter <= ten_seconds_counter + 1;
end

//Часть V - дешифраторы для отображения содержимого основных регистров на семисегментных индикаторах

  decoder_hex decoder_0(
  .kod_i  ( ten_seconds_counter       ),
  .hex_o  ( hex3_o              [6:0] )
  );  
  
  decoder_hex decoder_1(
  .kod_i  ( seconds_counter           ),
  .hex_o  ( hex2_o              [6:0] )
  );  
  
    decoder_hex decoder_2(
  .kod_i  ( tenths_counter            ),
  .hex_o  ( hex1_o              [6:0] )
  );  
      decoder_hex decoder_3(
  .kod_i  ( hundredths_counter        ),
  .hex_o  ( hex0_o              [6:0] )
  );  
  
// Set
wire       set_was_pressed;

Debounce set(
  .clk100_i   ( clk100_i           ),
  .rstn_i     ( rstn_i             ),
  .en_i       ( !set_i             ),
  .en_down_o  ( set_was_pressed    ) 
  );
// Change
wire       change_was_pressed;

Debounce change(
  .clk100_i   ( clk100_i           ),
  .rstn_i     ( rstn_i             ),
  .en_i       ( !change_i          ),
  .en_down_o  ( change_was_pressed ) 
  );

// state
reg [2:0] state;
reg [2:0] next_state;

localparam STATE_DEFAULT = 3'd0;
localparam STATE_1       = 3'd1;
localparam STATE_2       = 3'd2;
localparam STATE_3       = 3'd3;
localparam STATE_4       = 3'd4;

always @(*) 
   begin
     case ( state )
       STATE_DEFAULT : if ( ( !device_running ) & ( set_was_pressed ) ) begin
                         next_state = STATE_1;
                       end
                       else begin
                           next_state = STATE_DEFAULT;
                       end

       STATE_1 :       if ( set_was_pressed ) begin
                         next_state = STATE_2;
                       end
                       else 
                           if ( change_was_pressed ) begin
                             if ( hundredths_counter == COUNTER_MAX ) begin
                               hundredths_counter = {DATA_WIDTH{1'b0}};
                             end
                             else begin
                              hundredths_counter = hundredths_counter + 1;
                              next_state         = STATE_1;
                             end
                           end
                       else begin
                             next_state = STATE_1;
                       end

       STATE_2 :       if ( set_was_pressed ) begin
                         next_state = STATE_3;
                       end
                       else 
                           if ( change_was_pressed ) begin
                             if ( tenths_counter == COUNTER_MAX ) begin
                               tenths_counter = {DATA_WIDTH{1'b0}};
                             end
                             else begin
                              tenths_counter = tenths_counter + 1;
                              next_state     = STATE_2;
                             end
                           end
                       else begin
                             next_state = STATE_2;
                       end

       STATE_3 :       if ( set_was_pressed ) begin
                         next_state = STATE_4;
                       end
                       else 
                           if ( change_was_pressed ) begin
                             if ( seconds_counter == COUNTER_MAX ) begin
                               seconds_counter      = {DATA_WIDTH{1'b0}};
                             end
                             else begin
                              seconds_counter       = seconds_counter + 1;
                              next_state            = STATE_3;
                             end
                           end
                       else begin
                             next_state  = STATE_3;
                       end

       STATE_4 :       if ( set_was_pressed ) begin
                         next_state = STATE_DEFAULT;
                       end
                       else 
                           if ( change_was_pressed ) begin
                             if ( ten_seconds_counter == COUNTER_MAX ) begin
                               ten_seconds_counter  = {DATA_WIDTH{1'b0}};
                             end
                             else begin
                              ten_seconds_counter   = seconds_counter + 1;
                              ten_seconds_counter   = STATE_4;
                             end
                           end
                       else begin
                             next_state  = STATE_4;
                       end 

       default : next_state = STATE_DEFAULT;
     endcase
   end 

always @( posedge clk100_i or negedge rstn_i )
  begin
   if ( !rstn_i )
     state <= STATE_DEFAULT;
   else
     state <= next_state;
  end 

endmodule