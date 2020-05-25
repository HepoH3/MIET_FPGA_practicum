`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////



module stopwatch_tb(
);
reg clk100_i;
reg rstn_i;
reg start_stop_i;
reg set_i;
reg change_i;
wire [6:0] hex0_o;
wire [6:0] hex1_o;
wire [6:0] hex2_o;
wire [6:0] hex3_o;


stopwatch #(.PULSE_MAX(9)) DUT (
  .clk100_i     ( clk100_i     ),
  .rstn_i       ( rstn_i       ),
  .start_stop_i ( start_stop_i ),
  .set_i        ( set_i        ),
  .change_i     ( change_i     ),
  .hex0_o       ( hex0_o       ),
  .hex1_o       ( hex1_o       ),
  .hex2_o       ( hex2_o       ),
  .hex3_o       ( hex3_o       )
);

initial begin
  rstn_i     <= 1'b1;
  #15 rstn_i <= 1'b0;
  #31 rstn_i <= 1'b1;
end

initial begin
  clk100_i <= 1'b0;
  forever #3 clk100_i <=~clk100_i;
end
  
initial begin
  start_stop_i      <= 1'b1;
  #44 start_stop_i  <= 1'b0;
  #23 start_stop_i  <= 1'b1;
  #150 start_stop_i <= 1'b0;
  #23 start_stop_i  <= 1'b1;
end

initial begin
  set_i <= 1'b1;
  #250;
  repeat(5) begin
    set_i <= 1'b0;
    #20;
    set_i <= 1'b1;
    #20;
  end
end


initial begin
  change_i <= 1'b1;
  #270;
  repeat(10) begin
    change_i <= ~change_i;
    #17;
  end
end
endmodule
