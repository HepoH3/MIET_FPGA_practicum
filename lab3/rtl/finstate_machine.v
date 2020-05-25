`timescale 1ns / 1ps


module finstate_machine(
  input        clk_i,
  input        rstn_i,

  input        dev_run_i,
  input        set_i,
  input        change_i,

  output [2:0] state_value_o,
  output       inc_this_o,
  output       passed_all_o
  );

reg [2:0] state;
reg [2:0] next_state;   
reg       increm;

localparam RUN_STATE = 3'd0;
localparam CHANGE_H  = 3'd1;
localparam CHANGE_TS = 3'd2;
localparam CHANGE_S  = 3'd3;
localparam CHANGE_T  = 3'd4;

assign state_value_o = state;

reg    states_is_over;
assign passed_all = states_is_over;


always @( * ) begin
  if ( !rstn_i )
    increm     <= 1'b0;
  case ( state )
    RUN_STATE       :  if ( !dev_run_i ) 
                    if ( set_i )     next_state <= CHANGE_T;
                  else begin 
                   next_state <= RUN_STATE;
                   states_is_over <= 1'b0;
                  end

    CHANGE_T :   if ( set_i )     next_state <= CHANGE_S;
                 else begin       
                   if ( change_i )  increm     <= 1'b1;
                   else             increm     <= 1'b0;
                   next_state <= CHANGE_T;
                 end

    CHANGE_S :  if ( set_i )     next_state <= CHANGE_TS;
                 else begin       
                   if ( change_i )  increm     <= 1'b1;
                   else             increm     <= 1'b0;
                   next_state <= CHANGE_S;
                 end

    CHANGE_TS : if ( set_i )     next_state <= CHANGE_H;
                 else begin       
                   if ( change_i )  increm     <= 1'b1;
                   else             increm     <= 1'b0;
                   next_state <= CHANGE_TS;
                 end 

    CHANGE_H  : if ( set_i ) begin    
                  next_state     <= RUN_STATE;
                  states_is_over <= 1'b1; 
                end
                else begin
                  if ( change_i )  increm     <= 1'b1;
                  else             increm     <= 1'b0;
                  next_state <= CHANGE_H;
                end 
    default  :  next_state <= RUN_STATE;
  endcase
end

reg [1:0] btn_sync;

always @( posedge clk_i or negedge rstn_i ) begin
  if ( !rstn_i )
    btn_sync <= 2'b0;
  else begin
    btn_sync[0] <=  increm;
    btn_sync[1] <=  btn_sync[0];
  end
end

assign inc_this_o = ~btn_sync[1] & btn_sync[0];

always @( posedge clk_i or negedge rstn_i ) begin
  if ( !rstn_i ) 
    state <= RUN_STATE;
  else 
    state <= next_state;
end

endmodule