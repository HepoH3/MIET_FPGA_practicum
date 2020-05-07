`timescale 1ns / 1ps

module count_event(
  input  CLK50_i,
  input  en_i,
  input  resetn_i,
  input  [9:0]SW_i,
  output reg [7:0] counter_o
    );
reg sw_event;
always @( SW_i )begin
 if (( SW_i[0]+SW_i[1]+SW_i[2]+SW_i[3]+SW_i[4]+SW_i[5]+SW_i[6]+SW_i[7]+SW_i[8]+SW_i[9] )> 4'd3)  sw_event <= 1'b1; 
  else sw_event <= 1'b0;
end 
 reg [2:0] event_sync_reg; 
 wire bwp;
 always @( posedge CLK50_i  ) begin
      event_sync_reg[0] <= en_i; 
      event_sync_reg[1] <= event_sync_reg[0]; 
      event_sync_reg[2] <= event_sync_reg[1]; 
 end
 assign bwp =~event_sync_reg[2]& event_sync_reg[1]; 
 
 always@( posedge CLK50_i or negedge resetn_i )begin
 if( !resetn_i ) counter_o<=0;
 else if( bwp & sw_event ) counter_o<=counter_o+1;
 end
endmodule
