# \# 🧠 VHDL-Based 4-Bit Nano Processor

# 

# \## 📌 Overview

# This project presents the design and implementation of a custom \*\*4-bit NanoProcessor\*\* developed using VHDL. The architecture is built to demonstrate the fundamental principles of computer organization, including synchronous datapath routing, instruction decoding, and arithmetic logic.

# 

# The processor features a minimal Instruction Set Architecture (ISA) and executes machine code stored in a Program ROM. It has been verified through Vivado simulations and successfully implemented on the \*\*Basys 3 FPGA\*\* board.

# 

# \---

# 

# \## 🚀 Key Features

# \*   \*\*4-Bit Data Path:\*\* Optimized for 4-bit signed (2's complement) and unsigned operations.

# \*   \*\*Modular Architecture:\*\* Components like the ALU, Register Bank, and Decoder are designed as separate entities for high expandability.

# \*   \*\*Synchronous Execution:\*\* Driven by a custom `slow\_clock` to allow for human-readable execution on physical hardware.

# \*   \*\*Real-time Status Flags:\*\* Hardware-level LEDs for `Zero` and `Overflow` status.

# \*   \*\*Hardware Visualization:\*\* Integrated 7-segment display logic for Hexadecimal output.

# 

# \---

# 

# \## 🏗️ System Architecture

# 

# The NanoProcessor consists of several interconnected modules:

# 

# \*   \*\*ALU (Arithmetic Logic Unit):\*\* Handles addition and 2's complement subtraction using a Ripple Carry Adder.

# \*   \*\*Register Bank:\*\* A collection of eight 4-bit registers. Note that `R0` is hard-coded to `0000` for logical consistency.

# \*   \*\*Control Unit:\*\* An Instruction Decoder that generates control signals for multiplexers and register enables.

# \*   \*\*Program Counter (PC):\*\* A 3-bit register that tracks the execution address, supported by a 3-bit incrementer.

# \*   \*\*Multiplexers:\*\* Various 2-way and 8-way Muxes to route data between the ALU, ROM, and Registers.

# 

# \---

# 

# \## 🧾 Instruction Set Architecture (ISA)

# 

# The processor uses a \*\*12-bit instruction word\*\*.

# 

# | Instruction | Opcode | Description |

# | :--- | :--- | :--- |

# | \*\*MOVI\*\* | `10` | Move Immediate: Loads a 4-bit value into a register. |

# | \*\*ADD\*\* | `00` | Addition: Adds two registers and stores the result. |

# | \*\*NEG\*\* | `01` | Negate: Performs 2's complement negation on a register. |

# | \*\*JZR\*\* | `11` | Jump if Zero: Branches to a new address if a register is zero. |

# 

# \---

# 

# \## ⚙️ FPGA Implementation

# 

# \*   \*\*Target Board:\*\* Digilent Basys 3 (Artix-7).

# \*   \*\*Clock:\*\* 100MHz (Internal), divided by `slow\_clock` for visibility.

# \*   \*\*Reset:\*\* Center Push Button (`U18`).

# \*   \*\*Output LEDs:\*\* Rightmost 4 LEDs display binary data; leftmost LEDs display status flags.

# \*   \*\*Display:\*\* 7-Segment Display shows Hexadecimal results from `R7`.

# 

# \---

# 

# \## 📁 Project Structure

# ```text

# NanoProcessor\_Project/

# ├── docs/

# ├── constraints/

# │   └── Basys3\_Master.xdc

# ├── sim/

# │   └── TB\_NanoProcessor.vhd

# └── src/

# &#x20;   ├── common/

# &#x20;   │   ├── BusDef.vhd

# &#x20;   │   └── Constants.vhd

# &#x20;   ├── alu/

# &#x20;   │   ├── HA.vhd

# &#x20;   │   ├── FA.vhd

# &#x20;   │   ├── RCA\_3.vhd

# &#x20;   │   ├── RCA\_4.vhd

# &#x20;   │   └── 4\_bit\_ALU.vhd

# &#x20;   ├── memory/

# &#x20;   │   ├── Reg\_4Bit.vhd

# &#x20;   │   ├── RegBank.vhd

# &#x20;   │   └── Program\_ROM.vhd

# &#x20;   ├── control/

# &#x20;   │   ├── slow\_clock.vhd

# &#x20;   │   ├── Program Counter.vhd

# &#x20;   │   └── Instruction\_Decoder.vhd

# &#x20;   ├── routing/

# &#x20;   │   ├── Decoder\_2\_to\_4.vhd

# &#x20;   │   ├── Decoder\_3\_to\_8.vhd

# &#x20;   │   ├── Mux\_2Way\_3bit.vhd

# &#x20;   │   ├── Mux\_2Way\_4bit.vhd

# &#x20;   │   └── Mux\_8way\_4bit.vhd

# &#x20;   ├── io/

# &#x20;   │   └── LUT\_16\_7.vhd

# &#x20;   └── top/

# &#x20;       └── NanoProcessor.vhd

