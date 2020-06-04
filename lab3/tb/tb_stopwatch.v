`timescale 1ns / 1ps

module tb_stopwatch;

  localparam CLK_FREQ_MHZ   = 100;
  localparam CLK_PERIOD     = 1000 / CLK_FREQ_MHZ;
  localparam CLK_SEMIPERIOD = 1000 / CLK_FREQ_MHZ / 2;
  
  reg        clk100;
  reg        rstn;
  reg        start_stop;
  reg        set;
  reg        change;
  
  wire [6:0] hex0;
  wire [6:0] hex1;
  wire [6:0] hex2;
  wire [6:0] hex3;
  

  initial begin
    clk100 = 1;
    forever
      #CLK_SEMIPERIOD clk100 = ~clk100;
  end
  
 
  initial begin
    rstn = 0;
    #CLK_SEMIPERIOD
    rstn = 1;
    #( CLK_PERIOD * 10000 );
    rstn = 0;
    #CLK_SEMIPERIOD
    rstn = 1;
  end
  
 
  initial begin
    #( CLK_PERIOD * 10)
    forever begin
      start_stop = 1;
      #CLK_PERIOD
      start_stop = 0;
      #( CLK_PERIOD * 4100 );
    end
  end
  
  initial begin
    #( CLK_PERIOD * 4200 );
    set = 1;
    #CLK_PERIOD
    set = 0;
    repeat ( 4 ) begin
      #( CLK_PERIOD * 700 );
      set = 1;
      #CLK_PERIOD
      set = 0;
    end
  end
  

  initial begin
    #( CLK_PERIOD * 4300 );
    repeat ( 5 ) begin
      repeat ( 5 ) begin
        change = 1;
        #CLK_PERIOD
        change = 0;
        #( CLK_PERIOD * 100 );
      end
    #( CLK_PERIOD * 200 );
    end
  end
  
  stopwatch  DUT (
    .clk100_i                ( clk100     ),
    .rstn_i                  ( rstn       ),
    .start_stop_i            ( start_stop ),
    .set_i                   ( set        ),
    .change_i                ( change     ),
    .hex0_o                  ( hex0       ),
    .hex1_o                  ( hex1       ),
    .hex2_o                  ( hex2       ),
    .hex3_o                  ( hex3       )
  );
endmodule
