`timescale 1ns / 1ps

module button_deb(
  input  clk_i,
  input  rst_i,
  input  btn_i,
  output ondn_o
  );

reg [1:0] syncronise;

always @( posedge clk_i or negedge rst_i ) begin
  if( !rst_i )
    syncronise <= 2'b0;
  else
    begin
      syncronise[0] <= btn_i;
      syncronise[1] <= syncronise[0];
    end
end

assign ondn_o = ~syncronise[1] & syncronise[0];

endmodule
