# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 20, units="ns")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 2)
    dut.rst_n.value = 1
    dut._log.info("Test project behavior")


    # Apply sequential changes
    for i in range(5):
        dut.ui_in.value = i * 5
        dut.uio_in.value = i * 3
        await ClockCycles(dut.clk, 1)
        expected_output = (i * 5) + (i * 3)  # Adjust based on module functionality
        assert dut.uo_out.value == expected_output, f"Expected {expected_output}, got {int(dut.uo_out.value)}"
