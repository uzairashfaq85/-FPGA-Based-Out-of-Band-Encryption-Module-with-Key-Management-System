/******************************************************************************
* Project: FPGA-Based Out-of-Band Encryption Module with Key Management System
* Module:  Platform API declarations
* Created: November 2025
******************************************************************************/

/******************************************************************************
* Copyright (C) 2023 Advanced Micro Devices, Inc. All Rights Reserved.
* SPDX-License-Identifier: MIT
******************************************************************************/

#ifndef __PLATFORM_H_
#define __PLATFORM_H_

#ifndef SDT
#include "platform_config.h"
#endif

void init_platform();
void cleanup_platform();

#endif
