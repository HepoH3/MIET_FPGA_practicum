`timescale 1ns / 1ps

module reg_10#(
  parameter DATA_WIDTH = 10
  )
  (
  input                         clk_i,
  input                         arstn_i,
  
  input       [DATA_WIDTH-1:0]  sw,
  input                         key,
  
  output  reg [DATA_WIDTH-1:0]  led
  );
  
  
   always @( posedge clk_i or negedge arstn_i ) begin
   if (!arstn_i) led[DATA_WIDTH-1:0]  <=  {DATA_WIDTH{1'b0}};
   else if (key) led[DATA_WIDTH-1:0]  <=  sw[DATA_WIDTH-1:0];
  end
  
endmodule