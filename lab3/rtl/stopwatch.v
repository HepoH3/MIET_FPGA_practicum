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
localparam STATE_DEFAULT = 3'd0;
localparam STATE_1       = 3'd1;
localparam STATE_2       = 3'd2;
localparam STATE_3       = 3'd3;
localparam STATE_4       = 3'd4;
localparam PULSE_MAX     = 18'd259999;
localparam COUNTER_MAX   = 4'd9;
reg [1:0] btn_set_syncroniser;
reg [1:0] btn_change_syncroniser;
reg [1:0] btn_start_stop_sync;
reg [2:0] state = STATE_DEFAULT;
reg [2:0] next_state;
reg       device_running = 1'd0;
wire      btn_change_was_pressed;
wire      btn_set_was_pressed;
wire      btn_start_stop_was_pressed;
always @( posedge clk100_i )
begin
  btn_start_stop_sync[0] <= ~start_stop_i;
  btn_start_stop_sync[1] <= btn_start_stop_sync[0];
end
assign btn_start_stop_was_pressed = ~btn_start_stop_sync[1] & btn_start_stop_sync[0];
always @( posedge clk100_i )
begin
  btn_set_syncroniser[0] <= ~set_i;
  btn_set_syncroniser[1] <= btn_set_syncroniser[0];
end
assign btn_set_was_pressed = ~btn_set_syncroniser[1] & btn_set_syncroniser[0];
always @( posedge clk100_i )
begin
  btn_change_syncroniser[0] <= ~change_i;
  btn_change_syncroniser[1] <= btn_change_syncroniser[0];
end
assign btn_change_was_pressed = ~btn_change_syncroniser[1] & btn_change_syncroniser[0];
always @( posedge clk100_i )
begin
  if ( btn_start_stop_was_pressed && state == STATE_DEFAULT ) 
    device_running <= ~device_running;
end
reg [17:0] pulse_counter = 18'd0;
wire       hundredth_of_second_passed = ( pulse_counter == PULSE_MAX );
always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) pulse_counter <= 0;
  else 
    if ( device_running | hundredth_of_second_passed )
      if ( hundredth_of_second_passed ) pulse_counter <= 0;
      else pulse_counter <= pulse_counter + 1;
end
reg [3:0] hundredths_counter     = 4'd0;
wire      tenth_of_second_passed = ( ( hundredths_counter == COUNTER_MAX ) & hundredth_of_second_passed );
always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) hundredths_counter <= 0;
  else if ( hundredth_of_second_passed )
         if ( tenth_of_second_passed ) hundredths_counter <= 0;
       else hundredths_counter <= hundredths_counter + 1;
end
reg [3:0] tenths_counter = 4'd0;
wire      second_passed  = ( ( tenths_counter == COUNTER_MAX ) & tenth_of_second_passed );

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) tenths_counter <= 0;
  else if ( tenth_of_second_passed )
         if ( second_passed ) tenths_counter <= 0;
       else tenths_counter <= tenths_counter + 1;
end

reg  [3:0] seconds_counter    = 4'd0;
wire       ten_seconds_passed = ( ( seconds_counter == COUNTER_MAX ) & second_passed );
always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) seconds_counter <= 0;
  else if ( second_passed )
         if ( ten_seconds_passed ) seconds_counter <= 0;
       else seconds_counter <= seconds_counter + 1;
end

reg [3:0] ten_seconds_counter = 4'd0;
always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) ten_seconds_counter <= 0;
  else if ( ten_seconds_passed )
          if ( ten_seconds_counter == COUNTER_MAX ) ten_seconds_counter <= 0;
       else ten_seconds_counter <= ten_seconds_counter + 1;
