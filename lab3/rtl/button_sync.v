module button_sync (
  input   clk100_i,
  input   btn_i,
  output  btn_was_pressed
);


reg  [1:0] btn_start_sync;

always @( posedge clk100_i )
begin
  btn_start_sync[0] <= ~btn_i;
  btn_start_sync[1] <= btn_start_sync[0];
end
assign btn_was_pressed = ~btn_start_sync[1] & btn_start_sync[0];

endmodule