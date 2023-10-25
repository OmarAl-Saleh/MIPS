# MIPS
Single-Cycle CPU
This repository contains a Verilog implementation of a single-cycle CPU based on the MIPS instruction set architecture.

Overview
The single-cycle CPU implemented here is designed to execute a subset of the MIPS instruction set. It fetches and executes one instruction every clock cycle, making it a straightforward design for educational purposes.

Features
Supports basic arithmetic and logic operations such as ADD, SUB, AND, OR, etc.
Load and Store operations for memory access.
Branching instructions such as BEQ, BNE.
Jump instructions.
Directory Structure
src/: Contains the Verilog source files for the CPU and its components.
testbench/: Contains Verilog testbenches to simulate and validate the CPU.
programs/: Sample assembly programs to test the CPU functionality.
Getting Started
Clone the repository:

bash
Copy code
git clone https://github.com/[YourUsername]/single-cycle-cpu.git
cd single-cycle-cpu
Simulation:

To simulate the CPU, navigate to the testbench/ directory and run:

bash
Copy code
iverilog -o test.vvp cpu_testbench.v
vvp test.vvp
View waveforms:

If you have GTKWave installed, you can visualize the simulation results:

bash
Copy code
gtkwave waveform.vcd
Dependencies
Icarus Verilog (For simulation)
GTKWave (Optional, for waveform viewing)
Future Enhancements
Extension to support more MIPS instructions.
Pipelined CPU implementation.
Integration with a memory controller for extended memory operations.
Contributions
Omar AL-khasawneh
Omar AL-salah 
moayyad abu mallouh

