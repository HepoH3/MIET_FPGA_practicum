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


wire      start_stop_was_pressed;
button_pullup btn_str_stp(
  .button_i     ( start_stop_i            ),
  .button_o     ( start_stop_was_pressed  ),
  .rstn_i       ( rstn_i                  ),
  .clk100_i     ( clk100_i                )
);

wire      set_was_pressed;
button_pullup btn_set(
  .button_i     ( set_i              ),
  .button_o     ( set_was_pressed    ),
  .rstn_i       ( rstn_i             ),
  .clk100_i     ( clk100_i           )
);

wire      change_was_pressed;
button_pullup btn_change(
  .button_i     ( change_i                ),
  .button_o     ( change_was_pressed      ),
  .rstn_i       ( rstn_i                  ),
  .clk100_i     ( clk100_i                )
);



reg   [2:0]  state, next_state;
reg   [4:0]  ten_seconds_max, seconds_max, tenths_max, hundredths_max;


localparam  IDLE      = 4'd0;
localparam  NO_IDLE_0 = 4'd1;
localparam  NO_IDLE_1 = 4'd2;
localparam  NO_IDLE_2 = 4'd3;
localparam  NO_IDLE_3 = 4'd4;




// qeq device_running DIY
reg device_running;

always @( posedge clk100_i or posedge rstn_i ) begin
  if ( rstn_i )
    device_running <= 0;
  else if ( start_stop_was_pressed & ( state == IDLE ) )
    device_running <= ~device_running;
end

assign device_stopped = ~ ( device_running) ;
//qeq 




always @ ( posedge clk100_i or posedge rstn_i ) begin
  if (rstn_i) begin
    state <= IDLE;
    hundredths_max  <= 1;
    tenths_max      <= 4;
    seconds_max     <= 8;
    ten_seconds_max <= 8;
    end
  else state <= next_state;
end


always @ ( * ) begin
  case(state)
    IDLE:     if ( set_was_pressed )  next_state <= NO_IDLE_0;
              else                    next_state <= IDLE;

    NO_IDLE_0:  if( set_was_pressed ) next_state <= NO_IDLE_1;
                else if ( change_was_pressed ) begin
                    if ( hundredths_max  == 9 ) hundredths_max <= 0;
                    else hundredths_max = hundredths_max + 1;
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











//impulse counter
reg   [19:0] pulse_counter              = 20'd0;
wire         hundredth_of_second_passed = (pulse_counter == 20'd999999);

always @ ( posedge clk100_i or posedge rstn_i ) begin
  if ( rstn_i ) pulse_counter <= 0;
  else if ( ( (device_running) | hundredth_of_second_passed ) & ( state == IDLE ) ) begin// device_stopped
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


hex hex3 (
  .counter_i  ( ten_seconds_counter ),
  .hex_o      ( hex3_o              )
  );

hex hex2 (
  .counter_i  ( seconds_counter     ),
  .hex_o       ( hex2_o              )
  );

hex hex1 (
  .counter_i  ( tenths_counter      ),
  .hex_o      ( hex1_o              )
  );  

hex hex0 (
  .counter_i  ( hundredths_counter  ),
  .hex_o       ( hex0_o              )
  );


endmodule
