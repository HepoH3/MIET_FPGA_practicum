`timescale 1ns / 1ps

module initial_state_stopwatch(
  input            clk_i,
  input            rstn_i,
 
  input            dev_run_i,
  input            set_was_pressed_i,
  input            change_was_pressed_i,
  
  output reg [3:0] hund,
  output reg [3:0] tenth,
  output reg [3:0] sec,
  output reg [3:0] ten
  );

reg [2:0] state;
reg [2:0] next_state;   
   
localparam RUN_STATE    = 3'd0;
localparam CHANGE_HUND  = 3'd1;
localparam CHANGE_TENTH = 3'd2;
localparam CHANGE_SEC   = 3'd3;
localparam CHANGE_TEN   = 3'd4;

always @(*) 
   begin
     case ( state )
       RUN_STATE : if ( ( !dev_run_i ) & ( set_was_pressed_i ) ) 
                     next_state = CHANGE_TEN;
                   else 
                     next_state = RUN_STATE;
                     
       CHANGE_HUND : if ( set_was_pressed_i ) 
                       next_state = CHANGE_TENTH;
                     else if ( change_was_pressed_i ) 
                       begin 
                         if ( hund == 4'd9 )
                           hund = 4'd0;
                         else
                           hund = hund + 1;
                           next_state = CHANGE_HUND;
                       end
                     else 
                       next_state = CHANGE_HUND;

       CHANGE_TENTH : if ( set_was_pressed_i ) 
                        next_state = CHANGE_SEC;
                      else if ( change_was_pressed_i ) 
                        begin
                          if ( tenth == 4'd9 )
                            tenth = 4'd0;
                          else
                            tenth = tenth + 1;
                            next_state = CHANGE_TENTH;
                       end
                     else 
                       next_state = CHANGE_TENTH;

       CHANGE_SEC : if ( set_was_pressed_i ) 
                      next_state = CHANGE_TEN;
                    else if ( change_was_pressed_i ) 
                      begin
                        if ( sec == 4'd9 )
                          sec = 4'd0;
                        else
                          sec = sec + 1;
                          next_state = CHANGE_SEC;
                      end
                    else 
                      next_state = CHANGE_SEC;

       CHANGE_TEN : if ( set_was_pressed_i )
                      next_state = RUN_STATE;
                    else if ( change_was_pressed_i ) 
                      begin
                        if ( ten == 4'd9 )
                          ten = 4'd0;
                        else
                          ten = ten + 1;
                          next_state = CHANGE_TEN;
                      end
                   else 
                     next_state = CHANGE_TEN;

       default : next_state = RUN_STATE;
     endcase
   end 

always @( posedge clk_i or negedge rstn_i ) begin
  if ( !rstn_i ) begin
    state <= RUN_STATE;
    ten   <= 4'b0;
    sec   <= 4'b0;
    tenth <= 4'b0;
    hund  <= 4'b0;
  end
  else 
    state <= next_state;
end

endmodule

