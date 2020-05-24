`timescale 1ns / 1ps



module stopwatch_tb(

    );
localparam CLK_FREQ_MHZ   = 100;
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
  forever #CLK_SEMIPERIOD clk100 = ~clk100;
end

initial begin
  rstn     <= 1'b1;
  #( 5 * CLK_SEMIPERIOD ) rstn <=1'b0;
  #( 5 * CLK_SEMIPERIOD ) rstn <=1'b1;
end
  
initial begin
  start_stop <= 1'b0;
  #( CLK_SEMIPERIOD ) start_stop <= 1'b1;
  #( 10 * CLK_SEMIPERIOD ) start_stop <= 1'b0;
  #( CLK_SEMIPERIOD ) start_stop <= 1'b1;
end

initial begin 
  set <= 0;
  #7   set <= 1;
  #10  set <= 0;
  #22  set <= 1;
  #27  set <= 0;
  #50  set <= 1;
end

initial begin 
  change <= 0;
  #10 change <= 1;
  #7  change <= 0;
  #15 change <= 1;
  #6  change <= 0;
  #12 change <= 1;
  #20 change <= 0;
  #19 change <= 1;
end
endmodule
