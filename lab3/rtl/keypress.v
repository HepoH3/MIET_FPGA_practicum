`timescale 1ns / 1ps

module keypress(
  input  clk100_i,
  input  rstn_i,
  input  en_i,
  
  output btn_was_pressed_o
  );
    
reg [2:0] btn_sync;

always @( posedge clk100_i or negedge rstn_i ) begin
  if ( !rstn_i ) begin
    btn_sync[0] <= 0;
    btn_sync[1] <= 0;
    btn_sync[2] <= 0;
  end
  else begin
    btn_sync[0] <= ~en_i;
    btn_sync[1] <= btn_sync[0];
    btn_sync[2] <= btn_sync[1];
  end
end

assign btn_was_pressed_o = ~btn_sync[2] & btn_sync[1];

endmodule
