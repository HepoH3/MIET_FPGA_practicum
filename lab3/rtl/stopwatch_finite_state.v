`timescale 1ns / 1ps

module stopwatch_finite_state(
  input        clk_i,
  input        rstn_i,
  input        dev_run_i,
  input        set_i,
  input        start_i,
  input        change_i,
  output [2:0] state_value_o,
  output       inc_this_o,
  output [3:0] cnt
);

reg [2:0] state;
reg [2:0] next_state;
reg       increm;

localparam IDLE_S        = 3'd0;
localparam CHANGE_H_S    = 3'd1;
localparam CHANGE_TS_S   = 3'd2;
localparam CHANGE_SEC_S  = 3'd3;
localparam CHANGE_T_S    = 3'd4;

assign state_value_o = state;

always @( posedge clk_i or negedge rstn_i )
  if( !rstn_i )
    state <= IDLE_S;
  else
    state <= next_state;

always @( * ) begin
  next_state = state;
  increm     = 1'b0;
  case( state )
    IDLE_S:
      begin
        if( !dev_run_i )
          if( set_i & !start_i )
            next_state = CHANGE_H_S;
      end

    CHANGE_H_S:
      begin
        if( !dev_run_i ) begin
          if( set_i & !start_i )
            next_state = CHANGE_TS_S;
          if( change_i )
            increm = 1'b1;
          else
            increm = 1'b0;
        end
        else
          next_state = IDLE_S;
      end

    CHANGE_TS_S:
      begin
        if( !dev_run_i ) begin
          if( set_i & !start_i )
            next_state = CHANGE_SEC_S;
          if( change_i )
            increm = 1'b1;
          else
            increm = 1'b0;
        end
        else
          next_state = IDLE_S;
      end

    CHANGE_SEC_S:
      begin
        if( !dev_run_i ) begin
          if( set_i & !start_i )
            next_state = CHANGE_T_S;
          if( change_i )
            increm = 1'b1;
          else
            increm = 1'b0;
        end
        else
          next_state = IDLE_S;
      end

    CHANGE_T_S:
      begin
        if( !dev_run_i ) begin
          if( set_i & !start_i ) begin
            next_state = IDLE_S;
          end
          if( change_i )
            increm = 1'b1;
          else
            increm = 1'b0;
        end
        else
          next_state = IDLE_S;
    end

    default:
      begin
        next_state = IDLE_S;
      end
  endcase
end

assign inc_this_o = increm;
assign cnt        = state;

endmodule