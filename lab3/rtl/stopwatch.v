module stopwatch(
  input          clk100_i,
  input          rstn_i,
  input          start_stop_i,
  input          set_i,
  input          change_i,
  output  [6:0]  hex0_o,
  output  [6:0]  hex1_o,
  output  [6:0]  hex2_o,
  output  [6:0]  hex3_o
  );

  // �����, �� ������� ������� ����������� (��� counter_4)
  // (�.�. ��� 10 �� ��������� �� 9 � ����������� �� ������)
  // ���
  // �����, �� ������� ������� ��������� (��� reset_block)
  // (�.�. ��� 10 �� ��������� �� 9 � �������������� ������ ������ �������� 1 � �������� �������� � ������� ���������������)
  parameter  BIT_DEPTH_OF_CLOCK = 4'd10;

  // ����� ��� ������� ms10_timer ��� ������� ����� 10�� �� ������� 100���
  parameter  TIME_LIMIT_10ms = 20'b11110100001000111111;

  wire         start_stop_s_reg;
  wire         set_s;
  wire         change_s;
  wire         rstn_s;
  wire  [2:0]  main_selector;

  wire  [3:0]  ms10_counter;
  wire  [3:0]  ms100_counter;
  wire  [3:0]  s1_counter;
  wire  [3:0]  s10_counter;

  key_processing io(
    .clk100_i            (  clk100_i            ),
    .rstn_i              (  rstn_i              ),
    .start_stop_i        (  start_stop_i        ),
    .set_i               (  set_i               ),
    .change_i            (  change_i            ),
    .start_stop_s_reg_o  (  start_stop_s_reg    ),
    .main_selector_i     (  main_selector[2:0]  ),
    .set_s_o             (  set_s               ),
    .change_s_o          (  change_s            ),
    .rstn_s_o            (  rstn_s              )
  );

  mode_selector switching(
    .clk100_i           (  clk100_i          ),
    .rstn_s_i           (  rstn_s            ),
    .start_stop_s_reg_i (  start_stop_s_reg  ),
    .set_s_i            (  set_s             ),
    .main_selector_o    (  main_selector     )
  );

  counter_array counting(
    .clk100_i            (  clk100_i                 ),
    .rstn_s_i            (  rstn_s                   ),
    .start_stop_s_reg_i  (  start_stop_s_reg         ),
    .change_s_i          (  change_s                 ),
    .BIT_DEPTH_OF_CLOCK  (  BIT_DEPTH_OF_CLOCK[3:0]  ),
    .TIME_LIMIT_10ms     (  TIME_LIMIT_10ms[19:0]    ),
    .main_selector_i     (  main_selector[2:0]       ),
    .ms10_counter_o      (  ms10_counter[3:0]        ),
    .ms100_counter_o     (  ms100_counter[3:0]       ),
    .s1_counter_o        (  s1_counter[3:0]          ),
    .s10_counter_o       (  s10_counter[3:0]         )
  );

  decoder_4 ms10_dec (
    .bit4_i     (  ms10_counter[3:0]  ),
    .segment_o  (  hex0_o[6:0]        )
  );

  decoder_4 ms100_dec (
    .bit4_i     (  ms100_counter[3:0]  ),
    .segment_o  (  hex1_o[6:0]         )
  );

  decoder_4 s1_dec (
    .bit4_i     (  s1_counter[3:0]  ),
    .segment_o  (  hex2_o[6:0]      )
  );

  decoder_4 s10_dec (
    .bit4_i     (  s10_counter[3:0]  ),
    .segment_o  (  hex3_o[6:0]       )
  );

endmodule
