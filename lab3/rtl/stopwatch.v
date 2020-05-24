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

wire start_stop_pressed;
wire change_pressed;
wire set_pressed;
wire device_stopped;

reg       device_running;
reg [3:0] state;

assign device_stopped = ( device_running ) ? 1'b0 : 1'b1;

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    device_running = 1'b0;
  else
    begin
    if( start_stop_pressed & device_running )
      device_running = 1'b0;
    else
      if( start_stop_pressed & device_stopped & state == 0)
        device_running = 1'b1;
    end
end

reg  [16:0] pulse_counter;
wire        hundredth_of_second_passed;

assign hundredth_of_second_passed = ( pulse_counter == 17'd259999 );

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    pulse_counter <= 17'd0;
  else
    if( device_running | hundredth_of_second_passed )
      if( hundredth_of_second_passed )
        pulse_counter <= 17'd0;
      else
        pulse_counter <= pulse_counter + 1;
end

reg  [3:0] hundredths_counter;
wire       tens_of_second_passed;

assign tens_of_second_passed = ( ( hundredths_counter == 4'd9 ) & hundredth_of_second_passed );

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    hundredths_counter <= 4'd0;
  else
    if( !set_pressed & change_pressed & device_stopped ) begin
      if( state == 1 & ( hundredths_counter < 4'd9 ) )
        hundredths_counter <= hundredths_counter + 1;
      else
        if( state == 1 )
          hundredths_counter <= 0;
    end
      else
        if( hundredth_of_second_passed )
          if( tens_of_second_passed )
            hundredths_counter <= 4'd0;
          else
            hundredths_counter <= hundredths_counter + 1;
end

reg  [3:0] tenths_counter;
wire       second_passed;

assign second_passed = ( ( tenths_counter == 4'd9 ) & tens_of_second_passed );

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    tenths_counter <= 4'd0;
  else
    if( !set_pressed & change_pressed & device_stopped ) begin
      if( state == 2 & tenths_counter < 4'd9 )
        tenths_counter <= tenths_counter + 1;
      else
        if( state == 2 )
          tenths_counter <= 0;
    end
      else
        if( tens_of_second_passed )
          if( second_passed )
            tenths_counter <= 4'd0;
          else
            tenths_counter <= tenths_counter + 1;
end

reg  [3:0] seconds_counter;
wire       ten_seconds_passed;

assign ten_seconds_passed = ( ( seconds_counter == 4'd9 ) & second_passed );

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    seconds_counter <= 4'd0;
  else
    if( !set_pressed & change_pressed & device_stopped ) begin
      if( state == 3 & seconds_counter < 4'd9 )
        seconds_counter <= seconds_counter + 1;
      else
        if( state == 3 )
          seconds_counter <= 0;
    end
      else
        if( second_passed )
          if( ten_seconds_passed )
            seconds_counter <= 4'd0;
          else
            seconds_counter <= seconds_counter + 1;
end

reg [3:0] ten_seconds_counter;

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    ten_seconds_counter <= 4'd0;
  else
    if( !set_pressed & change_pressed & device_stopped ) begin
      if( state == 4 & ten_seconds_counter < 4'd9 )
        ten_seconds_counter <= ten_seconds_counter + 1;
      else
        if( state == 4 )
          ten_seconds_counter <= 0;
    end
      else
        if( ten_seconds_passed )
          if( ten_seconds_counter == 4'd9 )
            ten_seconds_counter <= 4'd0;
          else
            ten_seconds_counter <= ten_seconds_counter + 1;
end

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i ) begin
    state <= 4'd0;
  end
  else
    if( device_stopped ) begin
      if( !start_stop_pressed & set_pressed & state < 4 )
        state <= state + 1;
      else
        if( set_pressed & state == 4 )
          state <= 4'd0;
    end
end

dec_hex ten_sec(
  .in ( ten_seconds_counter ),
  .ex ( hex3_o              )
);

dec_hex sec(
  .in ( seconds_counter ),
  .ex ( hex2_o          )
);

dec_hex tenths(
  .in ( tenths_counter ),
  .ex ( hex1_o         )
);

dec_hex hundredths(
  .in ( hundredths_counter ),
  .ex ( hex0_o             )
);

debounce start(
  .btn_i   ( !start_stop_i      ),
  .btn_o   ( start_stop_pressed ),
  .rst_i   ( rstn_i             ),
  .clk_i   ( clk100_i           )
);

debounce set(
  .btn_i   ( !set_i      ),
  .btn_o   ( set_pressed ),
  .rst_i   ( rstn_i      ),
  .clk_i   ( clk100_i    )
);

debounce change(
  .btn_i   ( !change_i      ),
  .btn_o   ( change_pressed ),
  .rst_i   ( rstn_i         ),
  .clk_i   ( clk100_i       )
);

endmodule