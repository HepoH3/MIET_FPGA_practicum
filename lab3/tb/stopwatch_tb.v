`timescale 1ns / 1ps



module stopwatch_tb(

    );
localparam CLK_FREQ_MHZ   = 26;
localparam CLK_SEMIPERIOD = ( 1000 / CLK_FREQ_MHZ) / 2;

reg        clk;
reg        rstn;
reg        start_stop;
reg        set;
reg        change;
wire [6:0] hex0;
wire [6:0] hex1;
wire [6:0] hex2;
wire [6:0] hex3;

stopwatch #(.PULSE(3)) DUT (
  .clk100_i     ( clk        ),
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
  rstn     <= 1'b1;
  #15 rstn <=1'b0;
  #31 rstn <=1'b1;
end

initial begin
  clk <= 1'b0;
  forever begin
    #CLK_SEMIPERIOD clk = ~clk;
  end
end

initial begin
  #23 start_stop                  <= 1'b0;
  #44 start_stop                  <= 1'b1;
  #56 start_stop                  <= 1'b0;
  #(26*CLK_SEMIPERIOD) start_stop <= 1'b1;
  #23 start_stop                  <= 1'b0; 

end

initial begin
  set = 1'b0;
    forever begin
      #(10*CLK_SEMIPERIOD);
      set = ~set;
    end
end

initial begin
  change = 1'b0;
    forever begin
      #(2*CLK_SEMIPERIOD);
      change = ~change;
    end
end

endmodule