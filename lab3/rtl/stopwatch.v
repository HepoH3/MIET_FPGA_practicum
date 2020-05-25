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

localparam IDLE        = 3'd0;
localparam CHANGING_H  = 3'd1;
localparam CHANGING_TS = 3'd2;
localparam CHANGING_S  = 3'd3;
localparam CHANGING_T  = 3'd4;

wire       start_stop_pressed;
wire       change_pressed;
wire       set_pressed;
wire [2:0] fsm_state;
wire       increment;
wire [3:0] cnt;

reg        device_running;

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    device_running = 1'b0;
  else
    begin
    if( start_stop_pressed & device_running )
      device_running = 1'b0;
    else
      if( start_stop_pressed & !device_running & cnt == 0 )
        device_running = 1'b1;
    end
end

reg  [18:0] pulse_counter;
wire        hundredth_of_second_passed;

assign hundredth_of_second_passed = ( pulse_counter == 19'd49999 );

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    pulse_counter <= 19'd0;
  else
    if( device_running | hundredth_of_second_passed )
      if( hundredth_of_second_passed )
        pulse_counter <= 19'd0;
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
    if( hundredth_of_second_passed )
      if( tens_of_second_passed )
        hundredths_counter <= 4'd0;
      else
        hundredths_counter <= hundredths_counter + 1;
    else
      if( fsm_state == CHANGING_H & increment )
        if( hundredths_counter == 4'd9 )
          hundredths_counter <= 4'd0;
        else
          hundredths_counter <= hundredths_counter + 1;
end

reg [3:0] tenths_counter;
wire      second_passed;

assign second_passed = ( ( tenths_counter == 4'd9 ) & tens_of_second_passed );

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    tenths_counter <= 4'd0;
  else
    if( tens_of_second_passed )
      if( second_passed )
        tenths_counter <= 4'd0;
      else
        tenths_counter <= tenths_counter + 1;
    else
      if( fsm_state == CHANGING_TS & increment )
        if( tenths_counter == 4'd9 )
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
    if( second_passed )
      if( ten_seconds_passed )
        seconds_counter <= 4'd0;
      else
        seconds_counter <= seconds_counter + 1;
    else
      if( fsm_state == CHANGING_S & increment )
        if( seconds_counter == 4'd9 )
          seconds_counter <= 4'd0;
        else
          seconds_counter <= seconds_counter + 1;
end

reg [3:0] ten_seconds_counter;

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    ten_seconds_counter <= 4'd0;
  else
    if( ten_seconds_passed )
      if( ten_seconds_counter == 4'd9 )
        ten_seconds_counter <= 4'd0;
      else
        ten_seconds_counter <= ten_seconds_counter + 1;
    else
      if( fsm_state == CHANGING_T & increment )
        if( ten_seconds_counter == 4'd9 )
          ten_seconds_counter <= 4'd0;
        else
          ten_seconds_counter <= ten_seconds_counter + 1;
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

finstate automate(
  .clk_i        ( clk100_i           ),
  .rstn_i       ( rstn_i             ),
  .dev_run_i    ( device_running     ),
  .set_i        ( set_pressed        ),
  .start_i      ( start_stop_pressed ),
  .change_i     ( change_pressed     ),
  .state_value_o( fsm_state          ),
  .inc_this_o   ( increment          ),
  .cnt          ( cnt                )
);

endmodule