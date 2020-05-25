`timescale 1ns / 1ps
 
module stopwatch #(
  parameter PULSE_MAX  = 17'd259999,
            COUNT_MAX = 4'd9
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

localparam RUN_STATE = 3'd0;
localparam CHANGE_H  = 3'd1;
localparam CHANGE_TS = 3'd2;
localparam CHANGE_S  = 3'd3;
localparam CHANGE_T  = 3'd4;

wire start_stop_was_pressed;
wire set_was_pressed;
wire change_was_pressed;
 
keypress start_stop( 
  .clk100_i          ( clk100_i               ),
  .rstn_i            ( rstn_i                 ),
  .en_i              ( start_stop_i           ),
  .btn_was_pressed_o ( start_stop_was_pressed )
);
 
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

reg        device_running;
wire [2:0] stopwatch_state;
wire       increment;
wire       passed_all;

finstate_machine StW_state(
  .clk_i         ( clk100_i           ),
  .rstn_i        ( rstn_i             ),
  .dev_run_i     ( device_running     ),
  .set_i         ( set_was_pressed    ),
  .change_i      ( change_was_pressed ),
  .state_value_o ( stopwatch_state    ),
  .inc_this_o    ( increment          ),
  .passed_all_o  ( passed_all         )
);



always @ ( posedge clk100_i ) begin
  if( !rstn_i )
    device_running <= 0;
  if ( passed_all )
    device_running <= 1'b1;
  else if ( stopwatch_state == RUN_STATE )
    if ( start_stop_was_pressed )
      device_running <= ~device_running;
end



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



reg [3:0] hundredths_counter;
wire tenth_of_second_passed = ( ( hundredths_counter == COUNT_MAX ) & hundredth_of_second_passed );

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i )
    hundredths_counter <= 4'd0;
  else if ( hundredth_of_second_passed ) begin
    if ( tenth_of_second_passed )
      hundredths_counter <= 4'd0;
    else 
      hundredths_counter <= hundredths_counter + 1;
  end
  else if ( stopwatch_state == CHANGE_H && increment )
    hundredths_counter <= hundredths_counter + 1;
end

reg [3:0] tenths_counter;
wire second_passed = ( ( tenths_counter == COUNT_MAX ) & tenth_of_second_passed );

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) 
    tenths_counter <= 4'd0;
  else if ( tenth_of_second_passed ) begin
    if ( second_passed ) 
      tenths_counter <= 4'd0;
    else 
      tenths_counter <= tenths_counter + 1;
  end
  else if ( stopwatch_state == CHANGE_TS && increment )
    tenths_counter <= tenths_counter + 1;
end

reg [3:0] seconds_counter;
wire ten_seconds_passed = ( ( seconds_counter == COUNT_MAX ) & second_passed );

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i )
    seconds_counter <= 4'd0;
  else if ( second_passed ) begin
    if ( ten_seconds_passed ) 
      seconds_counter <= 4'd0;
    else 
      seconds_counter <= seconds_counter + 1;
  end
  else if ( stopwatch_state == CHANGE_S && increment )
    seconds_counter <= seconds_counter + 1;
end

reg [3:0] ten_seconds_counter;
assign ten_sec_count = ten_seconds_counter;

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) 
    ten_seconds_counter <= 0;
  else if ( ten_seconds_passed )
    if ( ten_seconds_counter == COUNT_MAX )
      ten_seconds_counter <= 0;
    else 
      ten_seconds_counter <= ten_seconds_counter + 1;
end


decoder d1(
  .in  ( ten_seconds_counter [3:0] ),
  .out ( hex3_o              [6:0] )
);

decoder d2(
  .in  ( seconds_counter [3:0] ),
  .out ( hex2_o          [6:0] )
);

decoder d3(
  .in  ( tenths_counter [3:0] ),
  .out ( hex1_o         [6:0] )
);

decoder d4(
  .in  ( hundredths_counter [3:0] ),
  .out ( hex0_o             [6:0] )
);

endmodule
