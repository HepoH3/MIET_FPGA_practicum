`timescale 1ns / 1ps


module stopw_finstate(
  input        clk_i,
  input        rstn_i,
 
  input        dev_run_i,
  input        set_i,
  input        change_i,
  
  output [2:0] state_value_o,
  output       inc_this_o,
  output       passed_all
  
  );

reg [2:0] state;
reg [2:0] next_state;   
reg       increm;
   
localparam IDLE        = 3'd0;
localparam CHANGING_H  = 3'd1;
localparam CHANGING_TS = 3'd2;
localparam CHANGING_S  = 3'd3;
localparam CHANGING_T  = 3'd4;



assign state_value_o = state;

reg    states_is_over;


assign passed_all = states_is_over;


assign inc_this_o = increm;

always @( * ) begin
  next_state = state;
  if ( !rstn_i )
    increm = 1'b0;
  case ( state )
    IDLE: 
      begin
        states_is_over = 1'b0;
        if ( !dev_run_i ) 
          if ( set_i )
            next_state = CHANGING_T; 
         else
            next_state = IDLE;
      end
                  
    CHANGING_T: 
      begin
        if ( !dev_run_i ) begin
          if ( change_i )
            increm = 1'b1;
          else
            increm = 1'b0;
          if ( set_i )     
            next_state = CHANGING_S;
         end
         else next_state = IDLE;
       end
                  
    CHANGING_S: 
      begin
        if ( !dev_run_i ) begin
          if ( change_i )
            increm = 1'b1;
          else 
            increm = 1'b0;
          if ( set_i )     
            next_state = CHANGING_TS;
         end
         else next_state = IDLE;
       end
                  
    CHANGING_TS: 
      begin
        if ( !dev_run_i ) begin
          if ( change_i )
            increm = 1'b1;
          else
            increm = 1'b0;
          if ( set_i )     
            next_state = CHANGING_H;
         end
         else next_state = IDLE;
       end
                  
    CHANGING_H:
     begin
       if ( !dev_run_i ) begin
         if ( change_i )
           increm = 1'b1;
         else
           increm = 1'b0;
         if ( set_i ) begin    
          next_state     = IDLE;
          states_is_over = 1'b1; 
         end
       end
          else next_state = IDLE; 
      end
                              
    default:
      next_state = IDLE;

  endcase
end

reg [1:0] button_syncroniser;

always @( posedge clk_i or negedge rstn_i ) begin
  if ( !rstn_i ) 
    state <= IDLE;
  else 
    state <= next_state;
end



endmodule