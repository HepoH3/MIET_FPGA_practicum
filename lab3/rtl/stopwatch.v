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

reg [2:0]  start_stop_sync;
reg [13:0] pulse_counter;
reg        device_state;

localparam PULS_MAX         = 10'd999; 
localparam NUMBER_00_01_MAX = 4'd9;
localparam NUMBER_00_10_MAX = 4'd9;
localparam NUMBER_01_00_MAX = 4'd9;
localparam NUMBER_10_00_MAX = 4'd9;

wire       start_stop_pressed;
wire       pulse_counter_passed = ( pulse_counter == PULS_MAX );

assign     start_stop_pressed = ~start_stop_sync[2] & start_stop_sync[1];

always @( posedge clk100_i ) 
  begin
    start_stop_sync[0] <= !start_stop_i;
    start_stop_sync[1] <= start_stop_sync[0];
    start_stop_sync[2] <= start_stop_sync[1];
  end

always @( posedge clk100_i )
  begin
    start_stop_pressed & (( state == STATE_DEFAULT ) | (state == STOPWATCH_MODE )) ? device_state = ~device_state;

    device_state ? pulse_counter <= pulse_counter + 1;

    !device_state | pulse_counter_passed ? pulse_counter <= 0;

always @( posedge rstn_i )
  begin
    if ( !rstn_i ) begin
      pulse_counter <= 0;
      device_state <= 0;
      number_00_01 <= 0;
      number_00_10 <= 0;
      number_01_00 <= 0;
      number_10_00 <= 0;
    end

reg [3:0] number_00_01 = 4'd0; 
wire      number_00_01_passed = ( ( number_00_01 == NUMBER_00_01_MAX ) & pulse_counter_passed );

always @( posedge clk100_i )
  begin
    if ( pulse_counter_passed )
      if ( number_00_01_passed )
        number_00_01 <= 0;
      else
        number_00_01 <= number_00_01 + 1;
  end


reg [3:0] number_00_10 = 4'd0; 
wire      number_00_10_passed = ( ( number_00_10 == NUMBER_00_10_MAX ) & number_00_01_passed );

always @( posedge clk100_i )
  begin
    if ( number_00_01_passed )
      if ( number_00_10_passed )
        number_00_10 <= 0;
      else
        number_00_10 <= number_00_10 + 1;
  end

reg [3:0] number_01_00 = 4'd0; 
wire      number_01_00_passed = ( ( number_01_00 == NUMBER_01_00_MAX ) & number_00_10_passed );

always @( posedge clk100_i )
  begin
    if ( number_00_10_passed )
      if ( number_01_00_passed )
        number_01_00 <= 0;
      else
        number_01_00 <= number_01_00 + 1;
  end

reg [3:0] number_10_00 = 4'd0; 
wire      number_10_00_passed = ( number_10_00 == NUMBER_10_00_MAX );

always @( posedge clk100_i )
  begin
    if ( number_01_00_passed )
      if ( number_10_00_passed )
        number_10_00 <= 0;
      else
        number_10_00 <= number_10_00 + 1;
  end

hex hex3
  (
    .hex_i ( number_10_00 ),
    .hex_o ( hex3_o       )
  );

hex hex2
  (
    .hex_i ( number_01_00 ),
    .hex_o ( hex2_o       )
  );
  
hex hex1
  (
    .hex_i ( number_00_10 ),
    .hex_o ( hex1_o       )
  );

hex hex0
  (
    .hex_i ( number_00_01 ),
    .hex_o ( hex0_o       )
  );


reg [2:0] state;
reg [2:0] next_state;
reg [2:0] set_syncroniser;
reg [2:0] change_syncroniser;

localparam STATE_DEFAULT  = 3'd0;
localparam STATE_1        = 3'd1;
localparam STATE_2        = 3'd2;
localparam STATE_3        = 3'd3;
localparam STATE_4        = 3'd4;
localparam STOPWATCH_MODE = 3'd5;

wire set_pressed;
wire change_pressed;

assign set_pressed    = ~set_syncroniser[2] & set_syncroniser[1];
assign change_pressed = ~change_syncroniser[2] & change_syncroniser[1];

always @( posedge clk100_i ) 
  begin
    set_syncroniser[0] <= !set_i;
    set_syncroniser[1] <= set_syncroniser[0];
    set_syncroniser[2] <= set_syncroniser[1];
  end
  
always @( posedge clk100_i )  
  begin
    change_syncroniser[0] <= !change_i;
    change_syncroniser[1] <= change_syncroniser[0];
    change_syncroniser[2] <= change_syncroniser[1];

  end

always @( posedge clk100 ) begin
  if ( set_pressed & device_state ) begin
    pulse_counter <= 0;
    device_state <= 0;
    number_00_01 <= 0;
    number_00_10 <= 0;
    number_01_00 <= 0;
    number_10_00 <= 0;
  end    
end

always @( posedge clk100_i or posedge rstn_i ) begin
  state <= next_state;
end

always @( * ) begin 
  case ( state )
    STATE_DEFAULT : if ( set_pressed ) next_state <= STATE_1;
                    else if ( start_stop_pressed ) begin
                      next_state <= STOPWATCH_MODE;
                    end
                    else next_state <= STATE_DEFAULT;

    STATE_1 :       if ( set_pressed ) next_state <= STATE_2;
                    else if ( change_pressed ) begin
                      if ( number_00_01 != 4'd9 ) number_00_01 = number_00_01 + 1;
                      else number_00_01 = 0;
                      next_state <= STATE_1;
                    end
                    else next_state <= STATE_1;
    
    STATE_2 :       if ( set_pressed ) next_state <= STATE_3;
                    else if ( change_pressed ) begin
                      if ( number_00_10 != 4'd9 ) number_00_10 = number_00_10 + 1;
                      else number_00_10 = 0;
                      next_state <= STATE_2;
                    end
                    else next_state <= STATE_2;
    
    STATE_3 :       if ( set_pressed ) next_state <= STATE_4;
                    else if ( change_pressed ) begin
                      if ( number_01_00 != 4'd9 ) number_01_00 = number_01_00 + 1;
                      else number_01_00 = 0;
                      next_state <= STATE_3;
                    end
                    else next_state <= STATE_3;
          
    STATE_4 :       if ( set_pressed ) next_state <= STATE_DEFAULT;
                    else if ( change_pressed ) begin
                      if ( number_10_00 != 4'd9 ) number_10_00 = number_10_00 + 1;
                      else number_10_00 = 0;
                      next_state <= STATE_4;
                    end
                    else next_state <= STATE_4;
              
    STOPWATCH_MODE : if ( start_stop_pressed ) next_state <= STATE_DEFAULT;
                     else next_state <= STOPWATCH_MODE;
                 
    default : next_state <= STATE_DEFAULT;
  endcase
end

endmodule