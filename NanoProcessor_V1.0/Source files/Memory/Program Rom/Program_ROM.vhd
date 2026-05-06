----------------------------------------------------------------------------------
-- Company: SAIK
-- Engineer: ISIWARA M.A.G.A
-- 
-- Create Date: 30.04.2026 01:52:55
-- Design Name: 8-Instruction Program ROM
-- Module Name: Program_ROM - Behavioral
-- Project Name: Lab 9-10
-- Description: 
-- Stores instructions for the NanoProcessor. Hardcoded for resource minimization.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.BUSDEF.ALL;

entity Program_ROM is
    Port ( 
        Instruction   : out Instruction_bus;   -- 12-bit Instruction output
        Memory_Select : in  Address_bus        -- 3-bit Address input (0-7)
    );
end Program_ROM;

architecture Behavioral of Program_ROM is

begin
    -- This maps the ROM directly into LUTs as a combinational logic block.
    with Memory_Select select Instruction <= 
        "101110000000" when "000",  -- 0: MOVI R7, 0 
        "100010000001" when "001",  -- 1: MOVI R1, 1 
        "001110010000" when "010",  -- 2: ADD  R7, R1
        "100100000010" when "011",  -- 3: MOVI R2, 2 
        "001110100000" when "100",  -- 4: ADD  R7, R2 
        "100110000011" when "101",  -- 5: MOVI R3, 3        
        "001110110000" when "110",  -- 6: ADD  R7, R3 
        "110000000000" when "111",  -- 7: JZR  R0, 0 (Infinite Loop/Halt)
        "000000000000" when others; -- Safety default

end Behavioral;
