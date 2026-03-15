<!--
Project: FPGA-Based Out-of-Band Encryption Module with Key Management System
Module:  Repository overview and usage
Created: Jan 2026
-->

# FPGA-Based Out-of-Band Encryption Module with Key Management System

## Overview

This project implements a Zynq-7000 based hardware-accelerated AES flow where the host PC exchanges block data over UART and encryption/decryption runs in SoC hardware/firmware.

## Current Implementation Status

- Firmware (`backup files/project_22/hello_world/src/helloworld.c`) now validates incoming hex characters, uses volatile MMIO access, and prints full 32-bit decrypted words.
- WinForms app now validates file payloads before sending:
  - Key: exactly 64 hex chars (256-bit)
  - Plaintext: exactly 32 hex chars (128-bit block)
  - Ciphertext: exactly 32 hex chars (128-bit block)
- Build config typo in `backup files/project_22/hello_world/src/UserConfig.cmake` was fixed so linker options propagate correctly.

## Repository Layout

- `backup files/project_22/` -> Vivado/Vitis workspace snapshot for the Zynq design
- `backup files/project_22/hello_world/src/` -> bare-metal firmware sources used by Vitis
- `backup files/project_22/project_22.srcs/` -> Vivado block design, IP definitions, and source-managed hardware files
- `backup files/WindowsFormsApplication1/` -> C# WinForms host application and solution files
- `samples/uart/` -> UART key/plaintext/ciphertext sample vectors and output capture
- `assets/images/` -> architecture, waveform, timing, and application screenshots
- `docs/reports/` -> reports, proposal documents, and presentation slides
- `docs/notes/` -> working notes, timing logs, and legacy backup text snippets

The repository still contains some previously committed Vivado/Vitis generated outputs under `backup files/project_22/`. The current `.gitignore` is intended to keep newly generated build artifacts, logs, caches, and local IDE metadata out of future commits.

## UART Protocol (Implemented)

Firmware loop emits status markers and expects payloads in this order:

1. `RDY_KEY`  -> send 64 hex chars (key)
2. `ACK_KEY`
3. `RDY_PT`   -> send 32 hex chars (plaintext)
4. `ACK_PT`
5. Firmware prints key/plaintext/ciphertext echo lines
6. `RDY_CT`   -> send 32 hex chars (ciphertext for decrypt test)
7. `ACK_CT`
8. Firmware prints decrypted plaintext line

Whitespace/newlines in payload files are accepted by firmware and ignored during hex parsing.

## Sample Input Files

- `samples/uart/key_256.txt` -> `000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F`
- `samples/uart/plain_text.txt` -> `00112233445566778899AABBCCDDEEFF`
- `samples/uart/cipher_text.txt` -> `8EA2B7CA516745BFEAFC49904B496089`
- `samples/uart/output.txt` -> placeholder/output capture file (if used in host workflow)

For a correct AES-256 hardware implementation, encrypting the sample plaintext with sample key is expected to produce `8EA2B7CA516745BFEAFC49904B496089`.

## Tooling Requirements

- Vivado/Vitis toolchain for hardware + bare-metal firmware build.
- Visual Studio (or .NET Framework Developer Pack) for WinForms project.
  - The C# project targets `.NET Framework v4.0 Client`.

## Notes on Verification

- Source-level fixes have been applied for known correctness issues.
- Full end-to-end validation still requires your local FPGA bitstream + Vitis runtime + serial hardware connection.

---
Author: Uzair Ashfaq