end
always @(*) 
   begin
     case ( state )
       STATE_DEFAULT : if ( ( !device_running ) & ( btn_set_was_pressed ) ) begin
                         next_state = STATE_1;
                       end
                       else begin
                         next_state = STATE_DEFAULT;
                       end

       STATE_1 :       if ( btn_set_was_pressed ) begin
                         next_state = STATE_2;
                       end
                       else 
                         if ( btn_change_was_pressed ) begin
                           if ( hundredths_counter == COUNTER_MAX ) begin
                             hundredths_counter = 0;
                           end
                           else begin
                            hundredths_counter  = hundredths_counter + 1;
                            next_state          = STATE_1;
                           end
                         end
                         else begin
                           next_state = STATE_1;
                         end

       STATE_2 :       if ( btn_set_was_pressed ) begin
                         next_state = STATE_3;
                       end
                       else 
                         if ( btn_change_was_pressed ) begin
                           if ( tenths_counter == COUNTER_MAX ) begin
                             tenths_counter = 0;
                           end
                           else begin
                            tenths_counter = tenths_counter + 1;
                            next_state     = STATE_2;
                           end
                         end
                         else begin
                           next_state = STATE_2;
                         end

       STATE_3 :       if ( btn_set_was_pressed ) begin
                         next_state = STATE_4;
                       end
                       else 
                         if ( btn_change_was_pressed ) begin
                           if ( seconds_counter == COUNTER_MAX ) begin
                             seconds_counter      = 0;
                           end
                           else begin
                             seconds_counter      = seconds_counter + 1;
                             next_state           = STATE_3;
                           end
                         end
                         else begin
                           next_state  = STATE_3;
                         end

       STATE_4 :       if ( btn_set_was_pressed ) begin
                         next_state = STATE_DEFAULT;
                       end
                       else 
                         if ( btn_change_was_pressed ) begin
                           if ( ten_seconds_counter == COUNTER_MAX ) begin
                             ten_seconds_counter  = 0;
                           end
                           else begin
                             ten_seconds_counter = seconds_counter + 1;
                             ten_seconds_counter = STATE_4;
                           end
                         end
                         else begin
                           next_state = STATE_4;
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
reg [6:0] decoder_ten_seconds;
always @( * ) begin
  case ( ten_seconds_counter )      
    4'd0    : decoder_ten_seconds = 7'b100_0000;
    4'd1    : decoder_ten_seconds = 7'b111_1001;
    4'd2    : decoder_ten_seconds = 7'b010_0100;
    4'd3    : decoder_ten_seconds = 7'b011_0000;
    4'd4    : decoder_ten_seconds = 7'b001_1001;
    4'd5    : decoder_ten_seconds = 7'b001_0010;
    4'd6    : decoder_ten_seconds = 7'b000_0010;
    4'd7    : decoder_ten_seconds = 7'b111_1000;
    4'd8    : decoder_ten_seconds = 7'b000_0000;
    4'd9    : decoder_ten_seconds = 7'b001_0000;
    default : decoder_ten_seconds = 7'b000_0000;
  endcase
end
assign hex3_o = decoder_ten_seconds;


reg [6:0] decoder_seconds;
always @( * ) begin
  case ( seconds_counter )      
    4'd0    : decoder_seconds = 7'b100_0000;
    4'd1    : decoder_seconds = 7'b111_1001;
    4'd2    : decoder_seconds = 7'b010_0100;
    4'd3    : decoder_seconds = 7'b011_0000;
    4'd4    : decoder_seconds = 7'b001_1001;
    4'd5    : decoder_seconds = 7'b001_0010;
    4'd6    : decoder_seconds = 7'b000_0010;
    4'd7    : decoder_seconds = 7'b111_1000;
    4'd8    : decoder_seconds = 7'b000_0000;
    4'd9    : decoder_seconds = 7'b001_0000;
    default : decoder_seconds = 7'b000_0000;
  endcase
end
assign hex2_o = decoder_seconds;


reg [6:0] decoder_tenths;
always @( * ) begin
  case ( tenths_counter )      
    4'd0    : decoder_tenths = 7'b100_0000;
    4'd1    : decoder_tenths = 7'b111_1001;
    4'd2    : decoder_tenths = 7'b010_0100;
    4'd3    : decoder_tenths = 7'b011_0000;
    4'd4    : decoder_tenths = 7'b001_1001;
    4'd5    : decoder_tenths = 7'b001_0010;
    4'd6    : decoder_tenths = 7'b000_0010;
    4'd7    : decoder_tenths = 7'b111_1000;
    4'd8    : decoder_tenths = 7'b000_0000;
    4'd9    : decoder_tenths = 7'b001_0000;
    default : decoder_tenths = 7'b000_0000;
  endcase
end
assign hex1_o = decoder_tenths;


reg [6:0] decoder_hundredths;
always @( * ) begin
  case ( hundredths_counter )      
    4'd0    : decoder_hundredths = 7'b100_0000;
    4'd1    : decoder_hundredths = 7'b111_1001;
    4'd2    : decoder_hundredths = 7'b010_0100;
    4'd3    : decoder_hundredths = 7'b011_0000;
    4'd4    : decoder_hundredths = 7'b001_1001;
    4'd5    : decoder_hundredths = 7'b001_0010;
    4'd6    : decoder_hundredths = 7'b000_0010;
    4'd7    : decoder_hundredths = 7'b111_1000;
    4'd8    : decoder_hundredths = 7'b000_0000;
    4'd9    : decoder_hundredths = 7'b001_0000;
    default : decoder_hundredths = 7'b000_0000;
  endcase
end
assign hex0_o = decoder_hundredths;
endmodule
