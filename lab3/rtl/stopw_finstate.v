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


always @( * ) begin
  if ( !rstn_i )
    increm     <= 1'b0;
  case ( state )
    IDLE       :  if ( !dev_run_i ) 
                    if ( set_i )     next_state <= CHANGING_T;
                  else begin 
                   next_state <= IDLE;
                   states_is_over <= 1'b0;
                  end
                  
    CHANGING_T :  if ( !dev_run_i ) begin
                    if ( set_i )     next_state <= CHANGING_S;
                    if ( change_i )  increm     <= 1'b1;
                    else             increm     <= 1'b0;
                  end
                  else               next_state <= IDLE;
                  
    CHANGING_S :  if ( !dev_run_i ) begin
                    if ( set_i )     next_state <= CHANGING_TS;
                    if ( change_i )  increm     <= 1'b1;
                    else             increm     <= 1'b0;
                  end
                  else               next_state <= IDLE;
                  
    CHANGING_TS : if ( !dev_run_i ) begin
                    if ( set_i )     next_state <= CHANGING_H;
                    if ( change_i )  increm     <= 1'b1;
                    else             increm     <= 1'b0;
                  end
                  else               next_state <= IDLE; 
                  
    CHANGING_H  : if ( !dev_run_i ) begin
                    if ( set_i ) begin    
                                     next_state     <= IDLE;
                                     states_is_over <= 1'b1; 
                    end
                    if ( change_i )  increm     <= 1'b1;
                    else             increm     <= 1'b0;
                  end
                  else               next_state <= IDLE; 
                              
    default  :                       next_state <= IDLE;

  endcase
end

reg [1:0] button_syncroniser;

always @( posedge clk_i or negedge rstn_i ) begin
  if ( !rstn_i )
    button_syncroniser <= 2'b0;
  else begin
    button_syncroniser[0] <=  increm;
    button_syncroniser[1] <=  button_syncroniser[0];
  end
end

assign inc_this_o = ~button_syncroniser[1] & button_syncroniser[0];

always @( posedge clk_i or negedge rstn_i ) begin
  if ( !rstn_i ) 
    state <= IDLE;
  else 
    state <= next_state;
end



endmodule
