
module lab2(
  input        clk100_i,
  input        rstn_i,
  input  [9:0] sw_i,
  input  [1:0] key_i,
  output [9:0] ledr_o,
  output [6:0] HEX1_o,
  output [6:0] HEX0_o
  );
  
  wire      key;
  reg [2:0] btn_sync;
  reg [9:0] led;
  reg [7:0] lab2;
  reg [6:0] out;
  
  assign HEX    = out;
  assign ledr_o = led;
  assign key    = ~btn_sync[2] & btn_sync[1];
  
  always @( posedge clk100_i )
    begin 
      btn_sync[0] <= key_i[0];
      btn_sync[1] <= btn_sync[0];
      btn_sync[2] <= btn_sync[1];
    end
    
  
  always @( posedge clk100_i or posedge rstn_i )
    begin
      if ( rstn_i == 1'b0 )
        led <= 10'd0;
      else if ( key )
        led <= sw_i;
    end
    
  always @( posedge clk100_i or posedge rstn_i )
    begin
      if ( rstn_i == 0 )
        lab2 <= 8'd0;
      else if ( key )
        lab2 = lab2 + 1;
    end
  
  HEX HEX0
  (
    .HEX_i( lab2[3:0] ),
    .HEX_o( HEX0_o       )
  );
  
  HEX HEX1
  (
    .HEX_i( lab2[7:4] ),
    .HEX_o( HEX1_o       )
  );
  
endmodule

