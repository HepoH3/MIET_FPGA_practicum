module reg_10_bit(
    input      [9:0] data_i,             
    input            clk_i,           
    input            rstn_i,           
    input            en_i,            
    output reg [9:0] register_o       
    );
  
    
  always @( posedge clk_i or negedge rstn_i ) begin
      if ( !rstn_i ) register_o <= 0;
      else if ( en_i ) register_o <= data_i;
  end 
  
endmodule