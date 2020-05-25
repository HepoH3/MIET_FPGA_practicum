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


reg  [2:0] button_sync1;
wire      start_stop_was_pressed;

always @(posedge clk100_i or posedge rstn_i ) begin
  if ( rstn_i )
    button_sync1 <= 3'd0;
  else begin
  button_sync1[0] <= start_stop_i;
  button_sync1[1] <= button_sync1[0];
  button_sync1[2] <= button_sync1[1];
  end
end

assign start_stop_was_pressed = ~button_sync1[2] & button_sync1[1];


reg  [2:0] button_sync2;
wire      set_was_pressed;

always @(posedge clk100_i ) begin
  button_sync2[0] <= set_i;
  button_sync2[1] <= button_sync2[0];
  button_sync2[2] <= button_sync2[1];
end

assign set_was_pressed = ~button_sync2[2] & button_sync2[1];


reg  [2:0] button_sync3;
wire      change_was_pressed;

always @(posedge clk100_i ) begin
  button_sync3[0] <= change_i;
  button_sync3[1] <= button_sync3[0];
  button_sync3[2] <= button_sync3[1];
end

assign change_was_pressed = ~button_sync3[2] & button_sync3[1];


//
reg device_running;

always @( posedge clk100_i or posedge rstn_i ) begin
  if ( rstn_i )
    device_running <= 0;
  else if ( start_stop_was_pressed & ( state == IDLE ) )
    device_running <= ~device_running;
end

assign device_stopped = ~ ( device_running) ; // do we needed in device_stopped?


localparam  IDLE      = 4'd0;
localparam  NO_IDLE_0 = 4'd1;
localparam  NO_IDLE_1 = 4'd2;
localparam  NO_IDLE_2 = 4'd3;
localparam  NO_IDLE_3 = 4'd4;

reg   [2:0]  state, next_state;
reg   [4:0]  ten_seconds_max, seconds_max, tenths_max, hundredths_max;

always @ ( posedge clk100_i or posedge rstn_i ) begin
  if (rstn_i) begin
    state <= IDLE;
    hundredths_max  <= 9;  // parametrization of limit of stopwatch
    tenths_max      <= 9;
    seconds_max     <= 9;
    ten_seconds_max <= 9;
    end
  else state <= next_state;
end

// Finite-state machine for stopwatch
always @ ( * ) begin
  case(state)
    IDLE:     if ( set_was_pressed )  next_state <= NO_IDLE_0;
              else                    next_state <= IDLE;

    NO_IDLE_0:  if( set_was_pressed ) next_state <= NO_IDLE_1;
                else if ( change_was_pressed ) begin
                    if ( hundredths_max  == 9 ) hundredths_max <= 0;
                    else hundredths_max = hundredths_max + 1; // parametrization of limit of stopwatch
                    next_state <= NO_IDLE_0;
                  end
                else     next_state <= NO_IDLE_0;

    NO_IDLE_1:  if( set_was_pressed ) next_state <= NO_IDLE_2;
                else if ( change_was_pressed ) begin
                    if (tenths_max  == 9) tenths_max <= 0;
                    else tenths_max = tenths_max + 1;
                    next_state <= NO_IDLE_1;
                  end
                else     next_state <= NO_IDLE_1;

    NO_IDLE_2:  if( set_was_pressed ) next_state <= NO_IDLE_3;
                else if ( change_was_pressed ) begin
                    if (seconds_max  == 9) seconds_max <= 0;
                    else seconds_max = seconds_max + 1;
                    next_state <= NO_IDLE_2;
                  end
                else     next_state <= NO_IDLE_2;

    NO_IDLE_3:  if( set_was_pressed ) next_state <= IDLE;
                else if ( change_was_pressed ) begin
                    if (ten_seconds_max  == 9) ten_seconds_max <= 0;
                    else ten_seconds_max = ten_seconds_max + 1;
                    next_state <= NO_IDLE_3;
                  end
                else     next_state <= NO_IDLE_3;
    endcase
end



