`timescale 1ns / 1ps

module StateMachine(
  input            clk_i,
  input            arstn_i,
  input            device_running_i,
  input            button_set_was_pressed,
  input            button_change_was_pressed,
  
  output reg [3:0] hundredths_counter  = 4'd0,
  output reg [3:0] tenths_counter      = 4'd0,
  output reg [3:0] seconds_counter     = 4'd0,
  output reg [3:0] ten_seconds_counter = 4'd0,
  output reg       state               = 1'd0
    );
    
localparam  DEFAULT             = 1'd0;
localparam  SET                 = 1'd1;
reg  [1:0]  current_hex         = 2'b0;
reg         next_state;

reg [3:0] hundredths_counter1  = 4'd0;
reg [3:0] tenths_counter1      = 4'd0;
reg [3:0] seconds_counter1     = 4'd0;
reg [3:0] ten_seconds_counter  = 4'd0;

always @( * ) 
begin
  case ( state )
    DEFAULT : if ( button_set_was_pressed && device_running_i )
                          next_state = SET;
                        else
                          next_state = DEFAULT;
    SET     : if ( current_hex == 2'd3 && button_set_was_pressed )
                          begin
                            next_state = DEFAULT;
                            current_hex = 2'b0;
                          end
                        else
                          next_state = SET;
  endcase
end

always @( posedge clk_i or negedge arstn_i )
begin
  if( !arstn_i )  
    state <= DEFAULT;
  else
    state <= next_state;
end

always @( posedge clk_i )
begin
  if ( state == SET ) 
  begin
    if ( button_set_was_pressed ) 
      current_hex <= current_hex + 1;
    if ( button_change_was_pressed )
    begin
       case (current_hex)
        2'd0  : hundredths_counter  <= hundredths_counter < 9 ? hundredths_counter + 1 : 0;
        2'd1  : tenths_counter      <= tenths_counter < 9 ? tenths_counter + 1 : 0;
        2'd2  : seconds_counter     <= seconds_counter < 9 ? seconds_counter + 1 : 0;
        2'd3  : ten_seconds_counter <= ten_seconds_counter < 9 ? ten_seconds_counter + 1 : 0;
      endcase
    end
  end
end

endmodule
