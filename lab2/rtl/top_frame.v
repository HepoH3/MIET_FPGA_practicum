`timescale 1ns / 1ps


module top_frame(
  input      [9:0]  sw,                     
  input      [1:0]  key_i,                    
  input             clk_50, 
                
  output     [9:0]  led_o,                    
  output     [6:0]  hex0_o,                    
  output     [6:0]  hex1_o 
    );

wire [7:0] counter_value; 

counter counter_elem(
  .en_i(      key_i[0]      ),
  .clk_i(     clk_50        ),
  .rstn_i(    key_i[1]      ),
  .sw_i(      sw            ),
  .counter_o( counter_value )
);

reg_10_bit register(
  .data_i(     sw       ),
  .clk_i(      clk_50   ),
  .rstn_i(     key_i[1] ),
  .en_i(       key_i[0] ),
  .register_o( led_o    )
);

decoder dec0(
  .dec_i( counter_value [3:0] ),
  .hex_o(  hex0_o             )
);

decoder dec1(
  .dec_i( counter_value [7:4] ),
  .hex_o(  hex1_o             )
);




endmodule
