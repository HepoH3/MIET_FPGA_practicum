`timescale 1ns/1ps

module stopwatch_tb(
    );

localparam CLK_FREQ_MHZ = 50;
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
  
stopwatch DUT (
  .clk100_i      ( clk100_i ),
  .rstn_i        ( rstn_i ),
  .start_stop_i  ( start_stop_i ),
  .set_i         ( set_i ),
  .change_i      ( change_i ),
  .hex0_o        ( hex0_o ),
  .hex1_o        ( hex1_o ),
  .hex2_o        ( hex2_o ),
  .hex3_o        ( hex3_o )
  );
  
initial begin
  clk100_i = 1'b1;
  forever begin
    #CLK_SEMIPERIOD clk100_i = ~clk100_i;
  end
end

initial begin
  rstn_i = 1'b0;
  #(2*CLK_SEMIPERIOD)
  rstn_i = 1'b1;
  #(2*CLK_SEMIPERIOD)
  rstn_i = 1'b0;
 

end

initial begin
  start_stop_i = 1'b0;
  #(5*CLK_SEMIPERIOD)
  start_stop_i = ~start_stop_i;
  #(5*CLK_SEMIPERIOD)
  start_stop_i = ~start_stop_i;
  #(200*CLK_SEMIPERIOD)
  start_stop_i = ~start_stop_i;
  #(5*CLK_SEMIPERIOD)
  start_stop_i = ~start_stop_i;
  #(200*CLK_SEMIPERIOD)
  start_stop_i = ~start_stop_i;
  #(5*CLK_SEMIPERIOD)
  start_stop_i = ~start_stop_i;
  #(200*CLK_SEMIPERIOD)
  start_stop_i = ~start_stop_i;
  #(5*CLK_SEMIPERIOD)
  start_stop_i = ~start_stop_i;
  #(200*CLK_SEMIPERIOD)
  start_stop_i = ~start_stop_i;
  #(5*CLK_SEMIPERIOD)
  start_stop_i = ~start_stop_i;
  #(200*CLK_SEMIPERIOD)
  start_stop_i = ~start_stop_i;
  #(5*CLK_SEMIPERIOD)
  start_stop_i = ~start_stop_i;
  #(200*CLK_SEMIPERIOD)
  start_stop_i = ~start_stop_i;
  #(5*CLK_SEMIPERIOD)
  start_stop_i = ~start_stop_i;
end

initial begin
  set_i = 1'b0;
    forever begin
      #(10*CLK_SEMIPERIOD);
      set_i = ~set_i;
    end
end

initial begin
  change_i = 1'b0;
    forever begin
      #(2*CLK_SEMIPERIOD);
      change_i = ~change_i;
    end
end

endmodule
