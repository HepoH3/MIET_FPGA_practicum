module dff#(
  parameter DATA_WIDTH = 8
  )
  (
  input                   clk_i,
  input                   arstn_i,
  
  input  [DATA_WIDTH-1:0] data_i,
  output [DATA_WIDTH-1:0] data_o,
  
  input en,  
  output reg [7:0] counter
  );
  
  
  always @( posedge clk_i or negedge arstn_i ) begin
   if (arstn) counter<=0;
   else if (en) counter<= counter+1;
  end
 endmodule;