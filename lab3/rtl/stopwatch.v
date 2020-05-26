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
//Button sync
wire start_stop_was_pressed;
pressButton StartStop(
  .clk_i                      ( clk100_i                  ),
  .arstn_i                    ( rstn_i                    ),
  .button_i                   ( start_stop_i              ),
  .button_down_o              ( start_stop_was_pressed    )
    );

wire set_was_pressed;
pressButton Set(
  .clk_i                     ( clk100_i                    ),
  .arstn_i                   ( rstn_i                      ),
  .button_i                  ( set_i                       ),
  .button_down_o             ( set_was_pressed             )
    );

wire change_was_pressed;
pressButton Change(
  .clk_i                     ( clk100_i                    ),
  .arstn_i                   ( rstn_i                      ),
  .button_i                  ( change_i                    ),
  .button_down_o             ( change_was_pressed          )
    );

//
wire [3:0] hundredths_o;
wire [3:0] tenths_o;
wire [3:0] seconds_o;
wire [3:0] ten_seconds_o;
wire       state;
wire       device_running;
StateMachine lol(
  .clk_i                     ( clk100_i                    ),
  .arstn_i                   ( rstn_i                      ),
  .device_running_i          ( device_running              ),
  .button_set_was_pressed    ( set_was_pressed             ),
  .button_change_was_pressed ( change_was_pressed          ),
  .hundredths_counter        ( hundredths_o                ),
  .tenths_counter            ( tenths_o                    ),
  .seconds_counter           ( seconds_o                   ),
  .ten_seconds_counter       ( ten_seconds_o               ),
  .state                     ( state                       )
);
//Device running

device_enable #(0) Running(
  .clk_i                     ( clk100_i                    ),
  .buttonn_was_pressed       ( start_stop_was_pressed      ),
  .state_device              ( state                       ),
  .signal_o                  ( device_running              )
);
//Pulse counter
wire hundredths_of_second_passed;
pulse_counter #(17,10) Pulse(
  .clk_i                     ( clk100_i                    ),
  .arstn_i                   ( rstn_i                      ),
  .device_running_i          ( device_running              ),
  .signal_o                  ( hundredths_of_second_passed )
);
//Stopwatch
wire       tenths_of_second_passed;
wire [3:0] hex0_i;
stopwatch_counter #(9) hundredths_of_second(
  .clk_i                     ( clk100_i                    ),
  .arstn_i                   ( rstn_i                      ),
  .pulse_passed              ( hundredths_of_second_passed ),
  .senior_digit_passed       ( tenths_of_second_passed     ),
  .hex_number                ( hex0_i                      ),
  .digit_counter             ( hundredths_o                )
);

wire       second_passed;
wire [3:0] hex1_i;
stopwatch_counter #(9) tenths_of_second(
  .clk_i                     ( clk100_i                    ),
  .arstn_i                   ( rstn_i                      ),
  .pulse_passed              ( tenths_of_second_passed     ),
  .senior_digit_passed       ( second_passed               ),
  .hex_number                ( hex1_i                      ),
  .digit_counter             ( tenths_o                    )
);

wire       ten_seconds_passed;
wire [3:0] hex2_i;
stopwatch_counter #(9) seconds(
  .clk_i                    ( clk100_i                    ),
  .arstn_i                  ( rstn_i                      ),
  .pulse_passed             ( second_passed               ),
  .senior_digit_passed      ( ten_seconds_passed          ),
  .hex_number               ( hex2_i                      ),
  .digit_counter            ( seconds_o                   )
);

wire [3:0] hex3_i;
stopwatch_counter #(9) ten_seconds(
  .clk_i               ( clk100_i                    ),
  .arstn_i             ( rstn_i                      ),
  .pulse_passed        ( ten_seconds_passed          ),
  .hex_number          ( hex3_i                      ),
  .digit_counter       ( ten_seconds_o               )
);
//DC block
DC_HEX hex0(
  .signal_i            ( hex0_i                      ),
  .signal_o            ( hex0_o                      )
);

DC_HEX hex1(
  .signal_i            ( hex1_i                      ),
  .signal_o            ( hex1_o                      )
);

DC_HEX hex2(
  .signal_i            ( hex2_i                      ),
  .signal_o            ( hex2_o                      )
);

DC_HEX hex3(
  .signal_i            ( hex3_i                      ),
  .signal_o            ( hex3_o                      )
);

endmodule