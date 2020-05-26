`timescale 1ns / 1ps

module pulse_counter(
input      clk_i,
input      arstn_i,
input      device_running_i,

output     signal_o
    );
    
parameter PULSE_WIDTH = 17;
parameter PULSE_MAX = 20'd259999;

reg [PULSE_WIDTH - 1:0] pulse_counter = { PULSE_WIDTH { 1'b0 } };
wire                    pulse_passed  = ( pulse_counter == PULSE_MAX );

always @( posedge clk_i or negedge arstn_i ) begin
  if ( !arstn_i ) 
    pulse_counter <= { 17 { 17'b0 } };
  else if ( ~device_running_i | pulse_passed )
  begin
    if ( pulse_passed )
      pulse_counter <= 0;
    else
      pulse_counter <= pulse_counter + 1;
  end
end
assign signal_o = pulse_passed;

endmodule
