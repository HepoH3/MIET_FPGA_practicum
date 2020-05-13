`timescale 1ns / 1ps
module counter_tb(
    );
  reg        clk50;  
  reg  [9:0] sw;
  reg  [4:0] btn;
  wire [9:0] led;
  wire [6:0]  hex;
  wire   hex_on;
    
  counter DUT (
  .CLK50MHZ (clk50),
  .sw     (sw),
  .btn    (btn),
  .led    (led),
  .hex    (hex),
  .hex_on (hex_on)
  );

 initial begin
    sw[9:0] = 10'b0000000000;
    btn[4:0] = 4'b0000;
    #50;
    
    btn[3]=1'b1;
    #100;
    btn[3]=1'b0;
    
    #200;

    sw[9:0] = 10'b0000000111;
    
    #200
    
    btn[0]=1'b1;
    #100;
    btn[0]=1'b0;
    
    #200;
    
    btn[0]=1'b1;
    #100;
    btn[0]=1'b0;
    
    #200;
    
    sw[9:0] = 10'b0000000011;
    
    #200;
    
    btn[0]=1'b1;
    #100;
    btn[0]=1'b0;
    
    #200;
    
    btn[3]=1'b1;
    #100;
    btn[3]=1'b0;   
 end 
 
 // Проверка модуляции CLK сигнала
 always begin //Создания 1-0 CLK сигнала
    clk50 = 1'b1;
    #10;
    clk50 = 1'b0;
    #10;
 end
    
endmodule
