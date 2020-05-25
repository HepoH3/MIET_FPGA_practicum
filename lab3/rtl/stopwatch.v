`timescale 1ns / 1ps

module stopwatch #(
  parameter PULSE = 18'd259999
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

localparam HUNDREDTHS    = 4'd9;
localparam TENTHS        = 4'd9;
localparam SECONDS       = 4'd9;
localparam TEN_SECONDS   = 4'd9;
localparam DEFAULT_STATE = 3'd0;
localparam STATE_1       = 3'd1;
localparam STATE_2       = 3'd2;
localparam STATE_3       = 3'd3;
localparam STATE_4       = 3'd4;

reg [2:0] state;
reg [2:0] next_state; 

wire button_start_stop_was_pressed;
wire button_set_was_pressed;
wire button_change_was_pressed;

button_sync button_start_stop (
  .in                 ( start_stop_i                  ),
  .clk                ( clk100_i                      ),
  .button_was_pressed ( button_start_stop_was_pressed )
    );
    
button_sync button_set (
  .in                 ( set_i                  ),
  .clk                ( clk100_i               ),
  .button_was_pressed ( button_set_was_pressed )
    );

button_sync button_change (
  .in                 ( change_i                  ),
  .clk                ( clk100_i                  ),
  .button_was_pressed ( button_change_was_pressed )
    );

reg device_running;
always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) begin
    device_running <= 1'b0;
  end
  else if ( button_start_stop_was_pressed & state==DEFAULT_STATE ) begin
    device_running <= ~device_running;
  end
end

reg [17:0] pulse_counter = 18'd0;
wire hundredth_of_second_passed = ( pulse_counter == PULSE );
always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) pulse_counter <= 0;
  else if ( device_running | hundredth_of_second_passed )
    if ( hundredth_of_second_passed )
      pulse_counter <= 0;
    else pulse_counter <= pulse_counter + 1;
  end

reg [3:0] hundredths_counter = 4'd0;
wire tenth_of_second_passed = ( ( hundredths_counter == HUNDREDTHS ) & hundredth_of_second_passed );
always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) hundredths_counter <= 0;
  else if ( hundredth_of_second_passed )
    if ( tenth_of_second_passed )
      hundredths_counter <= 0;
    else hundredths_counter <= hundredths_counter + 1;
  end

reg [3:0] tenths_counter = 4'd0;
wire second_passed = ( ( tenths_counter == TENTHS ) & tenth_of_second_passed );
always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) tenths_counter <= 0;
  else if ( tenth_of_second_passed )
    if ( second_passed )
      tenths_counter <= 0;
    else tenths_counter <= tenths_counter + 1;
  end

reg [3:0] seconds_counter = 4'd0;
wire ten_seconds_passed = ( ( seconds_counter == SECONDS ) & second_passed );
always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) seconds_counter <= 0;
  else if ( second_passed )
    if ( ten_seconds_passed )
      seconds_counter <= 0;
    else seconds_counter <= seconds_counter + 1;
  end
  
reg [3:0] ten_seconds_counter = 4'd0;
always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) ten_seconds_counter <= 0;
  else if ( ten_seconds_passed )
    if ( ten_seconds_counter == TEN_SECONDS )
      ten_seconds_counter <= 0;
    else ten_seconds_counter <= ten_seconds_counter + 1;
  end

hex_decoder decoder_hex3 (
  .counter ( ten_seconds_counter ),
  .hex     ( hex3_o              )
  );

hex_decoder decoder_hex2 (
  .counter ( seconds_counter ),
  .hex     ( hex2_o          )
  );
  
hex_decoder decoder_hex1 (
  .counter ( tenths_counter ),
  .hex     ( hex1_o         )
  );

hex_decoder decoder_hex0 (
  .counter ( hundredths_counter ),
  .hex     ( hex0_o             )
  );


always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) state <= DEFAULT_STATE;
  else state <= next_state;
end

always @( * ) begin
  case ( state )
    DEFAULT_STATE: if ( ( !device_running ) && ( button_set_was_pressed ) )
                       next_state <= STATE_1;
                   else next_state <= DEFAULT_STATE; 
                   
    STATE_1:       if ( button_set_was_pressed )
                      next_state = STATE_2;
                   else 
                     if ( button_change_was_pressed ) begin 
                       if ( hundredths_counter == HUNDREDTHS )
                         hundredths_counter = 4'd0;
                       else hundredths_counter = hundredths_counter + 1;
                       next_state = STATE_1;
                       end
                     else next_state = STATE_1;
                     
    STATE_2:       if ( button_set_was_pressed )
                      next_state = STATE_3;
                   else 
                     if ( button_change_was_pressed ) begin 
                       if ( tenths_counter == TENTHS )
                         tenths_counter = 4'd0;
                       else tenths_counter = tenths_counter + 1;
                       next_state = STATE_2;
                       end
                     else next_state = STATE_2;
                     
    STATE_3:       if ( button_set_was_pressed )
                      next_state = STATE_4;
                   else 
                     if ( button_change_was_pressed ) begin 
                       if ( seconds_counter == SECONDS )
                         seconds_counter = 4'd0;
                       else seconds_counter = seconds_counter + 1;
                       next_state = STATE_3;
                       end
                     else next_state = STATE_3;
    STATE_4:       if ( button_set_was_pressed )
                      next_state = DEFAULT_STATE;
                   else 
                     if ( button_change_was_pressed ) begin 
                       if ( ten_seconds_counter == TEN_SECONDS )
                         ten_seconds_counter = 4'd0;
                       else ten_seconds_counter = ten_seconds_counter + 1;
                       next_state = STATE_4;
                       end
                     else next_state = STATE_4;                                                                          
  endcase                 
end

endmodule