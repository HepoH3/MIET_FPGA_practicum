`timescale 1ns / 1ps

module debounce_remover (
  // Clock input
  input  clk100_i,
  
  // Reset input
  input  rstn_i,
  
  // Data input
  input  button_i,
  
  // Data output
  output button_was_pressed_o
);

  reg [2:0] button_sync_data;

  always @( posedge clk100_i or negedge rstn_i ) begin
    if( ~rstn_i )
      button_sync_data <= 0;
    else begin
      button_sync_data[0] <= button_i;
      button_sync_data[1] <= button_sync_data[0];
      button_sync_data[2] <= button_sync_data[1];
    end
  end

  assign button_was_pressed_o = ~button_sync_data[2] & button_sync_data[1];

endmodule