// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
// Date        : Wed Nov 26 00:41:59 2025
// Host        : LAPTOP-PANIECHO running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/ehtes/working_led_buttons_adder/project_22/project_22.gen/sources_1/bd/design_1/ip/design_1_aes_inv_256_0_0/design_1_aes_inv_256_0_0_stub.v
// Design      : design_1_aes_inv_256_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "aes_inv_256,Vivado 2024.1" *)
module design_1_aes_inv_256_0_0(clk, rst, dat_in, last_key, key1, key2, key3, key4, key5, 
  key6, key7, key8, key9, key10, key11, key12, key13, key14, dat_out)
/* synthesis syn_black_box black_box_pad_pin="rst,dat_in[127:0],last_key[255:0],key1[255:0],key2[255:0],key3[255:0],key4[255:0],key5[255:0],key6[255:0],key7[255:0],key8[255:0],key9[255:0],key10[255:0],key11[255:0],key12[255:0],key13[255:0],key14[255:0],dat_out[127:0]" */
/* synthesis syn_force_seq_prim="clk" */;
  input clk /* synthesis syn_isclock = 1 */;
  input rst;
  input [127:0]dat_in;
  input [255:0]last_key;
  input [255:0]key1;
  input [255:0]key2;
  input [255:0]key3;
  input [255:0]key4;
  input [255:0]key5;
  input [255:0]key6;
  input [255:0]key7;
  input [255:0]key8;
  input [255:0]key9;
  input [255:0]key10;
  input [255:0]key11;
  input [255:0]key12;
  input [255:0]key13;
  input [255:0]key14;
  output [127:0]dat_out;
endmodule
