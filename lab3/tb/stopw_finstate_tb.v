`timescale 1ns / 1ps



module stopw_finstate_tb(
);
reg       clk_i;
reg       rstn_i;
 
reg        dev_run_i;
reg        set_i;
reg        change_i;
  
wire [2:0] state_value_o;
wire       inc_this_o;

stopw_finstate DUT(
.clk_i(clk_i),
.rstn_i(rstn_i),
.dev_run_i(dev_run_i),
.set_i(set_i),
.change_i(change_i),
.state_value_o(state_value_o),
.inc_this_o(inc_this_o)
);

initial begin
clk_i <= 0;
forever #9 clk_i<=~clk_i;
end

initial begin
rstn_i <= 1;
#12 rstn_i <= 0;
#4 rstn_i <= 1;
end

initial begin 
dev_run_i<=1;
#30 dev_run_i <= 0;
#150 dev_run_i <= 1;
end

initial begin 
set_i <= 0;
#5 set_i <= 1;
#23 set_i <=0;
#34 set_i <= 1;
#21 set_i <= 0;
#150 set_i <= 1;
end

initial begin 
change_i <= 0;
#43 change_i <= 1;
#25 change_i <= 0;
#21 change_i <= 1;
#19 change_i <= 0;
end
endmodule
