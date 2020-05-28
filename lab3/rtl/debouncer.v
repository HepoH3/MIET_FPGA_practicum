`timescale 1ns / 1ps


module debouncer(
  input  clk100_i,
  input  rstn_i,
  input  signal_i,
  
  output synced_o
    );
  
reg [2:0] sync;

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i )
    sync <= 3'b0; 
  else begin
    sync[0] <= ~signal_i;
    sync[1] <=  sync[0];
    sync[2] <=  sync[1];
  end
end

assign synced_o = ~ sync[2] && sync[1];

endmodule
