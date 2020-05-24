`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.05.2020 11:53:49
// Design Name: 
// Module Name: stopwatch_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



module stopwatch_tb(

  );

localparam CLK_FREQ_MHZ = 100;
localparam CLK_SEMIPERIOD = (1000/CLK_FREQ_MHZ/2);

  reg          clk100_i;
  reg          rstn_i;
  reg          start_stop_i;
  reg          set_i;
  reg          change_i;
  wire  [6:0]  hex0_o;
  wire  [6:0]  hex1_o;
  wire  [6:0]  hex2_o;
  wire  [6:0]  hex3_o;

  stopwatch DUT (
    .clk100_i      ( clk100_i     ),
    .rstn_i        ( rstn_i       ),
    .start_stop_i  ( start_stop_i ),
    .set_i         ( set_i        ),
    .change_i      ( change_i     ),
    .hex0_o        ( hex0_o       ),
    .hex1_o        ( hex1_o       ),
    .hex2_o        ( hex2_o       ),
    .hex3_o        ( hex3_o       )
  );

  initial begin
    rstn_i       = 1'b1;
    start_stop_i = 1'b1;
    set_i        = 1'b1;
    change_i     = 1'b1;
    
    #100
    set_i = 1'b0;
    #100
    set_i = 1'b1;
    
    //00.01
    #1000
    change_i = 1'b0;
    #100
    change_i = 1'b1;
    
    #1000
    set_i = 1'b0;   
    #100            
    set_i = 1'b1;   
     
    //00.10            
    #1000           
    change_i = 1'b0;
    #100            
    change_i = 1'b1;
    
    #100
    set_i = 1'b0;
    #100
    set_i = 1'b1;
    
    //01.00
    #1000
    change_i = 1'b0;
    #100
    change_i = 1'b1;
    
    #1000
    set_i = 1'b0;   
    #100            
    set_i = 1'b1;   
    
    //10.00             
    #1000           
    change_i = 1'b0;
    #100            
    change_i = 1'b1;
    
    #100000
    set_i = 1'b0;   
    #100            
    set_i = 1'b1;  
    
    #1000
    start_stop_i = 1'b0;
    #100
    start_stop_i = 1'b1;
    
    #10000
    change_i = 1'b0;
    #100
    change_i = 1'b1;
    
    
    
  end

  initial begin
    clk100_i = 1'b0;
    forever #CLK_SEMIPERIOD clk100_i = ~clk100_i;  
  end
  
endmodule
