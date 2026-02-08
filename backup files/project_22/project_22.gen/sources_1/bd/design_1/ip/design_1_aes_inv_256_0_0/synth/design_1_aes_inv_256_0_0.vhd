-- (c) Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- (c) Copyright 2022-2025 Advanced Micro Devices, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of AMD and is protected under U.S. and international copyright
-- and other intellectual property laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- AMD, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND AMD HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) AMD shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or AMD had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- AMD products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of AMD products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:module_ref:aes_inv_256:1.0
-- IP Revision: 1

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY design_1_aes_inv_256_0_0 IS
  PORT (
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    dat_in : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    last_key : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    key1 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    key2 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    key3 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    key4 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    key5 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    key6 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    key7 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    key8 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    key9 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    key10 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    key11 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    key12 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    key13 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    key14 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
    dat_out : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
  );
END design_1_aes_inv_256_0_0;

ARCHITECTURE design_1_aes_inv_256_0_0_arch OF design_1_aes_inv_256_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF design_1_aes_inv_256_0_0_arch: ARCHITECTURE IS "yes";
  COMPONENT aes_inv_256 IS
    PORT (
      clk : IN STD_LOGIC;
      rst : IN STD_LOGIC;
      dat_in : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
      last_key : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
      key1 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
      key2 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
      key3 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
      key4 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
      key5 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
      key6 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
      key7 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
      key8 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
      key9 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
      key10 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
      key11 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
      key12 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
      key13 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
      key14 : IN STD_LOGIC_VECTOR(255 DOWNTO 0);
      dat_out : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
    );
  END COMPONENT aes_inv_256;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF design_1_aes_inv_256_0_0_arch: ARCHITECTURE IS "aes_inv_256,Vivado 2024.1";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF design_1_aes_inv_256_0_0_arch : ARCHITECTURE IS "design_1_aes_inv_256_0_0,aes_inv_256,{}";
  ATTRIBUTE CORE_GENERATION_INFO : STRING;
  ATTRIBUTE CORE_GENERATION_INFO OF design_1_aes_inv_256_0_0_arch: ARCHITECTURE IS "design_1_aes_inv_256_0_0,aes_inv_256,{x_ipProduct=Vivado 2024.1,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=aes_inv_256,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED}";
  ATTRIBUTE IP_DEFINITION_SOURCE : STRING;
  ATTRIBUTE IP_DEFINITION_SOURCE OF design_1_aes_inv_256_0_0_arch: ARCHITECTURE IS "module_ref";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER OF clk: SIGNAL IS "XIL_INTERFACENAME clk, ASSOCIATED_RESET rst, FREQ_HZ 50000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN design_1_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF clk: SIGNAL IS "xilinx.com:signal:clock:1.0 clk CLK";
  ATTRIBUTE X_INTERFACE_PARAMETER OF rst: SIGNAL IS "XIL_INTERFACENAME rst, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  ATTRIBUTE X_INTERFACE_INFO OF rst: SIGNAL IS "xilinx.com:signal:reset:1.0 rst RST";
BEGIN
  U0 : aes_inv_256
    PORT MAP (
      clk => clk,
      rst => rst,
      dat_in => dat_in,
      last_key => last_key,
      key1 => key1,
      key2 => key2,
      key3 => key3,
      key4 => key4,
      key5 => key5,
      key6 => key6,
      key7 => key7,
      key8 => key8,
      key9 => key9,
      key10 => key10,
      key11 => key11,
      key12 => key12,
      key13 => key13,
      key14 => key14,
      dat_out => dat_out
    );
END design_1_aes_inv_256_0_0_arch;
