// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Thu May  7 16:29:57 2020
// Host        : DESKTOP-U9TKJ0C running 64-bit major release  (build 9200)
// Command     : write_verilog -mode funcsim -nolib -force -file
//               D:/Verilog/lb_2/tmp/device/device.sim/sim_1/synth/func/xsim/main_tb_func_synth.v
// Design      : main_dev
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module dff_leds
   (Q,
    KEY_i_IBUF,
    D,
    CLK50_i_IBUF_BUFG);
  output [9:0]Q;
  input [1:0]KEY_i_IBUF;
  input [9:0]D;
  input CLK50_i_IBUF_BUFG;

  wire CLK50_i_IBUF_BUFG;
  wire [9:0]D;
  wire [1:0]KEY_i_IBUF;
  wire [9:0]Q;

  FDCE #(
    .INIT(1'b0)) 
    \q_o_reg[0] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(KEY_i_IBUF[0]),
        .CLR(KEY_i_IBUF[1]),
        .D(D[0]),
        .Q(Q[0]));
  FDCE #(
    .INIT(1'b0)) 
    \q_o_reg[1] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(KEY_i_IBUF[0]),
        .CLR(KEY_i_IBUF[1]),
        .D(D[1]),
        .Q(Q[1]));
  FDCE #(
    .INIT(1'b0)) 
    \q_o_reg[2] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(KEY_i_IBUF[0]),
        .CLR(KEY_i_IBUF[1]),
        .D(D[2]),
        .Q(Q[2]));
  FDCE #(
    .INIT(1'b0)) 
    \q_o_reg[3] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(KEY_i_IBUF[0]),
        .CLR(KEY_i_IBUF[1]),
        .D(D[3]),
        .Q(Q[3]));
  FDCE #(
    .INIT(1'b0)) 
    \q_o_reg[4] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(KEY_i_IBUF[0]),
        .CLR(KEY_i_IBUF[1]),
        .D(D[4]),
        .Q(Q[4]));
  FDCE #(
    .INIT(1'b0)) 
    \q_o_reg[5] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(KEY_i_IBUF[0]),
        .CLR(KEY_i_IBUF[1]),
        .D(D[5]),
        .Q(Q[5]));
  FDCE #(
    .INIT(1'b0)) 
    \q_o_reg[6] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(KEY_i_IBUF[0]),
        .CLR(KEY_i_IBUF[1]),
        .D(D[6]),
        .Q(Q[6]));
  FDCE #(
    .INIT(1'b0)) 
    \q_o_reg[7] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(KEY_i_IBUF[0]),
        .CLR(KEY_i_IBUF[1]),
        .D(D[7]),
        .Q(Q[7]));
  FDCE #(
    .INIT(1'b0)) 
    \q_o_reg[8] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(KEY_i_IBUF[0]),
        .CLR(KEY_i_IBUF[1]),
        .D(D[8]),
        .Q(Q[8]));
  FDCE #(
    .INIT(1'b0)) 
    \q_o_reg[9] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(KEY_i_IBUF[0]),
        .CLR(KEY_i_IBUF[1]),
        .D(D[9]),
        .Q(Q[9]));
endmodule

