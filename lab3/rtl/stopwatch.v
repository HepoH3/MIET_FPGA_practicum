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

wire start;
wire change;
wire set;

key_deb start_bt(
  .btn_i       ( !start_stop_i ),
  .btn_down_o  ( start         ),
  .rst_i       ( rstn_i        ),
  .clk_i       ( clk100_i      )
);

key_deb set_bt(
  .btn_i       ( !set_i   ),
  .btn_down_o  ( set      ),
  .rst_i       ( rstn_i   ),
  .clk_i       ( clk100_i )
);

key_deb change_bt(
  .btn_i      ( !change_i ),
  .btn_down_o ( change    ),
  .rst_i      ( rstn_i    ),
  .clk_i      ( clk100_i  )
);

reg  [3:0] q;
reg        device_run;
wire       device_stop;

assign device_stop = ( device_run ) ? 1'b0:
                                      1'b1;
 
always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    device_run = 1'b0;
  else begin
    if( start && device_run )
      device_run = 1'b0;
    else
      if( start && device_stop && q == 0)
        device_run = 1'b1;
  end
end

reg  [16:0] count;
wire        sto_secund;

assign sto_secund = ( count == 17'd25999 );

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    count <= 17'd0;
  else
    if( device_run || sto_secund )
      if( sto_secund )
        count <= 17'd0;
      else
        count <= count + 1;
end

reg  [3:0] count_100;
wire       tens_secund;

assign tens_secund = ( ( count_100 == 4'd9 ) & sto_secund );

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    count_100 <= 4'd0;
  else
    if( !set && change && device_stop ) begin
      if( q == 1 && count_100 < 4'd9 )
        count_100 <= count_100 + 1;
      else
        if( q == 1 )
          count_100 <= 0;
    end
      else
        if( sto_secund )
          if( tens_secund )
            count_100 <= 4'd0;
          else
            count_100 <= count_100 + 1;
end

reg [3:0] count_10;
wire      second_pas;

assign second_pas = ( ( count_10 == 4'd9 ) & tens_secund );

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    count_10 <= 4'd0;
  else
    if( !set && change && device_stop ) begin
      if( q == 2 && count_10 < 4'd9 )
        count_10 <= count_10 + 1;
      else
        if( q == 2 )
          count_10 <= 0;
    end
      else
        if( tens_secund )
          if( second_pas )
            count_10 <= 4'd0;
          else
            count_10 <= count_10 + 1;
end

reg  [3:0] secun_count;
wire       ten_sec_pas;

assign ten_sec_pas = ( ( secun_count == 4'd9 ) & second_pas );

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    secun_count <= 4'd0;
  else
    if( !set && change && device_stop ) begin
      if( q == 3 && secun_count < 4'd9 )
        secun_count <= secun_count + 1;
      else
        if( q == 3 )
          secun_count <= 0;
    end
      else
        if( second_pas )
          if( ten_sec_pas )
            secun_count <= 4'd0;
          else
            secun_count <= secun_count + 1;
end

reg [3:0] ten_sec_count;

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    ten_sec_count <= 4'd0;
  else
    if( !set && change && device_stop ) begin
      if( q == 4 && ten_sec_count < 4'd9 )
        ten_sec_count <= ten_sec_count + 1;
      else
        if( q == 4 )
          ten_sec_count <= 0;
    end
      else
        if( ten_sec_pas )
          if( ten_sec_count == 4'd9 )
            ten_sec_count <= 4'd0;
          else
            ten_sec_count <= ten_sec_count + 1;
end

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i ) begin
    q <= 4'd0;
  end
  else
    if( device_stop ) begin
      if( !start && set && q < 4 )
        q <= q + 1;
      else
        if( set && q == 4 )
          q <= 4'd0;
    end
end

dc_hex dec3(
  .in ( ten_sec_count ),
  .out( hex3_o              )
);

dc_hex dec2(
  .in ( secun_count ),
  .out( hex2_o      )
);

dc_hex dec1(
  .in ( count_10 ),
  .out( hex1_o   )
);

dc_hex dec0(
  .in ( count_100 ),
  .out( hex0_o    )
);
endmodule
