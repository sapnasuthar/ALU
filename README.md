# ALU Single-Cycle RISC-V Processor

This project is a SystemVerilog-based implementation of a **single-cycle RISC-V processor** that executes a core subset of the RV32I instruction set. It features a custom-designed **ALU**, control logic, and datapath components, all verified through simulation in ModelSim.

---

## Features

- Executes RV32I instructions in a single clock cycle
- Custom-built ALU supporting arithmetic and logical operations
- Instruction fetch, decode, execute, memory, and write-back all in one cycle
- Branch and memory operations supported
- Verified using SystemVerilog testbenches in ModelSim

---

## Components

- **Program Counter (PC)**: Holds address of current instruction  
- **Instruction Memory**: Supplies 32-bit RISC-V instructions  
- **Control Unit**: Decodes opcode and generates control signals  
- **Register File**: 32 registers (`x0`–`x31`), 32 bits each  
- **ALU**: Performs ADD, SUB, AND, OR, SLT, and other operations  
- **Immediate Generator**: Extracts and sign-extends immediate values  
- **Data Memory**: Supports LW/SW memory operations  
- **Branch Target Adder**: Computes target address for branch instructions  
- **Next PC Mux**: Chooses between sequential and branch/jump addresses  

---

## Supported Instructions

- Arithmetic: `ADD`, `SUB`, `ADDI`  
- Logical: `AND`, `OR`, `XOR`  
- Shift: `SLL`, `SRL`, `SRA`   

---

## Simulation

Simulated and tested using **ModelSim** with self-checking SystemVerilog testbenches.

Test cases include:
- Randomized ALU operations
- Instruction decoding and execution
- Memory load/store correctness
- Branch evaluation and PC update
