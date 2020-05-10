`timescale 1ns / 1ps


module counter(
input            en_i,
input            clk_i,
input            rstn_i,
input      [9:0] sw_i,
output reg [7:0] counter_o
    );
    
 
//reg sw_event;
//always @( sw_i )begin
// if ( ( sw_i[0] + sw_i[1] + sw_i[2] + sw_i[3] + sw_i[4] + sw_i[5] + sw_i[6] + sw_i[7] + sw_i[8] + sw_i[9] )> 4'd3 )  sw_event <= 1'b1; 
// else sw_event <= 1'b0;
//end 


reg [1:0] button_syncroniser;
wire button_was_pressed;

always @( posedge clk_i or negedge rstn_i ) begin
  if( !rstn_i )
    button_syncroniser <= 2'b0;
  else begin
    button_syncroniser[0] <= ~en_i;
    button_syncroniser[1] <= button_syncroniser[0];
  end
end

assign button_was_pressed = ~button_syncroniser[1] & button_syncroniser[0];

always@( posedge clk_i or negedge rstn_i )begin
  if( !rstn_i ) counter_o <= 0; 
  else if( button_was_pressed ) counter_o <= counter_o + 1;
end

endmodule



