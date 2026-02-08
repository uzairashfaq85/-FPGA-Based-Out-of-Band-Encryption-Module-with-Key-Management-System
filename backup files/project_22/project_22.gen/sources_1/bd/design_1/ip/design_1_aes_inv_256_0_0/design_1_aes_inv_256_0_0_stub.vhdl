-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.1 (win64) Build 5076996 Wed May 22 18:37:14 MDT 2024
-- Date        : Wed Nov 26 00:41:59 2025
-- Host        : LAPTOP-PANIECHO running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/ehtes/working_led_buttons_adder/project_22/project_22.gen/sources_1/bd/design_1/ip/design_1_aes_inv_256_0_0/design_1_aes_inv_256_0_0_stub.vhdl
-- Design      : design_1_aes_inv_256_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_aes_inv_256_0_0 is
  Port ( 
    clk : in STD_LOGIC;
    rst : in STD_LOGIC;
    dat_in : in STD_LOGIC_VECTOR ( 127 downto 0 );
    last_key : in STD_LOGIC_VECTOR ( 255 downto 0 );
    key1 : in STD_LOGIC_VECTOR ( 255 downto 0 );
    key2 : in STD_LOGIC_VECTOR ( 255 downto 0 );
    key3 : in STD_LOGIC_VECTOR ( 255 downto 0 );
    key4 : in STD_LOGIC_VECTOR ( 255 downto 0 );
    key5 : in STD_LOGIC_VECTOR ( 255 downto 0 );
    key6 : in STD_LOGIC_VECTOR ( 255 downto 0 );
    key7 : in STD_LOGIC_VECTOR ( 255 downto 0 );
    key8 : in STD_LOGIC_VECTOR ( 255 downto 0 );
    key9 : in STD_LOGIC_VECTOR ( 255 downto 0 );
    key10 : in STD_LOGIC_VECTOR ( 255 downto 0 );
    key11 : in STD_LOGIC_VECTOR ( 255 downto 0 );
    key12 : in STD_LOGIC_VECTOR ( 255 downto 0 );
    key13 : in STD_LOGIC_VECTOR ( 255 downto 0 );
    key14 : in STD_LOGIC_VECTOR ( 255 downto 0 );
    dat_out : out STD_LOGIC_VECTOR ( 127 downto 0 )
  );

end design_1_aes_inv_256_0_0;

architecture stub of design_1_aes_inv_256_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk,rst,dat_in[127:0],last_key[255:0],key1[255:0],key2[255:0],key3[255:0],key4[255:0],key5[255:0],key6[255:0],key7[255:0],key8[255:0],key9[255:0],key10[255:0],key11[255:0],key12[255:0],key13[255:0],key14[255:0],dat_out[127:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "aes_inv_256,Vivado 2024.1";
begin
end;
