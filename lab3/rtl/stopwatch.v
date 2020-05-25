
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


localparam  STOPWATCH_DEFAULT   = 1'd0;
localparam  STOPWATCH_SET       = 1'd1;
localparam  COUNTER_MAX         = 4'd9;

reg         device_running      = 1'b0;
reg         state_stopwatch     = STOPWATCH_DEFAULT;
reg         next_state_stopwatch;
reg  [1:0]  current_hex         = 2'b0;
reg  [3:0]  hundredths_counter  = 4'd0;
reg  [3:0]  tenths_counter      = 4'd0;
reg  [3:0]  seconds_counter     = 4'd0;
reg  [3:0]  ten_seconds_counter = 4'd0;
wire        device_stopped;


//Start-stop button synch
reg  [1:0] btn_start_sync;
wire       btn_start_was_pressed;

always @( posedge clk100_i )
begin
  btn_start_sync[0] <= ~start_stop_i;
  btn_start_sync[1] <= btn_start_sync[0];
end
assign btn_start_was_pressed = ~btn_start_sync[1] & btn_start_sync[0];

// SET button synch
reg  [1:0] btn_set_sync;
wire       btn_set_was_pressed;

always @( posedge clk100_i )
begin
  btn_set_sync[0] <= ~set_i;
  btn_set_sync[1] <= btn_set_sync[0];
end
assign btn_set_was_pressed = ~btn_set_sync[1] & btn_set_sync[0];


//Change butthon sync
reg  [1:0] btn_change_sync;
wire       btn_change_was_pressed;

always @( posedge clk100_i )
begin
  btn_change_sync[0] <= ~change_i;
  btn_change_sync[1] <= btn_change_sync[0];
end
assign btn_change_was_pressed = ~btn_change_sync[1] & btn_change_sync[0];



//Running device

always @( posedge clk100_i )
begin
  if ( btn_start_was_pressed && state_stopwatch == STOPWATCH_DEFAULT ) 
    device_running <= ~device_running;
end
assign device_stopped = ~device_running;

// State machine
always @( * ) 
begin
  case ( state_stopwatch )
    STOPWATCH_DEFAULT : if ( btn_set_was_pressed && ~device_running )
                          next_state_stopwatch = STOPWATCH_SET;
                        else
                          next_state_stopwatch = STOPWATCH_DEFAULT;
    STOPWATCH_SET     : if ( current_hex == 2'd3 && btn_set_was_pressed )
                          begin
                            next_state_stopwatch = STOPWATCH_DEFAULT;
                            current_hex = 2'b0;
                          end
                        else
                          next_state_stopwatch = STOPWATCH_SET;
  endcase
end

always @( posedge clk100_i or negedge rstn_i )
begin
  if( !rstn_i )  
    state_stopwatch <= STOPWATCH_DEFAULT;
  else
    state_stopwatch <= next_state_stopwatch;
end

//Setting numbers


always @( posedge clk100_i )
begin
  if ( state_stopwatch == STOPWATCH_SET ) 
  begin
    if ( btn_set_was_pressed ) 
      current_hex <= current_hex + 1;
    if ( btn_change_was_pressed )
    begin
       case (current_hex)
        2'd0  : hundredths_counter  <= hundredths_counter + 1;
        2'd1  : tenths_counter      <= tenths_counter + 1;
        2'd2  : seconds_counter     <= seconds_counter + 1;
        2'd3  : ten_seconds_counter <= ten_seconds_counter + 1;
      endcase
    end
  end
end


// Counter 
localparam PULSE_WIDTH = 20;
localparam PULSE_MAX = 20'd999999;

reg [PULSE_WIDTH - 1:0] pulse_counter = 20'd0;
wire                    hundredths_of_second_passed = ( pulse_counter == PULSE_MAX );

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) 
  begin
    pulse_counter       <= 0;
    hundredths_counter  <= 0;
    tenths_counter      <= 0;
    seconds_counter     <= 0;
    ten_seconds_counter <= 0;
    current_hex         <= 0;
  end
  else if ( device_running | hundredths_of_second_passed )
  begin
    if ( hundredths_of_second_passed )
      pulse_counter <= 0;
    else
      pulse_counter <= pulse_counter + 1;
  end
end


//00.01
wire  tenths_of_second_passed = 
        ( ( hundredths_counter == COUNTER_MAX ) & hundredths_of_second_passed );

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) 
    hundredths_counter <= 0;
  else if ( hundredths_of_second_passed ) 
  begin
    if ( tenths_of_second_passed )
      hundredths_counter <= 0;
    else
      hundredths_counter <= hundredths_counter + 1;
  end
end


// 00.10
wire  second_passed = 
        ( ( tenths_counter == COUNTER_MAX ) & tenths_of_second_passed );

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) 
    tenths_counter <= 0;

  else if ( tenths_of_second_passed ) 
  begin
    if ( second_passed )
      tenths_counter <= 0;
    else
      tenths_counter <= tenths_counter + 1;
  end
end

//01.00
wire  ten_seconds_passed = 
        ( ( seconds_counter == COUNTER_MAX ) & second_passed );

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) 
    seconds_counter <= 0;
  else if ( second_passed ) 
  begin
    if ( ten_seconds_passed )
      seconds_counter <= 0;
    else
      seconds_counter <= seconds_counter + 1;
  end
end


//10.00

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) 
    ten_seconds_counter <= 0;
  else if ( ten_seconds_passed ) 
  begin
    if ( ten_seconds_counter == 4'd9 )
      ten_seconds_counter <= 0;
    else
      ten_seconds_counter <= ten_seconds_counter + 1;
  end
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