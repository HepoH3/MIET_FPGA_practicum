`timescale 1ns / 1ps


module KEY_Pressing(
  input   [1:0] KP_btn_i,        
  input         KP_clk50_i,     
  output  [1:0] KP_btn_ondn     
    );
    
  wire [1:0]KP_btn_onup;        
  wire [1:0]KP_btn_state;       
        
  KEY_Debounce u1(
    .i_btn   (KP_btn_i[0]),
    .o_onup  (KP_btn_onup[0]),
    .o_ondn  (KP_btn_ondn[0]),
    .o_state (KP_btn_state[0]),
    .clk     (KP_clk50_i)
  ); 
    KEY_Debounce u2(
    .i_btn   (KP_btn_i[1]),
    .o_onup  (KP_btn_onup[1]),
    .o_ondn  (KP_btn_ondn[1]),
    .o_state (KP_btn_state[1]),
    .clk     (KP_clk50_i)
  ); 
endmodule
