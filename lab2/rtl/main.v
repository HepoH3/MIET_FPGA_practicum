`timescale 1ns / 1ps

module main#(
  parameter DATA_WIDTH = 10
  )
  (
  input                       CLK50,
  input      [DATA_WIDTH-1:0] sw,
  input      [1:0]            key,
  
  output     [DATA_WIDTH-1:0] ledr,
  
  output reg [6:0]            hex,
  output reg [1:0]            hex_on
  
  );

  wire [DATA_WIDTH-1:0] led_reg;
  assign ledr = led_reg;
  
  wire [13:0] dec;
  wire [7:0] count;
  reg [1:0] HEX_ON;
  
reg_10 reg_10(
  .clk_i(CLK50),
  .arstn_i(key[1]),
  .sw(sw),
  .key(key[0]),
  .led(led_reg)
  );

count counter(
  .clk_i( CLK50 ),
  .key( key[0] ),
  .arstn_i( key[1] ),
  .sw( sw ),
  .counter( count[7:0] )
  );

dec_hex dec_0(
  .arstn_i( key[1] ),
  .kod_i( count[3:0] ),
  .hex_o(dec[6:0])
  );  
  
dec_hex dec_1(
  .arstn_i( key[1] ),
  .kod_i( count[7:4] ),
  .hex_o(dec[13:7])
  );  

always @( posedge CLK50 ) begin
 if ( key[1] ) HEX_ON <= 2'b10;
 else begin
      hex_on <= HEX_ON;
       if ( HEX_ON == 2'b10 )begin
        hex[6:0] <= dec[6:0];
        HEX_ON <= 2'b01;
       end
       if ( HEX_ON == 2'b01 )begin
         hex[6:0] <= dec[13:7];
         HEX_ON <= 2'b10;
       end
      end
end

endmodule