//impulse counter etc
reg   [19:0] pulse_counter              = 20'd0;
wire         hundredth_of_second_passed = (pulse_counter == 20'd999999);

always @ ( posedge clk100_i or posedge rstn_i ) begin
  if ( rstn_i ) pulse_counter <= 0;
  else if ( ( (device_running) | hundredth_of_second_passed ) & ( state == IDLE ) ) begin// i wroughte here state == IDLE coz counter should work only in IDLE position
    if ( hundredth_of_second_passed ) pulse_counter <= 0;
    else pulse_counter <= pulse_counter + 1;
  end
end


reg [3:0] hundredths_counter     = 4'd0;
wire      tenth_of_second_passed = ( (hundredths_counter == hundredths_max ) & hundredth_of_second_passed);

always @(posedge clk100_i or posedge rstn_i) begin
  if (rstn_i) hundredths_counter <= 0;
  else if (hundredth_of_second_passed)
    if (tenth_of_second_passed) hundredths_counter <= 0;
    else hundredths_counter <= hundredths_counter + 1;
end

reg [3:0] tenths_counter = 4'd0;
wire      second_passed  = ( (tenths_counter == tenths_max ) & tenth_of_second_passed);

always @(posedge clk100_i or posedge rstn_i) begin
  if (rstn_i) tenths_counter <= 0;
  else if (tenth_of_second_passed)
    if (second_passed) tenths_counter <= 0;
    else tenths_counter <= tenths_counter + 1;
end

reg [3:0] seconds_counter    = 4'd0;
wire      ten_seconds_passed = ( (seconds_counter == seconds_max ) & second_passed) ;

always @(posedge clk100_i or posedge rstn_i) begin
  if (rstn_i) seconds_counter <= 0;
  else if (second_passed)
    if (ten_seconds_passed) seconds_counter <= 0;
    else seconds_counter <= seconds_counter + 1;
end

reg [3:0] ten_seconds_counter = 4'd0;


always @(posedge clk100_i or posedge rstn_i) begin
  if (rstn_i) ten_seconds_counter <= 0;
  else if (ten_seconds_passed)
    if (ten_seconds_counter == ten_seconds_max ) ten_seconds_counter <= 0;
    else ten_seconds_counter <= ten_seconds_counter + 1;
end


reg [6:0] decoder_ten_seconds;
always @( * ) begin
 case (ten_seconds_counter)
   4'd0: decoder_ten_seconds <= 7'b0000001;
   4'd1: decoder_ten_seconds <= 7'b1001111;
   4'd2: decoder_ten_seconds <= 7'b0010010;
   4'd3: decoder_ten_seconds <= 7'b0000110;
   4'd4: decoder_ten_seconds <= 7'b1001100;
   4'd5: decoder_ten_seconds <= 7'b0100100;
   4'd6: decoder_ten_seconds <= 7'b0100000;
   4'd7: decoder_ten_seconds <= 7'b0001111;
   4'd8: decoder_ten_seconds <= 7'b0000000;
   4'd9: decoder_ten_seconds <= 7'b0000100;
   default: decoder_ten_seconds <= 7'b1111111;
 endcase;
end
assign hex3_o = decoder_ten_seconds;

reg [6:0] decoder_seconds;
always @(*) begin
  case (seconds_counter)
  4'd0: decoder_seconds <= 7'b0000001;
  4'd1: decoder_seconds <= 7'b1001111;
  4'd2: decoder_seconds <= 7'b0010010;
  4'd3: decoder_seconds <= 7'b0000110;
  4'd4: decoder_seconds <= 7'b1001100;
  4'd5: decoder_seconds <= 7'b0100100;
  4'd6: decoder_seconds <= 7'b0100000;
  4'd7: decoder_seconds <= 7'b0001111;
  4'd8: decoder_seconds <= 7'b0000000;
  4'd9: decoder_seconds <= 7'b0000100;
  default: decoder_seconds <= 7'b1111111;
  endcase;
end
assign hex2_o = decoder_seconds;

reg [6:0] decoder_tenths;
always @(*) begin
  case (tenths_counter)
  4'd0: decoder_tenths <= 7'b0000000;
  4'd1: decoder_tenths <= 7'b1001111;
  4'd2: decoder_tenths <= 7'b0010010;
  4'd3: decoder_tenths <= 7'b0000110;
  4'd4: decoder_tenths <= 7'b1001100;
  4'd5: decoder_tenths <= 7'b0100100;
  4'd6: decoder_tenths <= 7'b0100000;
  4'd7: decoder_tenths <= 7'b0001111;
  4'd8: decoder_tenths <= 7'b0000000;
  4'd9: decoder_tenths <= 7'b0000100;
  default: decoder_tenths <= 7'b1111111;
  endcase;
end
assign hex1_o = decoder_tenths;

reg [6:0] decoder_hundredth;
always @(*) begin
  case (hundredths_counter)
  4'd0: decoder_hundredth <= 7'b0000000;
  4'd1: decoder_hundredth <= 7'b1001111;
  4'd2: decoder_hundredth <= 7'b0010010;
  4'd3: decoder_hundredth <= 7'b0000110;
  4'd4: decoder_hundredth <= 7'b1001100;
  4'd5: decoder_hundredth <= 7'b0100100;
  4'd6: decoder_hundredth <= 7'b0100000;
  4'd7: decoder_hundredth <= 7'b0001111;
  4'd8: decoder_hundredth <= 7'b0000000;
  4'd9: decoder_hundredth <= 7'b0000100;
  default: decoder_hundredth <= 7'b1111111;
  endcase;
end
assign hex0_o = decoder_tenths;




endmodule
