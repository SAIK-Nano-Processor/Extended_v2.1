# 🧠 VHDL-Based 4-Bit Nano Processor

## 📌 Overview
This project presents the design and implementation of a **4-bit nano-processor** using VHDL. It demonstrates key concepts of computer architecture such as datapath design, control logic, and instruction execution.

The processor is built with a **minimal instruction set architecture (ISA)** and verified through simulation and FPGA implementation.

---

## 🚀 Features
- 4-bit data path architecture  
- Minimal instruction set  
- Modular VHDL design  
- Custom components:
  - Arithmetic Logic Unit (ALU)
  - Register File (8 × 4-bit)
  - Program Counter (PC)
  - Multiplexers
  - Control Unit  
- Simulation using testbenches  
- FPGA implementation on Basys3 board  

---

## 🏗️ System Architecture

### 🔹 ALU
Performs arithmetic and logical operations:
- ADD
- SUB
- AND
- OR

### 🔹 Register File
- 8 general-purpose registers  
- Each register is 4 bits wide  

### 🔹 Program Counter (PC)
- 3-bit counter  
- Supports up to 8 instruction addresses  

### 🔹 Control Unit
- Decodes instructions  
- Generates control signals  

---

## 🧾 Instruction Format
- 12-bit instruction word  
- Contains:
  - Opcode  
  - Source/Destination registers  

---

## 🧪 Simulation
- All modules tested using VHDL testbenches  
- Verified before FPGA implementation  

---

## ⚙️ FPGA Implementation
- Target Board: Basys3 FPGA  
- Tool: Vivado  
- Outputs verified using onboard LEDs and switches  

---

## 📁 Project Structure
