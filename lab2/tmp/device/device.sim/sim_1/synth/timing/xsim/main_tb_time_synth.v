// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (win64) Build 2708876 Wed Nov  6 21:40:23 MST 2019
// Date        : Thu May  7 18:49:06 2020
// Host        : DESKTOP-U9TKJ0C running 64-bit major release  (build 9200)
// Command     : write_verilog -mode timesim -nolib -sdf_anno true -force -file
//               D:/Verilog/lb_2/tmp/device/device.sim/sim_1/synth/timing/xsim/main_tb_time_synth.v
// Design      : main_dev
// Purpose     : This verilog netlist is a timing simulation representation of the design and should not be modified or
//               synthesized. Please ensure that this netlist is used with the corresponding SDF file.
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps
`define XIL_TIMING

module count_event
   (D,
    \counter_o_reg[7]_0 ,
    CLK,
    E,
    \counter_o_reg[3]_0 ,
    \counter_o_reg[0]_0 );
  output [6:0]D;
  output [6:0]\counter_o_reg[7]_0 ;
  input CLK;
  input [0:0]E;
  input \counter_o_reg[3]_0 ;
  input [9:0]\counter_o_reg[0]_0 ;

  wire CLK;
  wire [6:0]D;
  wire [0:0]E;
  wire \counter_o[0]_i_1_n_0 ;
  wire \counter_o[1]_i_1_n_0 ;
  wire \counter_o[6]_i_2_n_0 ;
  wire \counter_o[7]_i_10_n_0 ;
  wire \counter_o[7]_i_11_n_0 ;
  wire \counter_o[7]_i_1_n_0 ;
  wire \counter_o[7]_i_3_n_0 ;
  wire \counter_o[7]_i_4_n_0 ;
  wire \counter_o[7]_i_5_n_0 ;
  wire \counter_o[7]_i_6_n_0 ;
  wire \counter_o[7]_i_7_n_0 ;
  wire \counter_o[7]_i_8_n_0 ;
  wire \counter_o[7]_i_9_n_0 ;
  wire [9:0]\counter_o_reg[0]_0 ;
  wire \counter_o_reg[3]_0 ;
  wire [6:0]\counter_o_reg[7]_0 ;
  wire \counter_o_reg_n_0_[0] ;
  wire \counter_o_reg_n_0_[1] ;
  wire \counter_o_reg_n_0_[2] ;
  wire \counter_o_reg_n_0_[3] ;
  wire [1:1]p_0_in;
  wire p_0_in_0;
  wire [7:2]p_0_in__0;
  wire p_1_in;
  wire [3:0]sel0;

  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h2094)) 
    \HEX0_o[0]_i_1 
       (.I0(\counter_o_reg_n_0_[3] ),
        .I1(\counter_o_reg_n_0_[2] ),
        .I2(\counter_o_reg_n_0_[0] ),
        .I3(\counter_o_reg_n_0_[1] ),
        .O(D[0]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'hA4C8)) 
    \HEX0_o[1]_i_1 
       (.I0(\counter_o_reg_n_0_[3] ),
        .I1(\counter_o_reg_n_0_[2] ),
        .I2(\counter_o_reg_n_0_[1] ),
        .I3(\counter_o_reg_n_0_[0] ),
        .O(D[1]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'hA210)) 
    \HEX0_o[2]_i_1 
       (.I0(\counter_o_reg_n_0_[3] ),
        .I1(\counter_o_reg_n_0_[0] ),
        .I2(\counter_o_reg_n_0_[1] ),
        .I3(\counter_o_reg_n_0_[2] ),
        .O(D[2]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'hC214)) 
    \HEX0_o[3]_i_1 
       (.I0(\counter_o_reg_n_0_[3] ),
        .I1(\counter_o_reg_n_0_[2] ),
        .I2(\counter_o_reg_n_0_[0] ),
        .I3(\counter_o_reg_n_0_[1] ),
        .O(D[3]));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'h5710)) 
    \HEX0_o[4]_i_1 
       (.I0(\counter_o_reg_n_0_[3] ),
        .I1(\counter_o_reg_n_0_[1] ),
        .I2(\counter_o_reg_n_0_[2] ),
        .I3(\counter_o_reg_n_0_[0] ),
        .O(D[4]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h5190)) 
    \HEX0_o[5]_i_1 
       (.I0(\counter_o_reg_n_0_[3] ),
        .I1(\counter_o_reg_n_0_[2] ),
        .I2(\counter_o_reg_n_0_[0] ),
        .I3(\counter_o_reg_n_0_[1] ),
        .O(D[5]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT4 #(
    .INIT(16'h4025)) 
    \HEX0_o[6]_i_1 
       (.I0(\counter_o_reg_n_0_[3] ),
        .I1(\counter_o_reg_n_0_[0] ),
        .I2(\counter_o_reg_n_0_[2] ),
        .I3(\counter_o_reg_n_0_[1] ),
        .O(D[6]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h2094)) 
    \HEX1_o[0]_i_1 
       (.I0(sel0[3]),
        .I1(sel0[2]),
        .I2(sel0[0]),
        .I3(sel0[1]),
        .O(\counter_o_reg[7]_0 [0]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'hA4C8)) 
    \HEX1_o[1]_i_1 
       (.I0(sel0[3]),
        .I1(sel0[2]),
        .I2(sel0[1]),
        .I3(sel0[0]),
        .O(\counter_o_reg[7]_0 [1]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'hA210)) 
    \HEX1_o[2]_i_1 
       (.I0(sel0[3]),
        .I1(sel0[0]),
        .I2(sel0[1]),
        .I3(sel0[2]),
        .O(\counter_o_reg[7]_0 [2]));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT4 #(
    .INIT(16'hC214)) 
    \HEX1_o[3]_i_1 
       (.I0(sel0[3]),
        .I1(sel0[2]),
        .I2(sel0[0]),
        .I3(sel0[1]),
        .O(\counter_o_reg[7]_0 [3]));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'h5710)) 
    \HEX1_o[4]_i_1 
       (.I0(sel0[3]),
        .I1(sel0[1]),
        .I2(sel0[2]),
        .I3(sel0[0]),
        .O(\counter_o_reg[7]_0 [4]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT4 #(
    .INIT(16'h5190)) 
    \HEX1_o[5]_i_1 
       (.I0(sel0[3]),
        .I1(sel0[2]),
        .I2(sel0[0]),
        .I3(sel0[1]),
        .O(\counter_o_reg[7]_0 [5]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT4 #(
    .INIT(16'h4025)) 
    \HEX1_o[6]_i_1 
       (.I0(sel0[3]),
        .I1(sel0[0]),
        .I2(sel0[2]),
        .I3(sel0[1]),
        .O(\counter_o_reg[7]_0 [6]));
  LUT1 #(
    .INIT(2'h1)) 
    \counter_o[0]_i_1 
       (.I0(\counter_o_reg_n_0_[0] ),
        .O(\counter_o[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT2 #(
    .INIT(4'h6)) 
    \counter_o[1]_i_1 
       (.I0(\counter_o_reg_n_0_[0] ),
        .I1(\counter_o_reg_n_0_[1] ),
        .O(\counter_o[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \counter_o[2]_i_1 
       (.I0(\counter_o_reg_n_0_[0] ),
        .I1(\counter_o_reg_n_0_[1] ),
        .I2(\counter_o_reg_n_0_[2] ),
        .O(p_0_in__0[2]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT4 #(
    .INIT(16'h7F80)) 
    \counter_o[3]_i_1 
       (.I0(\counter_o_reg_n_0_[1] ),
        .I1(\counter_o_reg_n_0_[0] ),
        .I2(\counter_o_reg_n_0_[2] ),
        .I3(\counter_o_reg_n_0_[3] ),
        .O(p_0_in__0[3]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h7FFF8000)) 
    \counter_o[4]_i_1 
       (.I0(\counter_o_reg_n_0_[2] ),
        .I1(\counter_o_reg_n_0_[0] ),
        .I2(\counter_o_reg_n_0_[1] ),
        .I3(\counter_o_reg_n_0_[3] ),
        .I4(sel0[0]),
        .O(p_0_in__0[4]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \counter_o[5]_i_1 
       (.I0(\counter_o_reg_n_0_[3] ),
        .I1(\counter_o_reg_n_0_[1] ),
        .I2(\counter_o_reg_n_0_[0] ),
        .I3(\counter_o_reg_n_0_[2] ),
        .I4(sel0[0]),
        .I5(sel0[1]),
        .O(p_0_in__0[5]));
  LUT6 #(
    .INIT(64'h7FFFFFFF80000000)) 
    \counter_o[6]_i_1 
       (.I0(sel0[0]),
        .I1(\counter_o_reg_n_0_[2] ),
        .I2(\counter_o[6]_i_2_n_0 ),
        .I3(\counter_o_reg_n_0_[3] ),
        .I4(sel0[1]),
        .I5(sel0[2]),
        .O(p_0_in__0[6]));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \counter_o[6]_i_2 
       (.I0(\counter_o_reg_n_0_[1] ),
        .I1(\counter_o_reg_n_0_[0] ),
        .O(\counter_o[6]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h00A8)) 
    \counter_o[7]_i_1 
       (.I0(p_1_in),
        .I1(\counter_o[7]_i_3_n_0 ),
        .I2(\counter_o[7]_i_4_n_0 ),
        .I3(p_0_in_0),
        .O(\counter_o[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \counter_o[7]_i_10 
       (.I0(\counter_o_reg[0]_0 [3]),
        .I1(\counter_o_reg[0]_0 [1]),
        .I2(\counter_o_reg[0]_0 [2]),
        .O(\counter_o[7]_i_10_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hE8)) 
    \counter_o[7]_i_11 
       (.I0(\counter_o_reg[0]_0 [4]),
        .I1(\counter_o_reg[0]_0 [5]),
        .I2(\counter_o_reg[0]_0 [6]),
        .O(\counter_o[7]_i_11_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'h78)) 
    \counter_o[7]_i_2 
       (.I0(\counter_o[7]_i_5_n_0 ),
        .I1(sel0[2]),
        .I2(sel0[3]),
        .O(p_0_in__0[7]));
  LUT6 #(
    .INIT(64'hF666666066606000)) 
    \counter_o[7]_i_3 
       (.I0(\counter_o[7]_i_6_n_0 ),
        .I1(\counter_o[7]_i_7_n_0 ),
        .I2(\counter_o[7]_i_8_n_0 ),
        .I3(\counter_o[7]_i_9_n_0 ),
        .I4(\counter_o_reg[0]_0 [0]),
        .I5(\counter_o[7]_i_10_n_0 ),
        .O(\counter_o[7]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'hFFE8E800)) 
    \counter_o[7]_i_4 
       (.I0(\counter_o_reg[0]_0 [9]),
        .I1(\counter_o_reg[0]_0 [8]),
        .I2(\counter_o_reg[0]_0 [7]),
        .I3(\counter_o[7]_i_11_n_0 ),
        .I4(\counter_o[7]_i_7_n_0 ),
        .O(\counter_o[7]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \counter_o[7]_i_5 
       (.I0(sel0[1]),
        .I1(\counter_o_reg_n_0_[3] ),
        .I2(\counter_o_reg_n_0_[1] ),
        .I3(\counter_o_reg_n_0_[0] ),
        .I4(\counter_o_reg_n_0_[2] ),
        .I5(sel0[0]),
        .O(\counter_o[7]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h171717E817E8E8E8)) 
    \counter_o[7]_i_6 
       (.I0(\counter_o_reg[0]_0 [6]),
        .I1(\counter_o_reg[0]_0 [5]),
        .I2(\counter_o_reg[0]_0 [4]),
        .I3(\counter_o_reg[0]_0 [9]),
        .I4(\counter_o_reg[0]_0 [8]),
        .I5(\counter_o_reg[0]_0 [7]),
        .O(\counter_o[7]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hE8)) 
    \counter_o[7]_i_7 
       (.I0(\counter_o_reg[0]_0 [1]),
        .I1(\counter_o_reg[0]_0 [2]),
        .I2(\counter_o_reg[0]_0 [3]),
        .O(\counter_o[7]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \counter_o[7]_i_8 
       (.I0(\counter_o_reg[0]_0 [6]),
        .I1(\counter_o_reg[0]_0 [4]),
        .I2(\counter_o_reg[0]_0 [5]),
        .O(\counter_o[7]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'h96)) 
    \counter_o[7]_i_9 
       (.I0(\counter_o_reg[0]_0 [9]),
        .I1(\counter_o_reg[0]_0 [7]),
        .I2(\counter_o_reg[0]_0 [8]),
        .O(\counter_o[7]_i_9_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \counter_o_reg[0] 
       (.C(CLK),
        .CE(\counter_o[7]_i_1_n_0 ),
        .CLR(\counter_o_reg[3]_0 ),
        .D(\counter_o[0]_i_1_n_0 ),
        .Q(\counter_o_reg_n_0_[0] ));
  FDCE #(
    .INIT(1'b0)) 
    \counter_o_reg[1] 
       (.C(CLK),
        .CE(\counter_o[7]_i_1_n_0 ),
        .CLR(\counter_o_reg[3]_0 ),
        .D(\counter_o[1]_i_1_n_0 ),
        .Q(\counter_o_reg_n_0_[1] ));
  FDCE #(
    .INIT(1'b0)) 
    \counter_o_reg[2] 
       (.C(CLK),
        .CE(\counter_o[7]_i_1_n_0 ),
        .CLR(\counter_o_reg[3]_0 ),
        .D(p_0_in__0[2]),
        .Q(\counter_o_reg_n_0_[2] ));
  FDCE #(
    .INIT(1'b0)) 
    \counter_o_reg[3] 
       (.C(CLK),
        .CE(\counter_o[7]_i_1_n_0 ),
        .CLR(\counter_o_reg[3]_0 ),
        .D(p_0_in__0[3]),
        .Q(\counter_o_reg_n_0_[3] ));
  FDCE #(
    .INIT(1'b0)) 
    \counter_o_reg[4] 
       (.C(CLK),
        .CE(\counter_o[7]_i_1_n_0 ),
        .CLR(\counter_o_reg[3]_0 ),
        .D(p_0_in__0[4]),
        .Q(sel0[0]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_o_reg[5] 
       (.C(CLK),
        .CE(\counter_o[7]_i_1_n_0 ),
        .CLR(\counter_o_reg[3]_0 ),
        .D(p_0_in__0[5]),
        .Q(sel0[1]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_o_reg[6] 
       (.C(CLK),
        .CE(\counter_o[7]_i_1_n_0 ),
        .CLR(\counter_o_reg[3]_0 ),
        .D(p_0_in__0[6]),
        .Q(sel0[2]));
  FDCE #(
    .INIT(1'b0)) 
    \counter_o_reg[7] 
       (.C(CLK),
        .CE(\counter_o[7]_i_1_n_0 ),
        .CLR(\counter_o_reg[3]_0 ),
        .D(p_0_in__0[7]),
        .Q(sel0[3]));
  FDRE #(
    .INIT(1'b0)) 
    \event_sync_reg_reg[0] 
       (.C(CLK),
        .CE(1'b1),
        .D(E),
        .Q(p_0_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \event_sync_reg_reg[1] 
       (.C(CLK),
        .CE(1'b1),
        .D(p_0_in),
        .Q(p_1_in),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \event_sync_reg_reg[2] 
       (.C(CLK),
        .CE(1'b1),
        .D(p_1_in),
        .Q(p_0_in_0),
        .R(1'b0));
endmodule

module dff_leds
   (Q,
    \KEY_i[1] ,
    KEY_i_IBUF,
    D,
    CLK);
  output [9:0]Q;
  output \KEY_i[1] ;
  input [1:0]KEY_i_IBUF;
  input [9:0]D;
  input CLK;

  wire CLK;
  wire [9:0]D;
  wire \KEY_i[1] ;
  wire [1:0]KEY_i_IBUF;
  wire [9:0]Q;

  LUT1 #(
    .INIT(2'h1)) 
    \q_o[9]_i_1 
       (.I0(KEY_i_IBUF[1]),
        .O(\KEY_i[1] ));
  FDCE #(
    .INIT(1'b0)) 
    \q_o_reg[0] 
       (.C(CLK),
        .CE(KEY_i_IBUF[0]),
        .CLR(\KEY_i[1] ),
        .D(D[0]),
        .Q(Q[0]));
  FDCE #(
    .INIT(1'b0)) 
    \q_o_reg[1] 
       (.C(CLK),
        .CE(KEY_i_IBUF[0]),
        .CLR(\KEY_i[1] ),
        .D(D[1]),
        .Q(Q[1]));
  FDCE #(
    .INIT(1'b0)) 
    \q_o_reg[2] 
       (.C(CLK),
        .CE(KEY_i_IBUF[0]),
        .CLR(\KEY_i[1] ),
        .D(D[2]),
        .Q(Q[2]));
  FDCE #(
    .INIT(1'b0)) 
    \q_o_reg[3] 
       (.C(CLK),
        .CE(KEY_i_IBUF[0]),
        .CLR(\KEY_i[1] ),
        .D(D[3]),
        .Q(Q[3]));
  FDCE #(
    .INIT(1'b0)) 
    \q_o_reg[4] 
       (.C(CLK),
        .CE(KEY_i_IBUF[0]),
        .CLR(\KEY_i[1] ),
        .D(D[4]),
        .Q(Q[4]));
  FDCE #(
    .INIT(1'b0)) 
    \q_o_reg[5] 
       (.C(CLK),
        .CE(KEY_i_IBUF[0]),
        .CLR(\KEY_i[1] ),
        .D(D[5]),
        .Q(Q[5]));
  FDCE #(
    .INIT(1'b0)) 
    \q_o_reg[6] 
       (.C(CLK),
        .CE(KEY_i_IBUF[0]),
        .CLR(\KEY_i[1] ),
        .D(D[6]),
        .Q(Q[6]));
  FDCE #(
    .INIT(1'b0)) 
    \q_o_reg[7] 
       (.C(CLK),
        .CE(KEY_i_IBUF[0]),
        .CLR(\KEY_i[1] ),
        .D(D[7]),
        .Q(Q[7]));
  FDCE #(
    .INIT(1'b0)) 
    \q_o_reg[8] 
       (.C(CLK),
        .CE(KEY_i_IBUF[0]),
        .CLR(\KEY_i[1] ),
        .D(D[8]),
        .Q(Q[8]));
  FDCE #(
    .INIT(1'b0)) 
    \q_o_reg[9] 
       (.C(CLK),
        .CE(KEY_i_IBUF[0]),
        .CLR(\KEY_i[1] ),
        .D(D[9]),
        .Q(Q[9]));
endmodule

(* NotValidForBitStream *)
module main_dev
   (SW_i,
    KEY_i,
    CLK50_i,
    LEDR_o,
    HEX0_o,
    HEX1_o);
  input [9:0]SW_i;
  input [1:0]KEY_i;
  input CLK50_i;
  output [9:0]LEDR_o;
  output [6:0]HEX0_o;
  output [6:0]HEX1_o;

  wire CLK50_i;
  wire CLK50_i_IBUF;
  wire CLK50_i_IBUF_BUFG;
  wire [6:0]HEX0_o;
  wire [6:0]HEX0_o_OBUF;
  wire [6:0]HEX1_o;
  wire [6:0]HEX1_o_OBUF;
  wire [1:0]KEY_i;
  wire [1:0]KEY_i_IBUF;
  wire [9:0]LEDR_o;
  wire [9:0]LEDR_o_OBUF;
  wire [9:0]SW_i;
  wire [9:0]SW_i_IBUF;
  wire count_n_0;
  wire count_n_1;
  wire count_n_10;
  wire count_n_11;
  wire count_n_12;
  wire count_n_13;
  wire count_n_2;
  wire count_n_3;
  wire count_n_4;
  wire count_n_5;
  wire count_n_6;
  wire count_n_7;
  wire count_n_8;
  wire count_n_9;
  wire dff_n_10;

initial begin
 $sdf_annotate("main_tb_time_synth.sdf",,,,"tool_control");
end
  BUFG CLK50_i_IBUF_BUFG_inst
       (.I(CLK50_i_IBUF),
        .O(CLK50_i_IBUF_BUFG));
  IBUF CLK50_i_IBUF_inst
       (.I(CLK50_i),
        .O(CLK50_i_IBUF));
  OBUF \HEX0_o_OBUF[0]_inst 
       (.I(HEX0_o_OBUF[0]),
        .O(HEX0_o[0]));
  OBUF \HEX0_o_OBUF[1]_inst 
       (.I(HEX0_o_OBUF[1]),
        .O(HEX0_o[1]));
  OBUF \HEX0_o_OBUF[2]_inst 
       (.I(HEX0_o_OBUF[2]),
        .O(HEX0_o[2]));
  OBUF \HEX0_o_OBUF[3]_inst 
       (.I(HEX0_o_OBUF[3]),
        .O(HEX0_o[3]));
  OBUF \HEX0_o_OBUF[4]_inst 
       (.I(HEX0_o_OBUF[4]),
        .O(HEX0_o[4]));
  OBUF \HEX0_o_OBUF[5]_inst 
       (.I(HEX0_o_OBUF[5]),
        .O(HEX0_o[5]));
  OBUF \HEX0_o_OBUF[6]_inst 
       (.I(HEX0_o_OBUF[6]),
        .O(HEX0_o[6]));
  FDRE #(
    .INIT(1'b0)) 
    \HEX0_o_reg[0] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(1'b1),
        .D(count_n_6),
        .Q(HEX0_o_OBUF[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \HEX0_o_reg[1] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(1'b1),
        .D(count_n_5),
        .Q(HEX0_o_OBUF[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \HEX0_o_reg[2] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(1'b1),
        .D(count_n_4),
        .Q(HEX0_o_OBUF[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \HEX0_o_reg[3] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(1'b1),
        .D(count_n_3),
        .Q(HEX0_o_OBUF[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \HEX0_o_reg[4] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(1'b1),
        .D(count_n_2),
        .Q(HEX0_o_OBUF[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \HEX0_o_reg[5] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(1'b1),
        .D(count_n_1),
        .Q(HEX0_o_OBUF[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \HEX0_o_reg[6] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(1'b1),
        .D(count_n_0),
        .Q(HEX0_o_OBUF[6]),
        .R(1'b0));
  OBUF \HEX1_o_OBUF[0]_inst 
       (.I(HEX1_o_OBUF[0]),
        .O(HEX1_o[0]));
  OBUF \HEX1_o_OBUF[1]_inst 
       (.I(HEX1_o_OBUF[1]),
        .O(HEX1_o[1]));
  OBUF \HEX1_o_OBUF[2]_inst 
       (.I(HEX1_o_OBUF[2]),
        .O(HEX1_o[2]));
  OBUF \HEX1_o_OBUF[3]_inst 
       (.I(HEX1_o_OBUF[3]),
        .O(HEX1_o[3]));
  OBUF \HEX1_o_OBUF[4]_inst 
       (.I(HEX1_o_OBUF[4]),
        .O(HEX1_o[4]));
  OBUF \HEX1_o_OBUF[5]_inst 
       (.I(HEX1_o_OBUF[5]),
        .O(HEX1_o[5]));
  OBUF \HEX1_o_OBUF[6]_inst 
       (.I(HEX1_o_OBUF[6]),
        .O(HEX1_o[6]));
  FDRE #(
    .INIT(1'b0)) 
    \HEX1_o_reg[0] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(1'b1),
        .D(count_n_13),
        .Q(HEX1_o_OBUF[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \HEX1_o_reg[1] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(1'b1),
        .D(count_n_12),
        .Q(HEX1_o_OBUF[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \HEX1_o_reg[2] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(1'b1),
        .D(count_n_11),
        .Q(HEX1_o_OBUF[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \HEX1_o_reg[3] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(1'b1),
        .D(count_n_10),
        .Q(HEX1_o_OBUF[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \HEX1_o_reg[4] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(1'b1),
        .D(count_n_9),
        .Q(HEX1_o_OBUF[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \HEX1_o_reg[5] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(1'b1),
        .D(count_n_8),
        .Q(HEX1_o_OBUF[5]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \HEX1_o_reg[6] 
       (.C(CLK50_i_IBUF_BUFG),
        .CE(1'b1),
        .D(count_n_7),
        .Q(HEX1_o_OBUF[6]),
        .R(1'b0));
  IBUF \KEY_i_IBUF[0]_inst 
       (.I(KEY_i[0]),
        .O(KEY_i_IBUF[0]));
  IBUF \KEY_i_IBUF[1]_inst 
       (.I(KEY_i[1]),
        .O(KEY_i_IBUF[1]));
  OBUF \LEDR_o_OBUF[0]_inst 
       (.I(LEDR_o_OBUF[0]),
        .O(LEDR_o[0]));
  OBUF \LEDR_o_OBUF[1]_inst 
       (.I(LEDR_o_OBUF[1]),
        .O(LEDR_o[1]));
  OBUF \LEDR_o_OBUF[2]_inst 
       (.I(LEDR_o_OBUF[2]),
        .O(LEDR_o[2]));
  OBUF \LEDR_o_OBUF[3]_inst 
       (.I(LEDR_o_OBUF[3]),
        .O(LEDR_o[3]));
  OBUF \LEDR_o_OBUF[4]_inst 
       (.I(LEDR_o_OBUF[4]),
        .O(LEDR_o[4]));
  OBUF \LEDR_o_OBUF[5]_inst 
       (.I(LEDR_o_OBUF[5]),
        .O(LEDR_o[5]));
  OBUF \LEDR_o_OBUF[6]_inst 
       (.I(LEDR_o_OBUF[6]),
        .O(LEDR_o[6]));
  OBUF \LEDR_o_OBUF[7]_inst 
       (.I(LEDR_o_OBUF[7]),
        .O(LEDR_o[7]));
  OBUF \LEDR_o_OBUF[8]_inst 
       (.I(LEDR_o_OBUF[8]),
        .O(LEDR_o[8]));
  OBUF \LEDR_o_OBUF[9]_inst 
       (.I(LEDR_o_OBUF[9]),
        .O(LEDR_o[9]));
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
  count_event count
       (.CLK(CLK50_i_IBUF_BUFG),
        .D({count_n_0,count_n_1,count_n_2,count_n_3,count_n_4,count_n_5,count_n_6}),
        .E(KEY_i_IBUF[0]),
        .\counter_o_reg[0]_0 (SW_i_IBUF),
        .\counter_o_reg[3]_0 (dff_n_10),
        .\counter_o_reg[7]_0 ({count_n_7,count_n_8,count_n_9,count_n_10,count_n_11,count_n_12,count_n_13}));
  dff_leds dff
       (.CLK(CLK50_i_IBUF_BUFG),
        .D(SW_i_IBUF),
        .\KEY_i[1] (dff_n_10),
        .KEY_i_IBUF(KEY_i_IBUF),
        .Q(LEDR_o_OBUF));
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
