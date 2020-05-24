`timescale 1ns / 1ps
module stopwatch_tb(

);

localparam CLK_FREQ_MHZ   = 100;
localparam CLK_SEMIPERIOD = ( 1000 / CLK_FREQ_MHZ ) / 2;

reg        clk100_i;
reg        rstn_i;
reg        start_stop_i;
reg        set_i;
reg        change_i;
wire [6:0] hex0_o;
wire [6:0] hex1_o;
wire [6:0] hex2_o;
wire [6:0] hex3_o;

stopwatch DUT
( 
  .clk100_i     ( clk100_i     ),
  .start_stop_i ( start_stop_i ),
  .rstn_i       ( rstn_i       ),
  .set_i        ( set_i        ),
  .change_i     ( change_i     ),
  .hex0_o       ( hex0_o[6:0]  ),
  .hex1_o       ( hex1_o[6:0]  ),
  .hex2_o       ( hex2_o[6:0]  ),
  .hex3_o       ( hex3_o[6:0]  )
);

initial begin
  clk100_i = 1'b1;
  forever begin
    #CLK_SEMIPERIOD clk100_i=~clk100_i;
  end
end

initial begin
  set_i = 1;
  change_i = 1;
  repeat ( 2 ) begin 
    #( 10 * CLK_SEMIPERIOD );
    set_i = 0;
    #( 2 * CLK_SEMIPERIOD );
    set_i = 1;
    repeat ( 7 ) begin
      #( 2 * CLK_SEMIPERIOD );
      change_i = 0;
      #( 2 * CLK_SEMIPERIOD );
      change_i = 1;
    end
  end
  
  repeat ( 3 ) begin 
    #( 10 * CLK_SEMIPERIOD );
    set_i = 0;
    #( 2 * CLK_SEMIPERIOD );
    set_i = 1;
    #( 2 * CLK_SEMIPERIOD );
    change_i = 0;
    #( 2 * CLK_SEMIPERIOD );
    change_i = 1;
  end
  
  #( 10 * CLK_SEMIPERIOD );
  set_i = 0;
  #( 2 * CLK_SEMIPERIOD );
  set_i = 1;
  repeat ( 3 ) begin
    #( 2 * CLK_SEMIPERIOD );
    change_i = 0;
    #( 2 * CLK_SEMIPERIOD );
    change_i = 1;
  end
  
end

initial begin
  forever begin
    start_stop_i = 1;
    #( 20 * CLK_SEMIPERIOD );
    start_stop_i = 0;
    #( 2 * CLK_SEMIPERIOD );
    start_stop_i = 1;
  end
end

initial begin
  rstn_i = 1'b1;
  #( 2 * CLK_SEMIPERIOD );
  rstn_i = 1'b0;
  #( 4 * CLK_SEMIPERIOD );
  rstn_i = 1'b1;
end

endmodule
