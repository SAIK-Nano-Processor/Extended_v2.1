----------------------------------------------------------------------------------
-- Company: SAIK
-- Engineer: ISIWARA M.A.G.A
-- 
-- Create Date: 30.04.2026 01:52:55
-- Design Name: 
-- Module Name: Program_ROM - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Need to do to_integer(unsigned())
use WORK.BUSDEF.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Program_ROM is
    Port ( 
        Instruction     : out Instruction_bus;      -- Instruction form the ROM
        Memory_Select   : in Address_sel            -- Address input from program counter
    );
end Program_ROM;

architecture Behavioral of Program_ROM is
    
    -- Initialize the lookup table type
    type program_rom is array (0 to 7) of Instruction_bus;
    
    signal Instruction_set : program_rom := (
        "101110000000",     -- 0:   MOVI R7 0
        "10001000001",      -- 1:   MOVI R1 1
        "10010000010",      -- 2:   MOVI R2 2
        "10011000011",      -- 3:   MOVI R3 3
        "00111001000",      -- 4:   ADD R7, R1
        "00111010000",      -- 5:   ADD R7, R2
        "00111011000",      -- 6:   ADD R7, R3
        "11000000111"       -- 7:   JZR R0, 7
    );

begin
    -- Map ROM address to instruction output 
    Instruction <= Instruction_set(to_integer(unsigned(Memory_Select)));
end Behavioral;
