📖 Overview

A high-performance AES-128 Hardware Accelerator implemented on the Xilinx Zynq-7000 SoC. This project decouples cryptographic operations from the host PC, creating a "black box" encryption module where secret keys never leave the secure hardware domain.

🏗️ System Architecture

The design utilizes the Zynq Processing System (PS) and Programmable Logic (PL) to create a trusted execution flow.

Phase 1: Hardware Acceleration

•	PL Implementation: Custom AES-128 IP Core designed in VHDL/Verilog.

•	Interface: Connected to the ARM Cortex-A9 processor via AXI4-Lite bus for control and data transfer.

•	Performance: Offloads CPU-intensive AES-CBC operations to the FPGA fabric.


Phase 2: Secure Key Management System (KMS)

•	Out-of-Band Security: The encryption keys are managed solely by the Zynq SoC. The host PC (untrusted) sends plaintexts via UART but never sees the keys.

•	Firmware: Bare-metal C application on the ARM core handles key generation, storage, and configures the AES IP.


•	Protocol: Custom UART command-response protocol for communicating with the PC application.

🚀 Key Features

•	Hardware Isolation: Cryptographic primitives run in hardware, isolating them from OS-level vulnerabilities.

•	Throughput: High-speed encryption via dedicated RTL pipelines.


•	Integration: Full AXI register design for status polling and configuration.

🛠️ Tech Stack

•	FPGA: Xilinx Zynq Zybo Z7-10.

•	Languages: VHDL/Verilog (RTL), C (Firmware), C# (PC App).

•	Tools: Vivado, Xilinx SDK / Vitis, ModelSim.

________________________________________
Author: Uzair Ashfaq

