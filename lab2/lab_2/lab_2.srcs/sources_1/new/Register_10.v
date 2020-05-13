`timescale 1ns / 1ps
module Register_10(
    input      [9:0] d_i,             
    input            clk_i,           
    input            rst_i,           
    input            en_i,            
    output reg [9:0] register_o       
    );
   
  always @(posedge clk_i or posedge rst_i) begin
      if (rst_i) register_o <= 0;
      else if (en_i) register_o <= d_i;
  end 
  
endmodule
