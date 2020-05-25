`timescale 1ns / 1ps

module stopwatch(
    input        clk100_i,
    input        rstn_i,
    input        start_stop_i,
    input        set_i,
    input        change_i,
    output [6:0] hex0_o,
    output [6:0] hex1_o,
    output [6:0] hex2_o,
    output [6:0] hex3_o
);

localparam PULSE_LIMIT = 20'd9999;
localparam HUNDREDTH_LIMIT = 4'd9;
localparam TENTH_LIMIT = 4'd9;
localparam SECONDS_LIMIT = 4'd9;
localparam TENTH_SECONDS_LIMIT = 4'd9;

//start-stop button logic desc
reg [2:0] button_synchroniser;
wire      button_was_pressed;

always @( posedge clk100_i or negedge rstn_i )
  begin
    if ( ~rstn_i )
      button_synchroniser <= 3'd0;
    else
      begin
        button_synchroniser[0] <= ~start_stop_i;
        button_synchroniser[1] <= button_synchroniser[0];
        button_synchroniser[2] <= button_synchroniser[1];
      end
  end

assign button_was_pressed =  ~button_synchroniser[2]  &  button_synchroniser[1];

//set button desc
reg [2:0] set_synchroniser;
wire      set_was_pressed;

always @( posedge clk100_i or negedge rstn_i )
  begin
    if ( ~rstn_i )
      set_synchroniser <= 3'd0;
    else
      begin
        set_synchroniser[0] <= ~set_i;
        set_synchroniser[1] <= set_synchroniser[0];
        set_synchroniser[2] <= set_synchroniser[1];
      end
  end

assign set_was_pressed =  ~set_synchroniser[2]   &  set_synchroniser[1];

//change button desc
reg [2:0] change_synchroniser;
wire      change_was_pressed;

always @( posedge clk100_i or negedge rstn_i )
  begin
    if ( ~rstn_i )
      change_synchroniser <= 3'd0;
    else
      begin
        change_synchroniser[0] <= ~change_i;
        change_synchroniser[1] <= change_synchroniser[0];
        change_synchroniser[2] <= change_synchroniser[1];
      end
  end

assign change_was_pressed =  ~change_synchroniser[2]  &  change_synchroniser[1];

reg device_running;
always @( posedge clk100_i or negedge rstn_i )
  begin
    if ( ~rstn_i )
      device_running <= 0;
    else if ( button_was_pressed & ( state_adjust == STATE_DEFAULT ) )
      device_running <= ~device_running;
  end

reg [19:0] pulse_counter;
wire       hundredth_of_second_passed = ( pulse_counter == PULSE_LIMIT ); 
  
always @( posedge clk100_i or negedge rstn_i )
  begin
    if ( ~rstn_i ) 
      pulse_counter <= 0;
    else if ( device_running |
              hundredth_of_second_passed )
      begin
        if ( hundredth_of_second_passed )
          pulse_counter <= 0;
        else
          pulse_counter <= pulse_counter + 1;
      end;
  end;
  

reg [3:0] hundredth_counter = 4'd0;
wire      tenth_of_second_passed = 
  ( ( hundredth_counter == HUNDREDTH_LIMIT ) &
      hundredth_of_second_passed );
      
always @( posedge clk100_i or negedge rstn_i )
  begin
    if ( ~rstn_i )
      hundredth_counter <= 0;
    else if ( hundredth_of_second_passed )
      begin
        if ( tenth_of_second_passed )
          hundredth_counter <= 0;
        else
          hundredth_counter <= hundredth_counter + 1;
      end;
  end;
      
reg [3:0] tenth_counter = 4'd0;
wire      second_passed = 
  ( ( tenth_counter == TENTH_LIMIT ) &
      tenth_of_second_passed );
      
always @( posedge clk100_i or negedge rstn_i )
  begin
    if ( ~rstn_i )
      tenth_counter <= 0;
    else if ( tenth_of_second_passed )
      begin
        if ( second_passed )
          tenth_counter <= 0;
        else 
          tenth_counter <= tenth_counter + 1;
      end;
  end;      
  
reg [3:0] second_counter = 4'd0;
wire      tenth_second_passed = 
  ( ( second_counter == SECONDS_LIMIT ) &
      second_passed );
      
always @( posedge clk100_i or negedge rstn_i )
  begin
    if ( !rstn_i )
      second_counter <= 0;
    else if ( second_passed )
      begin
        if ( tenth_second_passed )
          second_counter <= 0;
        else 
          second_counter <= second_counter + 1;
      end;
  end;   
      
reg [3:0] tenth_second_counter = 4'd0;
wire      minute_passed = 
  ( ( tenth_second_counter == 4'd9 ) &
      tenth_second_passed );      
      
always @( posedge clk100_i or negedge rstn_i )
  begin
    if ( ~rstn_i )
      tenth_second_counter <= 0;
    else if ( tenth_second_passed )
      begin
        if ( tenth_second_counter == TENTH_SECONDS_LIMIT )
          tenth_second_counter <= 0;
        else 
          tenth_second_counter <= tenth_second_counter + 1;
      end;
  end;   

//Finite-state machine logic desc          
 reg [2:0] state_adjust;
 reg [2:0] next_state_adjust;
 
 localparam STATE_DEFAULT = 3'd0;
 localparam STATE_D_1     = 3'd1;
 localparam STATE_D_2     = 3'd2;
 localparam STATE_D_3     = 3'd3;
 localparam STATE_D_4     = 3'd4;
 
 always @(*) 
   begin
     case ( state_adjust )
       STATE_DEFAULT : if ( (!device_running) & ( set_was_pressed ) ) 
                         next_state_adjust = STATE_D_1;
                      else next_state_adjust = STATE_DEFAULT;
                      
       STATE_D_1 : if ( set_was_pressed ) next_state_adjust = STATE_D_2;
                   else if ( change_was_pressed ) 
                     begin
                       if ( hundredth_counter == HUNDREDTH_LIMIT )
                         hundredth_counter = 4'd0;
                       else
                         hundredth_counter = hundredth_counter + 1;
                       next_state_adjust = STATE_D_1;
                     end
                   else next_state_adjust = STATE_D_1;
                     
       STATE_D_2 : if ( set_was_pressed ) next_state_adjust = STATE_D_3;
                   else if ( change_was_pressed ) 
                     begin
                       if ( tenth_counter == TENTH_LIMIT )
                         tenth_counter = 4'd0;
                       else
                         tenth_counter = tenth_counter + 1;
                       next_state_adjust = STATE_D_2;
                     end
                   else next_state_adjust = STATE_D_2;
                   
       STATE_D_3 : if ( set_was_pressed ) next_state_adjust = STATE_D_4;
                   else if ( change_was_pressed ) 
                     begin
                       if ( second_counter == SECONDS_LIMIT )
                         second_counter = 4'd0;
                       else
                         second_counter = second_counter + 1;
                       next_state_adjust = STATE_D_3;
                     end
                   else next_state_adjust = STATE_D_3;
                   
       STATE_D_4 : if ( set_was_pressed ) next_state_adjust = STATE_DEFAULT;
                   else if ( change_was_pressed ) 
                     begin
                       if ( tenth_second_counter == HUNDREDTH_LIMIT )
                         tenth_second_counter = 4'd0;
                       else
                         tenth_second_counter = tenth_second_counter + 1;
                       next_state_adjust = STATE_D_4;
                     end
                   else next_state_adjust = STATE_D_4;
                   
       default   : next_state_adjust = STATE_DEFAULT;
     endcase
   end
 
 always @( posedge clk100_i or negedge rstn_i )
   begin
     if ( !rstn_i )
       state_adjust <= STATE_DEFAULT;
     else
       state_adjust <= next_state_adjust;
   end

//hex0-hex3 desc   
 hex hex0 ( 
  .in  ( hundredth_counter  ),
  .out ( hex0_o             )
  );
  
hex hex1 ( 
  .in  ( tenth_counter  ),
  .out ( hex1_o         )
  );
  
hex hex2 ( 
  .in  ( second_counter  ),
  .out ( hex2_o          )
  );
  
hex hex3 ( 
  .in  ( tenth_second_counter ),
  .out (  hex3_o              )
  ); 
       
endmodule
