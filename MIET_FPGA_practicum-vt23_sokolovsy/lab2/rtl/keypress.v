`timescale 1ns / 1ps

module keypress(
  input         clk_i,
  input         rstn_i,
  input         en_i, 
  
  output        btn_was_pressed_o
  );

  reg [1:0] btn_sync;

  always @( posedge clk_i or negedge rstn_i ) begin
    if ( !rstn_i )
      btn_sync <= 2'b0;
    else
      begin
        btn_sync[0] <= ~en_i;
        btn_sync[1] <= btn_sync[0];
      end
  end

  assign btn_was_pressed_o = ~btn_sync[1] & btn_sync[0];  

endmodule