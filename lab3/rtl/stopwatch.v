`timescale 1ns / 1ps

module stopwatch(
  input        clk100_i,
  input        rstn_i,
  input        start_stop_i,
  input        set_i,
  input        change_i,
  
  output [6:0] hex0_o, //��������� ����� ����� �������
  output [6:0] hex1_o, //������� ����� �������
  output [6:0] hex2_o, //������
  output [6:0] hex3_o  //�������� ������
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

    
 wire [6:0] decoder_ten_seconds;

  decoder d1(
    .in  ( ten_seconds_counter [3:0] ),
    .out ( decoder_ten_seconds [6:0] )
  );

assign hex3_o = decoder_ten_seconds;

wire [6:0] decoder_seconds;

  decoder d2(
    .in  ( seconds_counter [3:0] ),
    .out ( decoder_seconds [6:0] )
  );

assign hex2_o = decoder_seconds;

wire [6:0] decoder_tenths;

  decoder d3(
    .in  ( tenths_counter [3:0] ),
    .out ( decoder_tenths [6:0] )
  );

assign hex1_o = decoder_tenths;

wire [6:0] decoder_hundredths;

  decoder d4(
    .in  ( hundredths_counter [3:0] ),
    .out ( decoder_hundredths [6:0] )
  );

assign hex0_o = decoder_hundredths;

    
endmodule
