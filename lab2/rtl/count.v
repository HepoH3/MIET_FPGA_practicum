`timescale 1ns / 1ps
module count#(
  parameter DATA_WIDTH = 8
  )
  (
  input                       clk_i,
  input                       arstn_i,
  
  input      [9:0]            sw,
  input                       key,
  
  output reg [DATA_WIDTH-1:0] counter
  );
  
  reg sw_event;
  
  always @( posedge clk_i or negedge arstn_i ) begin
   if (!arstn_i) counter <= {DATA_WIDTH{1'b0}};
   else if(key && sw_event) counter <= counter + 1;
   end
   
  always @( posedge clk_i or negedge arstn_i ) begin
   if (!arstn_i) sw_event <= 1'b0;
   else if ((sw[0] + sw[1] + sw[2] + sw[3] + sw[4] + sw[5] + sw[6] + sw[7] + sw[8] + sw[9]) > 4'd3) sw_event <= 1'b1;
        else sw_event <= 1'b0;
  end
  

endmodule