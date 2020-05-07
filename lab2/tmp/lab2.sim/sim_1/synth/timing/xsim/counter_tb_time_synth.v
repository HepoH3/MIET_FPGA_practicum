// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Thu May  7 02:47:28 2020
// Host        : DESKTOP-3LLU7JK running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               D:/Vivado/lab2/tmp/lab2.sim/sim_1/synth/timing/xsim/counter_tb_time_synth.v
// Design      : counter
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

(* NotValidForBitStream *)
module counter
   (en_i,
    clk_i,
    rstn_i,
    SW,
    counter_o);
  input en_i;
  input clk_i;
  input rstn_i;
  input [9:0]SW;
  output [7:0]counter_o;

  wire [9:0]SW;
  wire [9:0]SW_IBUF;
  wire clk_i;
  wire clk_i_IBUF;
  wire clk_i_IBUF_BUFG;
  wire [7:0]counter_o;
  wire \counter_o[7]_i_10_n_0 ;
  wire \counter_o[7]_i_11_n_0 ;
  wire \counter_o[7]_i_12_n_0 ;
  wire \counter_o[7]_i_1_n_0 ;
  wire \counter_o[7]_i_3_n_0 ;
  wire \counter_o[7]_i_4_n_0 ;
  wire \counter_o[7]_i_5_n_0 ;
  wire \counter_o[7]_i_6_n_0 ;
  wire \counter_o[7]_i_7_n_0 ;
  wire \counter_o[7]_i_8_n_0 ;
  wire \counter_o[7]_i_9_n_0 ;
  wire [7:0]counter_o_OBUF;
  wire en_i;
  wire en_i_IBUF;
  wire p_0_in;
  wire [1:1]p_0_in__0;
  wire [7:0]p_0_in__1;
  wire p_1_in;
  wire rstn_i;
  wire rstn_i_IBUF;

initial begin
 $sdf_annotate("counter_tb_time_synth.sdf",,,,"tool_control");
