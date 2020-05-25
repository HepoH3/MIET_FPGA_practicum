`timescale 1ns / 1ps

module button_sync(
  input  in,
  input  clk,
  output button_was_pressed
    );

reg [2:0] button_synchroniser;

always @( posedge clk ) begin
  button_synchroniser[0] <= !in;
  button_synchroniser[1] <= button_synchroniser[0];
  button_synchroniser[2] <= button_synchroniser[1];
end

assign button_was_pressed = ~ button_synchroniser[2] & button_synchroniser[1];

endmodule
