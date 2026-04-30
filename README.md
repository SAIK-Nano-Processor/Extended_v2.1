# 🧠 VHDL-Based 4-Bit Nano Processor

<p align="center">
  <img width="640" height="640" alt="NanoV1" src="https://github.com/user-attachments/assets/6b08f9b9-6cf5-448c-aed4-c6f252d92c17" />
</p>

---

<div align="center">
  <p>A fully structural 4-bit microprocessor designed in VHDL, featuring a custom instruction set and deployed on the Xilinx Basys 3 FPGA development board.</p>
</div>

---

## 🚀 Project Overview
This project implements a complete, fully synthesizable 4-bit nanoprocessor system. Built entirely from fundamental digital logic components, the processor features a highly modular architecture including a custom ALU, a synchronous Register Bank, and sequential program control. 

Developed as a coursework project for the Department of Computer Science & Engineering at the University of Moratuwa (Batch 24), this design has been successfully synthesized, simulated, and deployed onto physical hardware for real-time visual execution.

## 🎯 Key Achievements
- ✅ **Custom ISA** – A streamlined 12-bit Instruction Set Architecture supporting immediate loading, arithmetic, and conditional branching.
- ✅ **Pure Structural VHDL** – Built using foundational logic (Half Adders, Full Adders, Ripple Carry Adders) without relying on pre-compiled arithmetic libraries.
- ✅ **Hardware Visualization** – Integrates a custom clock divider (100MHz to 2Hz) and a 16-to-7 Lookup Table (LUT) to display real-time hexadecimal calculations on the Basys 3 board.
- ✅ **Safe Memory Architecture** – Features an 8-register bank with `R0` hardwired to `0000` to ensure safe jumps and conditional logic.
- ✅ **Status Flags** – Real-time ALU hardware flags for `Zero` and `Overflow` detection during 2's complement arithmetic.

---

## 📋 Instruction Set Architecture (ISA)

The processor executes 12-bit instructions parsed by a centralized Instruction Decoder. 

| Instruction  | Description                              | Format (12-bit)           |
|--------------|------------------------------------------|---------------------------|
| `MOVI R, d`  | Move immediate 4-bit value to register   | `10_R(3)_000_d(4)`        |
| `ADD Ra, Rb` | Add register Rb to Ra (Result in Ra)     | `00_Ra(3)_Rb(3)_0000`     |
| `NEG R`      | Two’s-complement negation of register R  | `01_000_R(3)_0000`        |
| `JZR R, d`   | Jump to address `d` if register `R` is 0 | `11_R(3)_000_d(3)`        |

### 🧮 Current ROM Program
The `Program_ROM.vhd` is currently pre-loaded with a test sequence that calculates `1 + 2 + 3 = 6` and safely halts execution:
1.  `MOVI R7, 0`
2.  `MOVI R1, 1`
3.  `MOVI R2, 2`
4.  `MOVI R3, 3`
5.  `ADD R7, R1`
6.  `ADD R7, R2`
7.  `ADD R7, R3`
8.  `JZR R0, 7` *(Infinite Halt Loop)*

---

## ⚙️ Hardware Mapping (Basys 3 FPGA)

*   **Clock (`W5`):** 100MHz internal oscillator, scaled down to 2Hz for visual observation.
*   **Reset (`U18`):** Center Push Button. Instantly clears the Program Counter and all Registers.
*   **Data LEDs (`V19` to `U16`):** The 4 rightmost LEDs output the raw binary data of Register 7.
*   **7-Segment Display (`W7` to `U7`):** Displays the current calculated value of Register 7 in Hexadecimal.
*   **Zero Flag (`P1`):** Leftmost LED. Illuminates when the ALU evaluates to exactly `0000`.
*   **Overflow Flag (`L1`):** Illuminates when signed arithmetic exceeds 4-bit bounds (-8 to +7).

---

## 📁 Project Structure
```text
NanoProcessor_Project/
├── docs/                        # Project documentation and images
├── constraints/                 
│   └── Basys3_Master.xdc        # Physical board mapping
├── sim/                         
│   └── TB_NanoProcessor.vhd     # Testbenches
└── src/                         # Synthesizable VHDL Source Code
    ├── common/                  
    │   ├── BusDef.vhd           # Global array and bus types
    │   └── Constants.vhd        # Opcode definitions
    ├── alu/                     
    │   ├── HA.vhd & FA.vhd      # Adders
    │   ├── RCA_3.vhd & RCA_4.vhd
    │   └── 4_bit_ALU.vhd        # Main Arithmetic Logic Unit
    ├── memory/                  
    │   ├── Reg_4Bit.vhd
    │   ├── RegBank.vhd          # 8x4-bit Register Bank
    │   └── Program_ROM.vhd      # Machine code storage
    ├── control/                 
    │   ├── slow_clock.vhd       # 100MHz to 2Hz divider
    │   ├── Program Counter.vhd  
    │   └── Instruction_Decoder.vhd
    ├── routing/                 
    │   ├── Decoder_2_to_4.vhd & Decoder_3_to_8.vhd
    │   └── Mux_2Way_3bit.vhd, Mux_2Way_4bit.vhd, Mux_8way_4bit.vhd
    ├── io/                      
    │   └── LUT_16_7.vhd         # 7-Segment Hex Decoder
    └── top/                     
        └── NanoProcessor.vhd    # Top-Level Entity
