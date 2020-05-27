`timescale 1ns / 1ps

module stopwatch_fs(
  input        clk_i,
  input        rstn_i,
  input        device_run_i,
  input        set_i,
  input        start_i,
  input        change_i,
  output [2:0] state_o,
  output       inc_o,
  output [3:0] q
);

reg [2:0] state;
reg [2:0] next_state;
reg       increm_ent;

localparam IDLE      = 3'd0;
localparam CHANGE_1  = 3'd1;
localparam CHANGE_2  = 3'd2;
localparam CHANGE_3  = 3'd3;
localparam CHANGE_4  = 3'd4;

assign state_o = state;

always @( posedge clk_i or negedge rstn_i )
  if( !rstn_i )
    state <= IDLE;
  else
    state <= next_state;

always @( * ) begin
  next_state = state;
  increm_ent = 1'b0;
  case( state )
    IDLE:
      begin
        if( !device_run_i )
          if( set_i & !start_i )
            next_state = CHANGE_1;
      end

    CHANGE_1:
      begin
        if( !device_run_i ) begin
          if( set_i & !start_i )
            next_state = CHANGE_2;
          if( change_i )
            increm_ent = 1'b1;
          else
            increm_ent = 1'b0;
        end
        else
          next_state = IDLE;
      end

    CHANGE_2:
      begin
        if( !device_run_i ) begin
          if( set_i & !start_i )
            next_state = CHANGE_3;
          if( change_i )
            increm_ent = 1'b1;
          else
            increm_ent = 1'b0;
        end
        else
          next_state = IDLE;
      end

    CHANGE_3:
      begin
        if( !device_run_i ) begin
          if( set_i & !start_i )
            next_state = CHANGE_4;
          if( change_i )
            increm_ent = 1'b1;
          else
            increm_ent = 1'b0;
        end
        else
          next_state = IDLE;
      end

    CHANGE_4:
      begin
        if( !device_run_i ) begin
          if( set_i & !start_i ) begin
            next_state = IDLE;
          end
          if( change_i )
            increm_ent = 1'b1;
          else
            increm_ent = 1'b0;
        end
        else
          next_state = IDLE;
    end

    default:
      begin
        next_state = IDLE;
      end
  endcase
end

assign inc_o = increm_ent;
assign q     = state;

endmodule