(* NotValidForBitStream *)
module main_dev
   (SW_i,
    KEY_i,
    CLK50_i,
    LEDR_i,
    HEX0_o,
    HEX1_o);
  input [9:0]SW_i;
  input [1:0]KEY_i;
  input CLK50_i;
  output [9:0]LEDR_i;
  output [6:0]HEX0_o;
  output [6:0]HEX1_o;

  wire CLK50_i;
  wire CLK50_i_IBUF;
  wire CLK50_i_IBUF_BUFG;
  wire [6:0]HEX0_o;
  wire [6:6]HEX0_o_OBUF;
  wire [6:0]HEX1_o;
  wire [1:0]KEY_i;
  wire [1:0]KEY_i_IBUF;
  wire [9:0]LEDR_i;
  wire [9:0]LEDR_i_OBUF;
  wire [9:0]SW_i;
  wire [9:0]SW_i_IBUF;

  BUFG CLK50_i_IBUF_BUFG_inst
       (.I(CLK50_i_IBUF),
        .O(CLK50_i_IBUF_BUFG));
  IBUF CLK50_i_IBUF_inst
       (.I(CLK50_i),
        .O(CLK50_i_IBUF));
  OBUF \HEX0_o_OBUF[0]_inst 
       (.I(1'b0),
        .O(HEX0_o[0]));
  OBUF \HEX0_o_OBUF[1]_inst 
       (.I(1'b0),
        .O(HEX0_o[1]));
  OBUF \HEX0_o_OBUF[2]_inst 
       (.I(1'b0),
        .O(HEX0_o[2]));
  OBUF \HEX0_o_OBUF[3]_inst 
       (.I(1'b0),
        .O(HEX0_o[3]));
  OBUF \HEX0_o_OBUF[4]_inst 
       (.I(1'b0),
        .O(HEX0_o[4]));
  OBUF \HEX0_o_OBUF[5]_inst 
       (.I(1'b0),
        .O(HEX0_o[5]));
  OBUF \HEX0_o_OBUF[6]_inst 
       (.I(HEX0_o_OBUF),
        .O(HEX0_o[6]));
  FDSE #(
    .INIT(1'b1)) 
    \HEX0_o_reg[6] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(1'b0),
        .D(1'b0),
        .Q(HEX0_o_OBUF),
        .S(KEY_i_IBUF[1]));
  FDRE #(
    .INIT(1'b0)) 
    \HEX0_o_reg[6]__0 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(1'b1),
        .D(1'b1),
        .Q(HEX0_o_OBUF),
        .R(1'b0));
  OBUF \HEX1_o_OBUF[0]_inst 
       (.I(1'b0),
        .O(HEX1_o[0]));
  OBUF \HEX1_o_OBUF[1]_inst 
       (.I(1'b0),
        .O(HEX1_o[1]));
  OBUF \HEX1_o_OBUF[2]_inst 
       (.I(1'b0),
        .O(HEX1_o[2]));
  OBUF \HEX1_o_OBUF[3]_inst 
       (.I(1'b0),
        .O(HEX1_o[3]));
  OBUF \HEX1_o_OBUF[4]_inst 
       (.I(1'b0),
        .O(HEX1_o[4]));
  OBUF \HEX1_o_OBUF[5]_inst 
       (.I(1'b0),
        .O(HEX1_o[5]));
  OBUF \HEX1_o_OBUF[6]_inst 
       (.I(1'b1),
        .O(HEX1_o[6]));
  IBUF \KEY_i_IBUF[0]_inst 
       (.I(KEY_i[0]),
        .O(KEY_i_IBUF[0]));
  IBUF \KEY_i_IBUF[1]_inst 
       (.I(KEY_i[1]),
        .O(KEY_i_IBUF[1]));
  OBUF \LEDR_i_OBUF[0]_inst 
       (.I(LEDR_i_OBUF[0]),
        .O(LEDR_i[0]));
  OBUF \LEDR_i_OBUF[1]_inst 
       (.I(LEDR_i_OBUF[1]),
        .O(LEDR_i[1]));
  OBUF \LEDR_i_OBUF[2]_inst 
       (.I(LEDR_i_OBUF[2]),
        .O(LEDR_i[2]));
  OBUF \LEDR_i_OBUF[3]_inst 
       (.I(LEDR_i_OBUF[3]),
        .O(LEDR_i[3]));
  OBUF \LEDR_i_OBUF[4]_inst 
       (.I(LEDR_i_OBUF[4]),
        .O(LEDR_i[4]));
  OBUF \LEDR_i_OBUF[5]_inst 
       (.I(LEDR_i_OBUF[5]),
        .O(LEDR_i[5]));
  OBUF \LEDR_i_OBUF[6]_inst 
       (.I(LEDR_i_OBUF[6]),
        .O(LEDR_i[6]));
  OBUF \LEDR_i_OBUF[7]_inst 
       (.I(LEDR_i_OBUF[7]),
        .O(LEDR_i[7]));
  OBUF \LEDR_i_OBUF[8]_inst 
       (.I(LEDR_i_OBUF[8]),
        .O(LEDR_i[8]));
  OBUF \LEDR_i_OBUF[9]_inst 
       (.I(LEDR_i_OBUF[9]),
        .O(LEDR_i[9]));
  IBUF \SW_i_IBUF[0]_inst 
       (.I(SW_i[0]),
        .O(SW_i_IBUF[0]));
  IBUF \SW_i_IBUF[1]_inst 
       (.I(SW_i[1]),
        .O(SW_i_IBUF[1]));
  IBUF \SW_i_IBUF[2]_inst 
       (.I(SW_i[2]),
        .O(SW_i_IBUF[2]));
  IBUF \SW_i_IBUF[3]_inst 
       (.I(SW_i[3]),
        .O(SW_i_IBUF[3]));
  IBUF \SW_i_IBUF[4]_inst 
       (.I(SW_i[4]),
        .O(SW_i_IBUF[4]));
  IBUF \SW_i_IBUF[5]_inst 
       (.I(SW_i[5]),
        .O(SW_i_IBUF[5]));
  IBUF \SW_i_IBUF[6]_inst 
       (.I(SW_i[6]),
        .O(SW_i_IBUF[6]));
  IBUF \SW_i_IBUF[7]_inst 
       (.I(SW_i[7]),
        .O(SW_i_IBUF[7]));
  IBUF \SW_i_IBUF[8]_inst 
       (.I(SW_i[8]),
        .O(SW_i_IBUF[8]));
  IBUF \SW_i_IBUF[9]_inst 
       (.I(SW_i[9]),
        .O(SW_i_IBUF[9]));
  dff_leds dff
       (.CLK50_i_IBUF_BUFG(CLK50_i_IBUF_BUFG),
        .D(SW_i_IBUF),
        .KEY_i_IBUF(KEY_i_IBUF),
        .Q(LEDR_i_OBUF));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
