<!--
Project: FPGA-Based Out-of-Band Encryption Module with Key Management System
Module:  Repository overview and usage
Created: Jan 2026
-->

# FPGA-Based Out-of-Band Encryption Module with Key Management System

## Overview

This project implements a Zynq-7000 based hardware-accelerated AES flow where the host PC exchanges block data over UART and encryption/decryption runs in SoC hardware/firmware.

## Quick Start (Vivado → Vitis → WinForms)

Follow this order for a normal end-to-end run.

### 1) Open and build hardware in Vivado

- Open: `backup files/project_22/project_22.xpr`
- Validate/open block design from: `backup files/project_22/project_22.srcs/`
- Run synthesis/implementation and generate bitstream.
- Confirm hardware export file exists: `backup files/project_22/design_1_wrapper.xsa`

### 2) Open and build firmware in Vitis

- Open Vitis workspace at: `backup files/project_22/`
- Platform project path: `backup files/project_22/platform/`
- Application project path: `backup files/project_22/hello_world/`
- Main firmware file to edit/run: `backup files/project_22/hello_world/src/helloworld.c`
- Build app and create/update ELF output.

### 3) Run host PC app (WinForms)

- Open solution: `backup files/WindowsFormsApplication1/WindowsFormsApplication1.sln`
- Main UI logic: `backup files/WindowsFormsApplication1/WindowsFormsApplication1/Form1.cs`
- Run app, select COM port, and load UART files from `samples/uart/`.

### 4) Use sample vectors for first test

- Key file: `samples/uart/key_256.txt`
- Plaintext file: `samples/uart/plain_text.txt`
- Ciphertext file: `samples/uart/cipher_text.txt`
- Optional capture file: `samples/uart/output.txt`

## Current Implementation Status

- Firmware (`backup files/project_22/hello_world/src/helloworld.c`) now validates incoming hex characters, uses volatile MMIO access, and prints full 32-bit decrypted words.
- WinForms app now validates file payloads before sending:
  - Key: exactly 64 hex chars (256-bit)
  - Plaintext: exactly 32 hex chars (128-bit block)
  - Ciphertext: exactly 32 hex chars (128-bit block)
- Build config typo in `backup files/project_22/hello_world/src/UserConfig.cmake` was fixed so linker options propagate correctly.

## Repository Layout (Detailed)

### Folder Tree

```text
.
├─ README.md
├─ assets/
│  └─ images/                         # architecture, timing, waveform, app screenshots
├─ docs/
│  ├─ notes/                          # experiment notes and legacy text backups
│  │  └─ legacy/
│  └─ reports/                        # reports, proposal docs, presentation slides
├─ samples/
│  └─ uart/
│     ├─ key_256.txt
│     ├─ plain_text.txt
│     ├─ cipher_text.txt
│     └─ output.txt
└─ backup files/
  ├─ project_22/                     # Vivado/Vitis workspace snapshot (hardware + platform + app)
  │  ├─ hello_world/
  │  │  ├─ src/                      # firmware source files (main editable app code)
  │  │  ├─ build/                    # generated
  │  │  └─ _ide/                     # generated
  │  ├─ platform/                    # Vitis platform and BSP outputs
  │  ├─ project_22.srcs/             # source-managed Vivado design sources
  │  ├─ project_22.runs/             # synthesis/implementation outputs (generated)
  │  ├─ project_22.gen/              # generated IP/output products
  │  └─ logs/                        # generated run logs
  └─ WindowsFormsApplication1/
    ├─ WindowsFormsApplication1.sln
    └─ WindowsFormsApplication1/    # C# host app source (Form1, Program, Properties)
```

### What to Edit vs Generated Content

- Main firmware code: `backup files/project_22/hello_world/src/`
- Main host app code: `backup files/WindowsFormsApplication1/WindowsFormsApplication1/`
- Hardware source-managed files: `backup files/project_22/project_22.srcs/`
- Usually generated (not source edits): `build/`, `_ide/`, `project_22.runs/`, `project_22.gen/`, `logs/`, `bin/`, `obj/`

The repository still contains previously committed Vivado/Vitis generated outputs under `backup files/project_22/`. Current `.gitignore` rules are configured to prevent newly generated artifacts, caches, and logs from being added going forward.

### Main Files Guide (Open These First)

Use this section as a quick map when browsing the project.

#### Firmware (Vitis Bare-Metal App)

- `backup files/project_22/hello_world/src/helloworld.c`
  - Main application logic for UART receive/transmit flow and AES hardware register interaction.
- `backup files/project_22/hello_world/src/platform.c`
  - Platform initialization and low-level setup helpers used by the firmware app.
- `backup files/project_22/hello_world/src/platform.h`
  - Platform declarations/macros shared by firmware source files.
- `backup files/project_22/hello_world/src/UserConfig.cmake`
  - Vitis app build configuration (compiler/linker options).
- `backup files/project_22/hello_world/src/lscript.ld`
  - Linker script defining firmware memory layout.

#### Hardware Project (Vivado)

- `backup files/project_22/project_22.xpr`
  - Main Vivado project file (open this in Vivado to load the hardware project).
- `backup files/project_22/project_22.srcs/`
  - Source-managed block design/IP source tree.
- `backup files/project_22/design_1_wrapper.xsa`
  - Exported hardware handoff used by Vitis platform/application workflows.

#### Host PC Application (C# WinForms)

- `backup files/WindowsFormsApplication1/WindowsFormsApplication1.sln`
  - Visual Studio solution entry point for the host app.
- `backup files/WindowsFormsApplication1/WindowsFormsApplication1/Form1.cs`
  - Main UI/event logic (file loading, validation, serial communication workflow).
- `backup files/WindowsFormsApplication1/WindowsFormsApplication1/Program.cs`
  - App startup/entry point.
- `backup files/WindowsFormsApplication1/WindowsFormsApplication1/WindowsFormsApplication1.csproj`
  - C# project configuration and target framework details.

#### Test Vectors and Captures

- `samples/uart/key_256.txt`
  - 256-bit AES key sample input.
- `samples/uart/plain_text.txt`
  - 128-bit plaintext sample input.
- `samples/uart/cipher_text.txt`
  - Expected ciphertext sample.
- `samples/uart/output.txt`
  - Optional UART output capture file.

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

