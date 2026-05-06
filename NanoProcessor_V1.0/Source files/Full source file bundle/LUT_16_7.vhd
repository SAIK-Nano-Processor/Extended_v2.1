----------------------------------------------------------------------------------
-- Company: SAIK
-- Engineer: Jayarathne D.G.S.A
-- 
-- Create Date: 04/27/2026 01:09:11 PM
-- Design Name: 
-- Module Name: LUT_16_7 - Behavioral
-- Project Name: Lab 9-10
-- Target Devices: Basys 3
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

entity LUT_16_7 is
    Port ( 
        binary_in : in Data_bus; 
        seven_seg : out STD_LOGIC_VECTOR (6 downto 0)
    );
end LUT_16_7;

architecture Behavioral of LUT_16_7 is

begin
    with binary_in select seven_seg <= 
        "1000000" when "0000", -- 0 
        "1111001" when "0001", -- 1
        "0100100" when "0010", -- 2
        "0110000" when "0011", -- 3
        "0011001" when "0100", -- 4
        "0010010" when "0101", -- 5
        "0000010" when "0110", -- 6
        "1111000" when "0111", -- 7
        "0000000" when "1000", -- 8
        "0010000" when "1001", -- 9
        "0001000" when "1010", -- A 
        "0000011" when "1011", -- b
        "1000110" when "1100", -- C
        "0100001" when "1101", -- d
        "0000110" when "1110", -- E
        "0001110" when "1111", -- F 
        "1111111" when others; -- Default case to prevent unwanted latches

end Behavioral;
