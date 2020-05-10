module reg_10_bit(
    input      [9:0] data_i,             
    input            clk_i,           
    input            rstn_i,           
    input            en_i,            
    output reg [9:0] register_o       
    );
  
  
reg [1:0] button_syncroniser;
wire button_was_pressed;

always @( posedge clk_i or negedge rstn_i ) begin
  if( !rstn_i )
    button_syncroniser <= 2'b0;
  else begin
    button_syncroniser[0] <= ~en_i;
    button_syncroniser[1] <= button_syncroniser[0];
  end
end

assign button_was_pressed = ~button_syncroniser[1] & button_syncroniser[0];
    
  always @( posedge clk_i or negedge rstn_i ) begin
      if ( !rstn_i ) register_o <= 0;
      else if ( button_was_pressed ) register_o <= data_i;
  end 
  
endmodule