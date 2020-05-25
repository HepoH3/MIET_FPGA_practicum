module button_sync (
  input   clk100_i,
  input   start_stop_i,
  input   set_i,
  input   change_i,
  output  btn_start_was_pressed,
  output  btn_set_was_pressed,
  output  btn_change_was_pressed
);


//Start-stop button synch
reg  [1:0] btn_start_sync;

always @( posedge clk100_i )
begin
  btn_start_sync[0] <= ~start_stop_i;
  btn_start_sync[1] <= btn_start_sync[0];
end
assign btn_start_was_pressed = ~btn_start_sync[1] & btn_start_sync[0];




// SET button synch
reg  [1:0] btn_set_sync;

always @( posedge clk100_i )
begin
  btn_set_sync[0] <= ~set_i;
  btn_set_sync[1] <= btn_set_sync[0];
end
assign btn_set_was_pressed = ~btn_set_sync[1] & btn_set_sync[0];


//Change butthon sync
reg  [1:0] btn_change_sync;

always @( posedge clk100_i )
begin
  btn_change_sync[0] <= ~change_i;
  btn_change_sync[1] <= btn_change_sync[0];
end
assign btn_change_was_pressed = ~btn_change_sync[1] & btn_change_sync[0];



endmodule