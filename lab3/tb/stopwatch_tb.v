timescale 1ns / 1ps

module stopwatch_tb(

    );

localparam CLK_FREQ_MHZ   = 26;
localparam CLK_SEMIPERIOD = ( 1000 / CLK_FREQ_MHZ) / 2;

reg        clk100;
reg        rstn;
reg        start_stop;
reg        set;
reg        change;
wire [6:0] hex0;
wire [6:0] hex1;
wire [6:0] hex2;
wire [6:0] hex3;

stopwatch DUT (
  .clk100_i     ( clk100     ),
  .rstn_i       ( rstn       ),
  .start_stop_i ( start_stop ),
  .set_i        ( set        ),
  .change_i     ( change     ),
  .hex0_o       ( hex0       ),
  .hex1_o       ( hex1       ),
  .hex2_o       ( hex2       ),
  .hex3_o       ( hex3       )
);

initial begin
  clk100 = 1'b1;
  forever begin
    #CLK_SEMIPERIOD clk100 = ~clk100;
  end
end

initial begin
  rstn = 1;
  #( 5*CLK_SEMIPERIOD );
  rstn = 0;
  #( 5*CLK_SEMIPERIOD );
  rstn = 1;
end

initial begin
  start_stop = 1'b1;
  set        = 1'b1;
  change     = 1'b1;

  @( posedge rstn );
  set = 1'b0;
  #( 11*CLK_SEMIPERIOD );
  set = 1'b1;

  #( 13*CLK_SEMIPERIOD );
  change = 1'b0;
  #( 15*CLK_SEMIPERIOD );
  change = 1'b1;

  #( 9*CLK_SEMIPERIOD );
  set = 1'b0;
  #( 11*CLK_SEMIPERIOD );
  set = 1'b1;

  repeat ( 9 ) begin
    #( 12*CLK_SEMIPERIOD );
    change = 1'b0;
    #( 11*CLK_SEMIPERIOD );
    change = 1'b1;
  end

  #( 14*CLK_SEMIPERIOD );
  set = 1'b0;
  #( 13*CLK_SEMIPERIOD );
  set = 1'b1;

  repeat ( 8 ) begin
    #( 12*CLK_SEMIPERIOD );
    change = 1'b0;
    #( 14*CLK_SEMIPERIOD );
    change = 1'b1;
  end

  #( 11*CLK_SEMIPERIOD );
  set = 1'b0;
  #( 15*CLK_SEMIPERIOD );
  set = 1'b1;

  repeat ( 4 ) begin
    #( 12*CLK_SEMIPERIOD );
    change = 1'b0;
    #( 13*CLK_SEMIPERIOD );
    change = 1'b1;
  end

  #( 13*CLK_SEMIPERIOD );
  set = 1'b0;
  #( 16*CLK_SEMIPERIOD );
  set = 1'b1;

  #( 10*CLK_SEMIPERIOD );
  repeat ( 20 ) begin
    start_stop = 1'b0;
    #( 14*CLK_SEMIPERIOD );
    start_stop = 1'b1;
    #( 200*CLK_SEMIPERIOD );
    start_stop = 1'b0;
    #( 10*CLK_SEMIPERIOD );
    start_stop = 1'b1;
  end

end

endmodule