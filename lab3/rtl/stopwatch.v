`timescale 1ns / 1ps

module stopwatch #(
parameter PULSE_MAX = 20'd499999 )
(
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

localparam IDLE     = 3'd0;
localparam CHANGE_1 = 3'd1;
localparam CHANGE_2 = 3'd2;
localparam CHANGE_3 = 3'd3;
localparam CHANGE_4 = 3'd4;

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

wire [3:0] q;
wire [2:0] fsm;
wire       increment;

reg        device_run;
 
always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    device_run <= 1'b0;
  else begin
    if( start && device_run )
      device_run <= 1'b0;
    else
      if( start & !device_run & q == 0 )
        device_run <= 1'b1;
  end
end

reg  [19:0] count;
wire        sto_secund;

assign sto_secund = ( count == PULSE_MAX );

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    count <= 20'd0;
  else
    if( device_run | sto_secund )
      if( sto_secund )
        count <= 20'd0;
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
    if( sto_secund ) 
      if( tens_secund )
        count_100 <= 4'd0;
      else
          count_100 <= count_100 + 1;
    else
        if( fsm == CHANGE_1 & increment )
          if( count_100 ==4'd9 )
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
    if( tens_secund )
      if( second_pas )
        count_10 <= 4'd0;
      else
        count_10 <= count_10 + 1;
    else
      if( fsm == CHANGE_2 & increment )
        if( count_10 == 4'd9 )
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
    if( second_pas )
      if( ten_sec_pas )
        secun_count <= 4'd0;
      else
        secun_count <= secun_count + 1;
    else
      if( fsm == CHANGE_3 & increment )
        if( secun_count == 4'd9 )
          secun_count <= 4'd0;
        else
          secun_count <= secun_count + 1;
end

reg [3:0] ten_sec_count;

always @( posedge clk100_i or negedge rstn_i ) begin
  if( !rstn_i )
    ten_sec_count <= 4'd0;
  else
    if( ten_sec_pas )
      if( ten_sec_count == 4'd9 )
        ten_sec_count <= 4'd0;
      else
        ten_sec_count <= ten_sec_count + 1;
    else
      if( fsm == CHANGE_4 & increment )
        if( ten_sec_count == 4'd9 )
          ten_sec_count <= 4'd0;
        else
          ten_sec_count <= ten_sec_count + 1;
end

dc_hex dec3(
  .in ( ten_sec_count ),
  .out( hex3_o        )
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

stopwatch_fs mac(
  .clk_i        ( clk100_i   ),
  .rstn_i       ( rstn_i     ),
  .device_run_i ( device_run ),
  .set_i        ( set        ),
  .start_i      ( start      ),
  .change_i     ( change     ),
  .state_o      ( fsm        ),
  .inc_o        ( increment  ),
  .q            ( q          )
);

endmodule
