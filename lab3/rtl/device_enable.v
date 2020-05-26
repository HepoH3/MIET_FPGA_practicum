`timescale 1ns / 1ps

module device_enable(
input  clk_i,
input  buttonn_was_pressed,
input  state_device,

output signal_o
    );

parameter DEFAULT        = 1'b0;
reg       device_running = 1'b1;

always @( posedge clk_i )
begin
  if ( buttonn_was_pressed && state_device == DEFAULT ) 
    device_running <= ~device_running;
end

assign signal_o = device_running;

endmodule
