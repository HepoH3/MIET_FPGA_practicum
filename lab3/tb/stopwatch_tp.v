`timescale 1ns / 1ps

module stopwatch_tp(
);
localparam CLK_FREQ_MHZ   = 50;
localparam CLK_SEMIPERIOD = ( 1000 / CLK_FREQ_MHZ) / 2;     

reg          rstn_i;
reg          start_stop_i;
reg          clk100_i;
wire [6:0]   hex1_o;
wire [6:0]   hex0_o;
wire [6:0]   hex2_o;
wire [6:0]   hex3_o;
reg          set_i;
reg          change_i;

stopwatch DUT (
  .clk100_i        ( clk100_i       ),
  .start_stop_i    ( start_stop_i   ),
  .hex1_o          ( hex1_o         ),
  .hex0_o          ( hex0_o         ),
  .hex2_o          ( hex2_o         ),
  .hex3_o          ( hex3_o         ),
  .rstn_i          ( rstn_i         ),
  .change_i        ( change_i       ),
  .set_i           ( set_i          )
);

initial begin
  clk100_i = 1'b1;
  forever begin
    #CLK_SEMIPERIOD
    clk100_i=~clk100_i;
  end
end

initial begin
  // Initialize Inputs
  rstn_i = 1;
  start_stop_i = 1;
  set_i = 1;
  change_i = 1;
  // Wait 100 ns for global reset to finish
  #100;
  rstn_i = 0;
  #100;
  rstn_i = 1;
  #1000;
  start_stop_i = 0;
  set_i = 0;
  #100;
  start_stop_i = 1;

  #100;
  set_i = 0;
  #100
  set_i = 1;

  repeat( 3 ) begin
    #100;
    change_i = 0;
    #100
    change_i = 1;
  end 

  #1000;
  start_stop_i = 0;
  #100;
  start_stop_i = 1;

  #100;
  set_i = 0;
  change_i = 0;
  #100
  set_i = 1;

  repeat( 16 ) begin
    #100;
    change_i = 0;
    #100
    change_i = 1;
  end 

  #100;
  start_stop_i = 0;
  #100;
  start_stop_i = 1;

  repeat( 4 ) begin
    #100;
    set_i = 0;
    #100
    set_i = 1;
  end

  #100;
  start_stop_i = 0;
  #100;
  start_stop_i = 1;

  // Add stimulus here
end

endmodule