end
  IBUF \SW_IBUF[0]_inst 
       (.I(SW[0]),
        .O(SW_IBUF[0]));
  IBUF \SW_IBUF[1]_inst 
       (.I(SW[1]),
        .O(SW_IBUF[1]));
  IBUF \SW_IBUF[2]_inst 
       (.I(SW[2]),
        .O(SW_IBUF[2]));
  IBUF \SW_IBUF[3]_inst 
       (.I(SW[3]),
        .O(SW_IBUF[3]));
  IBUF \SW_IBUF[4]_inst 
       (.I(SW[4]),
        .O(SW_IBUF[4]));
  IBUF \SW_IBUF[5]_inst 
       (.I(SW[5]),
        .O(SW_IBUF[5]));
  IBUF \SW_IBUF[6]_inst 
       (.I(SW[6]),
        .O(SW_IBUF[6]));
  IBUF \SW_IBUF[7]_inst 
       (.I(SW[7]),
        .O(SW_IBUF[7]));
  IBUF \SW_IBUF[8]_inst 
       (.I(SW[8]),
        .O(SW_IBUF[8]));
  IBUF \SW_IBUF[9]_inst 
       (.I(SW[9]),
        .O(SW_IBUF[9]));
  FDRE #(
    .INIT(1'b0)) 
    \button_syncroniser_reg[0] 
       (.C(clk_i_IBUF_BUFG),
        .CE(1'b1),
        .D(en_i_IBUF),
        .Q(p_0_in__0),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \button_syncroniser_reg[1] 
       (.C(clk_i_IBUF_BUFG),
        .CE(1'b1),
        .D(p_0_in__0),
        .Q(p_1_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \button_syncroniser_reg[2] 
       (.C(clk_i_IBUF_BUFG),
        .CE(1'b1),
        .D(p_1_in),
        .Q(p_0_in),
        .R(1'b0));
  BUFG clk_i_IBUF_BUFG_inst
       (.I(clk_i_IBUF),
        .O(clk_i_IBUF_BUFG));
  IBUF clk_i_IBUF_inst
       (.I(clk_i),
        .O(clk_i_IBUF));
  LUT1 #(
    .INIT(2'h1)) 
    \counter_o[0]_i_1 
       (.I0(counter_o_OBUF[0]),
        .O(p_0_in__1[0]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \counter_o[1]_i_1 
       (.I0(counter_o_OBUF[0]),
        .I1(counter_o_OBUF[1]),
        .O(p_0_in__1[1]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \counter_o[2]_i_1 
       (.I0(counter_o_OBUF[0]),
        .I1(counter_o_OBUF[1]),
        .I2(counter_o_OBUF[2]),
        .O(p_0_in__1[2]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \counter_o[3]_i_1 
       (.I0(counter_o_OBUF[1]),
        .I1(counter_o_OBUF[0]),
        .I2(counter_o_OBUF[2]),
        .I3(counter_o_OBUF[3]),
        .O(p_0_in__1[3]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \counter_o[4]_i_1 
       (.I0(counter_o_OBUF[2]),
        .I1(counter_o_OBUF[0]),
        .I2(counter_o_OBUF[1]),
        .I3(counter_o_OBUF[3]),
        .I4(counter_o_OBUF[4]),
        .O(p_0_in__1[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \counter_o[5]_i_1 
       (.I0(counter_o_OBUF[3]),
        .I1(counter_o_OBUF[1]),
        .I2(counter_o_OBUF[0]),
        .I3(counter_o_OBUF[2]),
        .I4(counter_o_OBUF[4]),
        .I5(counter_o_OBUF[5]),
        .O(p_0_in__1[5]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \counter_o[6]_i_1 
       (.I0(\counter_o[7]_i_6_n_0 ),
        .I1(counter_o_OBUF[6]),
        .O(p_0_in__1[6]));
  LUT4 #(
    .INIT(16'h00A8)) 
    \counter_o[7]_i_1 
       (.I0(p_1_in),
        .I1(\counter_o[7]_i_4_n_0 ),
        .I2(\counter_o[7]_i_5_n_0 ),
        .I3(p_0_in),
        .O(\counter_o[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \counter_o[7]_i_10 
       (.I0(SW_IBUF[9]),
        .I1(SW_IBUF[7]),
        .I2(SW_IBUF[8]),
        .O(\counter_o[7]_i_10_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \counter_o[7]_i_11 
       (.I0(SW_IBUF[3]),
        .I1(SW_IBUF[1]),
        .I2(SW_IBUF[2]),
        .O(\counter_o[7]_i_11_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hE8)) 
    \counter_o[7]_i_12 
       (.I0(SW_IBUF[4]),
        .I1(SW_IBUF[5]),
        .I2(SW_IBUF[6]),
        .O(\counter_o[7]_i_12_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \counter_o[7]_i_2 
       (.I0(\counter_o[7]_i_6_n_0 ),
        .I1(counter_o_OBUF[6]),
        .I2(counter_o_OBUF[7]),
        .O(p_0_in__1[7]));
  LUT1 #(
    .INIT(2'h1)) 
    \counter_o[7]_i_3 
       (.I0(rstn_i_IBUF),
        .O(\counter_o[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hF666666066606000)) 
    \counter_o[7]_i_4 
       (.I0(\counter_o[7]_i_7_n_0 ),
        .I1(\counter_o[7]_i_8_n_0 ),
        .I2(\counter_o[7]_i_9_n_0 ),
        .I3(\counter_o[7]_i_10_n_0 ),
        .I4(SW_IBUF[0]),
        .I5(\counter_o[7]_i_11_n_0 ),
        .O(\counter_o[7]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hFFE8E800)) 
    \counter_o[7]_i_5 
       (.I0(SW_IBUF[9]),
        .I1(SW_IBUF[8]),
        .I2(SW_IBUF[7]),
        .I3(\counter_o[7]_i_12_n_0 ),
        .I4(\counter_o[7]_i_8_n_0 ),
        .O(\counter_o[7]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \counter_o[7]_i_6 
       (.I0(counter_o_OBUF[5]),
        .I1(counter_o_OBUF[3]),
        .I2(counter_o_OBUF[1]),
        .I3(counter_o_OBUF[0]),
        .I4(counter_o_OBUF[2]),
        .I5(counter_o_OBUF[4]),
        .O(\counter_o[7]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    \counter_o[7]_i_7 
       (.I0(SW_IBUF[6]),
        .I1(SW_IBUF[5]),
        .I2(SW_IBUF[4]),
        .I3(SW_IBUF[9]),
        .I4(SW_IBUF[8]),
        .I5(SW_IBUF[7]),
        .O(\counter_o[7]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hE8)) 
    \counter_o[7]_i_8 
       (.I0(SW_IBUF[1]),
        .I1(SW_IBUF[2]),
        .I2(SW_IBUF[3]),
        .O(\counter_o[7]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \counter_o[7]_i_9 
       (.I0(SW_IBUF[6]),
        .I1(SW_IBUF[4]),
        .I2(SW_IBUF[5]),
        .O(\counter_o[7]_i_9_n_0 ));
  OBUF \counter_o_OBUF[0]_inst 
       (.I(counter_o_OBUF[0]),
        .O(counter_o[0]));
  OBUF \counter_o_OBUF[1]_inst 
       (.I(counter_o_OBUF[1]),
        .O(counter_o[1]));
  OBUF \counter_o_OBUF[2]_inst 
       (.I(counter_o_OBUF[2]),
        .O(counter_o[2]));
  OBUF \counter_o_OBUF[3]_inst 
       (.I(counter_o_OBUF[3]),
        .O(counter_o[3]));
  OBUF \counter_o_OBUF[4]_inst 
       (.I(counter_o_OBUF[4]),
        .O(counter_o[4]));
  OBUF \counter_o_OBUF[5]_inst 
       (.I(counter_o_OBUF[5]),
        .O(counter_o[5]));
  OBUF \counter_o_OBUF[6]_inst 
       (.I(counter_o_OBUF[6]),
        .O(counter_o[6]));
  OBUF \counter_o_OBUF[7]_inst 
       (.I(counter_o_OBUF[7]),
        .O(counter_o[7]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_o_reg[0] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\counter_o[7]_i_1_n_0 ),
        .CLR(\counter_o[7]_i_3_n_0 ),
        .D(p_0_in__1[0]),
        .Q(counter_o_OBUF[0]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_o_reg[1] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\counter_o[7]_i_1_n_0 ),
        .CLR(\counter_o[7]_i_3_n_0 ),
        .D(p_0_in__1[1]),
        .Q(counter_o_OBUF[1]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_o_reg[2] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\counter_o[7]_i_1_n_0 ),
        .CLR(\counter_o[7]_i_3_n_0 ),
        .D(p_0_in__1[2]),
        .Q(counter_o_OBUF[2]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_o_reg[3] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\counter_o[7]_i_1_n_0 ),
        .CLR(\counter_o[7]_i_3_n_0 ),
        .D(p_0_in__1[3]),
        .Q(counter_o_OBUF[3]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_o_reg[4] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\counter_o[7]_i_1_n_0 ),
        .CLR(\counter_o[7]_i_3_n_0 ),
        .D(p_0_in__1[4]),
        .Q(counter_o_OBUF[4]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_o_reg[5] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\counter_o[7]_i_1_n_0 ),
        .CLR(\counter_o[7]_i_3_n_0 ),
        .D(p_0_in__1[5]),
        .Q(counter_o_OBUF[5]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_o_reg[6] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\counter_o[7]_i_1_n_0 ),
        .CLR(\counter_o[7]_i_3_n_0 ),
        .D(p_0_in__1[6]),
        .Q(counter_o_OBUF[6]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_o_reg[7] 
       (.C(clk_i_IBUF_BUFG),
        .CE(\counter_o[7]_i_1_n_0 ),
        .CLR(\counter_o[7]_i_3_n_0 ),
        .D(p_0_in__1[7]),
        .Q(counter_o_OBUF[7]));
  IBUF en_i_IBUF_inst
       (.I(en_i),
        .O(en_i_IBUF));
  IBUF rstn_i_IBUF_inst
       (.I(rstn_i),
        .O(rstn_i_IBUF));
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
