`timescale 1ns / 1ps

module stopwatch(
  input        clk100_i,
  input        rstn_i,
  input        start_stop_i,
  input        set_i,
  input        change_i,
  output [6:0] hex0_o, //индикатор сотых долей секунды
  output [6:0] hex1_o, //индикатор десытых долей секунды
  output [6:0] hex2_o, //индикатор секунд
  output [6:0] hex3_o  //индикатор десятков секунд
);

wire start_down;
wire change_down;
wire set_down;

button_deb bt0(
  .btn_i   ( !start_stop_i ),
  .ondn_o  ( start_down    ),
  .rst_i   ( rstn_i        ),
  .clk_i   ( clk100_i      )
);

button_deb bt1(
  .btn_i   ( !set_i   ),
  .ondn_o  ( set_down ),
  .rst_i   ( rstn_i   ),
  .clk_i   ( clk100_i )
);

button_deb bt3(
  .btn_i   ( !change_i   ),
  .ondn_o  ( change_down ),
  .rst_i   ( rstn_i      ),
  .clk_i   ( clk100_i    )
);

reg        device_run;
wire       device_stop;
reg  [3:0] cnt;

assign device_stop = ( device_run ) ? 1'b0 : 1'b1;

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    device_run = 1'b0;
  else
    begin
    if( start_down & device_run )
      device_run = 1'b0;
    else
      if( start_down & device_stop & cnt == 0)
        device_run = 1'b1;
    end
end

reg  [16:0] pulse_counter;
wire        hundredth_of_second_passed;

assign hundredth_of_second_passed = ( pulse_counter == 17'd259999 );

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    pulse_counter <= 17'd0;
  else
    if( device_run | hundredth_of_second_passed )
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
    if( !set_down & change_down & device_stop ) begin
      if( cnt == 1 & ( hundredths_counter < 4'd9 ) )
        hundredths_counter <= hundredths_counter + 1;
      else
        if( cnt == 1 )
          hundredths_counter <= 0;
    end
      else
        if( hundredth_of_second_passed )
          if( tens_of_second_passed )
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
    if( !set_down & change_down & device_stop ) begin
      if( cnt == 2 & tenths_counter < 4'd9 )
        tenths_counter <= tenths_counter + 1;
      else
        if( cnt == 2 )
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
    if( !set_down & change_down & device_stop ) begin
      if( cnt == 3 & seconds_counter < 4'd9 )
        seconds_counter <= seconds_counter + 1;
      else
        if( cnt == 3 )
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
    if( !set_down & change_down & device_stop ) begin
      if( cnt == 4 & ten_seconds_counter < 4'd9 )
        ten_seconds_counter <= ten_seconds_counter + 1;
      else
        if( cnt == 4 )
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
    cnt <= 4'd0;
  end
  else
    if( device_stop ) begin
      if( !start_down & set_down & cnt < 4 )
        cnt <= cnt + 1;
      else
        if( set_down & cnt == 4 )
          cnt <= 4'd0;
    end
end

reg [6:0] decoder_ten_seconds;
always @(*) begin
  case (ten_seconds_counter)
    4'd0:    decoder_ten_seconds <= 7'b0000001;
    4'd1:    decoder_ten_seconds <= 7'b1001111;
    4'd2:    decoder_ten_seconds <= 7'b0010010;
    4'd3:    decoder_ten_seconds <= 7'b0000110;
    4'd4:    decoder_ten_seconds <= 7'b1001100;
    4'd5:    decoder_ten_seconds <= 7'b0100100;
    4'd6:    decoder_ten_seconds <= 7'b0100001;
    4'd7:    decoder_ten_seconds <= 7'b0001111;
    4'd8:    decoder_ten_seconds <= 7'b0000000;
    4'd9:    decoder_ten_seconds <= 7'b0000100;
    default: decoder_ten_seconds <= 7'b1111111;
  endcase;
end
assign hex3_o = decoder_ten_seconds;

reg [6:0] decoder_seconds;
always @(*) begin
  case (seconds_counter)
    4'd0:    decoder_seconds <= 7'b0000001;
    4'd1:    decoder_seconds <= 7'b1001111;
    4'd2:    decoder_seconds <= 7'b0010010;
    4'd3:    decoder_seconds <= 7'b0000110;
    4'd4:    decoder_seconds <= 7'b1001100;
    4'd5:    decoder_seconds <= 7'b0100100;
    4'd6:    decoder_seconds <= 7'b0100001;
    4'd7:    decoder_seconds <= 7'b0001111;
    4'd8:    decoder_seconds <= 7'b0000000;
    4'd9:    decoder_seconds <= 7'b0000100;
    default: decoder_seconds <= 7'b1111111;
  endcase;
end
assign hex2_o = decoder_seconds;

reg [6:0] decoder_tenth;
always @(*) begin
  case (tenths_counter)
    4'd0:    decoder_tenth <= 7'b0000001;
    4'd1:    decoder_tenth <= 7'b1001111;
    4'd2:    decoder_tenth <= 7'b0010010;
    4'd3:    decoder_tenth <= 7'b0000110;
    4'd4:    decoder_tenth <= 7'b1001100;
    4'd5:    decoder_tenth <= 7'b0100100;
    4'd6:    decoder_tenth <= 7'b0100001;
    4'd7:    decoder_tenth <= 7'b0001111;
    4'd8:    decoder_tenth <= 7'b0000000;
    4'd9:    decoder_tenth <= 7'b0000100;
    default: decoder_tenth <= 7'b1111111;
  endcase;
end
assign hex1_o = decoder_tenth;

reg [6:0] decoder_hundredth;
always @(*) begin
  case (hundredths_counter)
    4'd0:    decoder_hundredth <= 7'b0000001;
    4'd1:    decoder_hundredth <= 7'b1001111;
    4'd2:    decoder_hundredth <= 7'b0010010;
    4'd3:    decoder_hundredth <= 7'b0000110;
    4'd4:    decoder_hundredth <= 7'b1001100;
    4'd5:    decoder_hundredth <= 7'b0100100;
    4'd6:    decoder_hundredth <= 7'b0100001;
    4'd7:    decoder_hundredth <= 7'b0001111;
    4'd8:    decoder_hundredth <= 7'b0000000;
    4'd9:    decoder_hundredth <= 7'b0000100;
    default: decoder_hundredth <= 7'b1111111;
  endcase;
end
assign hex0_o = decoder_hundredth;


    
endmodule