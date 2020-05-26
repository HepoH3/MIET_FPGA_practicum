`timescale 1ns / 1ps

module button_sync(
    input  clk100_i,
    input  rstn_i,
    input  button_i,
    output button_was_pressed_o
);

reg [2:0] button_synchroniser;

always @( posedge clk100_i or negedge rstn_i )
  begin
    if ( ~rstn_i )
      button_synchroniser <= 3'd0;
    else
      begin
        button_synchroniser[0] <= ~button_i;
        button_synchroniser[1] <= button_synchroniser[0];
        button_synchroniser[2] <= button_synchroniser[1];
      end
  end

assign button_was_pressed_o = ( ~button_synchroniser[2] ) &
                               button_synchroniser[1];

endmodule
