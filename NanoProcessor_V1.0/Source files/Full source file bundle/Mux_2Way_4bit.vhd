----------------------------------------------------------------------------------
-- Company: SAIK
-- Engineer: Jayalath K.D
--
-- Create Date: 04/30/2026
-- Design Name:
-- Module Name: Mux_2Way_4bit - Behavioral
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
use WORK.BUSDEF.all;

entity Mux_2Way_4bit is
    Port ( In0 : in Data_bus;
           In1 : in Data_bus;
           sel : in STD_LOGIC;
           out_mux : out Data_bus);
end Mux_2Way_4bit;

architecture Behavioral of Mux_2Way_4bit is

begin
    out_mux <= In0 when (sel = '0') else In1;
end Behavioral;
