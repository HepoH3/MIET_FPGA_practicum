`timescale 1ns / 1ps



module counter(
    input        clk50_i,
    input        rstn_i,
    input  [9:0] sw_i,
    input  [1:0] key_i,
    output [9:0] ledr_o,
    output [9:0] KS_register,
    output [7:0] KS_counter
  
);
 reg  [6:0] hex1_o;
 reg  [6:0] hex0_o;
 wire [9:0] mainfr_register;
 wire [7:0] mainfr_counter;
 wire [1:0]KP_btn_i;
 assign ledr_o = mainfr_register;
  KEY_Pressing u1(
    .KP_btn(key_i[1:0]),
    .KP_CLK50MHZ(KS_CLK50MHZ),
    .KP_btn_ondn(KS_btn_ondn)
  );
 
  Register_10 u2(
    .d(sw_i[9:0]),                 
    .clk(KS_CLK50MHZ),              
    .rst(KP_btn_i[1]),           
    .en(KP_btn_i[0]),            
    .register(KS_register[9:0])     
  );
  
  
  Counter_8 u3(
    .clk(KS_CLK50MHZ),
    .rst(KP_btn_i[1]),
    .en(KS_synced_event),
    .counter(KS_counter[7:0])
  ); 
 reg mainfr_disp_selector = 1'd0; 
 
 always @(posedge clk50_i) begin
  mainfr_disp_selector <= mainfr_disp_selector + 1'b1; 
      if (mainfr_disp_selector == 1'b0)
      begin
          hex0_o <= 8'b1111_1110;
          case (mainfr_counter[3:0]) 
              4'd0 : hex1_o = 7'b100_0000;
              4'd1 : hex1_o = 7'b111_1001;
              4'd2 : hex1_o = 7'b010_0100;
              4'd3 : hex1_o = 7'b011_0000;
              4'd4 : hex1_o = 7'b001_1001;
              4'd5 : hex1_o = 7'b001_0010;
              4'd6 : hex1_o = 7'b000_0010;
              4'd7 : hex1_o = 7'b111_1000;
              4'd8 : hex1_o = 7'b000_0000;
              4'd9 : hex1_o = 7'b001_0000;
              4'd10 : hex1_o = 7'b000_1000;
              4'd11 : hex1_o = 7'b000_0011;
              4'd12 : hex1_o = 7'b100_0110;
              4'd13 : hex1_o = 7'b010_0001;
              4'd14 : hex1_o = 7'b000_0110;
              4'd15 : hex1_o = 7'b000_1110;
          endcase
      end
      
      if (mainfr_disp_selector == 1'b1)
      begin
          hex0_o <= 8'b1111_1101;
          case (mainfr_counter[7:4])
             4'd0 : hex1_o = 7'b100_0000;
              4'd1 : hex1_o = 7'b111_1001;
              4'd2 : hex1_o = 7'b010_0100;
              4'd3 : hex1_o = 7'b011_0000;
              4'd4 : hex1_o = 7'b001_1001;
              4'd5 : hex1_o = 7'b001_0010;
              4'd6 : hex1_o = 7'b000_0010;
              4'd7 : hex1_o = 7'b111_1000;
              4'd8 : hex1_o = 7'b000_0000;
              4'd9 : hex1_o = 7'b001_0000;
              4'd10 : hex1_o = 7'b000_1000;
              4'd11 : hex1_o = 7'b000_0011;
              4'd12 : hex1_o = 7'b100_0110;
              4'd13 : hex1_o = 7'b010_0001;
              4'd14 : hex1_o = 7'b000_0110;
              4'd15 : hex1_o = 7'b000_1110;
          endcase
      end    
  end
      
      
    
endmodule
