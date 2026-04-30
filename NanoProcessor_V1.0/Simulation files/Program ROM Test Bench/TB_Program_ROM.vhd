----------------------------------------------------------------------------------
-- Company: SAIK
-- Engineer: ISIWARA M.A.G.A
-- 
-- Create Date: 30.04.2026 02:27:38
-- Design Name: 
-- Module Name: TB_Program_ROM - Behavioral
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
use WORK.BUSDEF.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_Program_ROM is
--  Port ( );
end TB_Program_ROM;

architecture Behavioral of TB_Program_ROM is
    component Program_ROM
        Port ( 
            Memory_Address : in  Address_sel;
            Instruction    : out Instruction_bus
        );
    end component;
    
    signal Memory_Address : Address_sel;
    signal Instruction    : Instruction_bus;
    
begin
    uut: Program_ROM PORT MAP (
        Memory_Address => Memory_Address,
        Instruction    => Instruction
    );
    
    process
    begin        
        -- Read Slot 0: Should output "101110000000" (MOVI R7 0)
        Memory_Address <= "000";
        wait for 10 ns;
    
        -- Read Slot 1: Should output "10001000001" (MOVI R1 1)
        Memory_Address <= "001";
        wait for 10 ns;
    
        -- Read Slot 2: Should output "10010000010" (MOVI R2 2)
        Memory_Address <= "010";
        wait for 10 ns;
    
        -- Read Slot 3: Should output "10011000011" (MOVI R3 3)
        Memory_Address <= "011";
        wait for 10 ns;
    
        -- Read Slot 4: Should output "00111001000" (ADD R7, R1)
        Memory_Address <= "100";
        Wait for 10 ns;
    
        -- Read Slot 5: Should output "00111010000" (ADD R7, R2)
        Memory_Address <= "101";
        wait for 10 ns;
        
        -- Read Slot 6: Should output "00111011000" (ADD R7, R3)
        Memory_Address <= "110";
        wait for 10 ns;
            
        -- Read Slot 6: Should output ""110000000100"" (JZR R0, 7)
        Memory_Address <= "111";
        wait for 10 ns;
    
        -- End the simulation
   wait;
   end process;
end Behavioral;
