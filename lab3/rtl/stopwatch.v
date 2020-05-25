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

localparam HUNDREDTHS_MAX  = 4'd9;
localparam TENTHS_MAX      = 4'd9;
localparam SECONDS_MAX     = 4'd9;
localparam TEN_SECONDS_MAX = 4'd9;
localparam DEFAULT_STATE   = 3'd0;
localparam STATE_1         = 3'd1;
localparam STATE_2         = 3'd2;
localparam STATE_3         = 3'd3;
localparam STATE_4         = 3'd4;
localparam PULSE_MAX       = 18'd5;

reg [2:0] state;
reg [2:0] next_state; 

wire button_was_pressed;
btn_press deb(
  .clk100_i   ( clk100_i           ),
  .rstn_i     ( rstn_i             ),
  .en_i       ( start_stop_i       ),
  .en_down_o  ( button_was_pressed ) 
  );

wire button_set_was_pressed;
btn_press set(
  .clk100_i   ( clk100_i               ),
  .rstn_i     ( rstn_i                 ),
  .en_i       ( set_i                  ),
  .en_down_o  ( button_set_was_pressed ) 
  );

wire button_change_was_pressed;
btn_press change(
  .clk100_i   ( clk100_i                  ),
  .rstn_i     ( rstn_i                    ),
  .en_i       ( change_i                  ),
  .en_down_o  ( button_change_was_pressed ) 
  );

reg device_running;
always @( posedge clk100_i or posedge rstn_i ) begin
  if ( rstn_i ) begin
    device_running <= 1'b0;
  end
  else
  if ( button_was_pressed & state==DEFAULT_STATE ) begin
    device_running <= ~device_running;
  end
end

reg [17:0] pulse_counter = 18'd0;
wire hundredth_of_second_passed = ( pulse_counter == PULSE_MAX );
always @( posedge clk100_i or posedge rstn_i ) begin
  if ( !rstn_i ) pulse_counter <= 0;
  else if ( device_running | hundredth_of_second_passed )
    if ( hundredth_of_second_passed )
      pulse_counter <= 0;
    else pulse_counter <= pulse_counter + 1;
  end

reg [3:0] hundredths_counter = 4'd0;
wire tenth_of_second_passed = ( ( hundredths_counter == HUNDREDTHS_MAX ) & hundredth_of_second_passed );
always @( posedge clk100_i or posedge rstn_i ) begin
  if ( !rstn_i ) hundredths_counter <= 0;
  else if ( hundredth_of_second_passed )
    if ( tenth_of_second_passed )
      hundredths_counter <= 0;
    else hundredths_counter <= hundredths_counter + 1;
  end

reg [3:0] tenths_counter = 4'd0;
wire second_passed = ( ( tenths_counter == TENTHS_MAX ) & tenth_of_second_passed );
always @( posedge clk100_i or posedge rstn_i ) begin
  if ( !rstn_i ) tenths_counter <= 0;
  else if ( tenth_of_second_passed )
    if ( second_passed )
      tenths_counter <= 0;
    else tenths_counter <= tenths_counter + 1;
  end

reg [3:0] seconds_counter = 4'd0;
wire ten_seconds_passed = ( ( seconds_counter == SECONDS_MAX ) & second_passed );
always @( posedge clk100_i or posedge rstn_i ) begin
  if ( !rstn_i ) seconds_counter <= 0;
  else if ( second_passed )
    if ( ten_seconds_passed )
      seconds_counter <= 0;
    else seconds_counter <= seconds_counter + 1;
  end

reg [3:0] ten_seconds_counter = 4'd0;
always @( posedge clk100_i or posedge rstn_i ) begin
  if ( !rstn_i ) ten_seconds_counter <= 0;
  else if ( ten_seconds_passed )
    if ( ten_seconds_counter == TEN_SECONDS_MAX )
      ten_seconds_counter <= 0;
    else ten_seconds_counter <= ten_seconds_counter + 1;
  end

hex dec3(
  .in ( ten_seconds_counter ),
  .out( hex3_o              )
);

hex dec2(
  .in ( seconds_counter ),
  .out( hex2_o          )
);

hex dec1(
  .in ( tenths_counter ),
  .out( hex1_o         )
);

hex dec0(
  .in ( hundredths_counter ),
  .out( hex0_o             )
);

always @( * ) begin
  case ( state )
    DEFAULT_STATE: if ( ( !device_running ) && ( button_set_was_pressed ) )
                       next_state <= STATE_1;
                   else next_state <= DEFAULT_STATE; 

    STATE_1:       if ( button_set_was_pressed )
                      next_state = STATE_2;
                   else 
                     if ( button_change_was_pressed ) begin 
                       if ( hundredths_counter == HUNDREDTHS_MAX )
                         hundredths_counter = 4'd0;
                       else hundredths_counter = hundredths_counter + 1;
                       next_state = STATE_1;
                       end
                     else next_state = STATE_1;

    STATE_2:       if ( button_set_was_pressed )
                      next_state = STATE_3;
                   else 
                     if ( button_change_was_pressed ) begin 
                       if ( tenths_counter == TENTHS_MAX )
                         tenths_counter = 4'd0;
                       else tenths_counter = tenths_counter + 1;
                       next_state = STATE_2;
                       end
                     else next_state = STATE_2;

    STATE_3:       if ( button_set_was_pressed )
                      next_state = STATE_4;
                   else 
                     if ( button_change_was_pressed ) begin 
                       if ( seconds_counter == SECONDS_MAX )
                         seconds_counter = 4'd0;
                       else seconds_counter = seconds_counter + 1;
                       next_state = STATE_3;
                       end
                     else next_state = STATE_3;
    STATE_4:       if ( button_set_was_pressed )
                      next_state = DEFAULT_STATE;
                   else 
                     if ( button_change_was_pressed ) begin 
                       if ( ten_seconds_counter == TEN_SECONDS_MAX )
                         ten_seconds_counter = 4'd0;
                       else ten_seconds_counter = ten_seconds_counter + 1;
                       next_state = STATE_4;
                       end
                     else next_state = STATE_4;                                                                          
  endcase                 
end

always @( posedge clk100_i or posedge rstn_i )
  begin
   if ( rstn_i )
     state <= DEFAULT_STATE;
   else
     state <= next_state;
  end 

endmodule 