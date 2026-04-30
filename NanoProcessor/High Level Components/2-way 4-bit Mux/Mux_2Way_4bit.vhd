----------------------------------------------------------------------------------
-- Company: SAIK
-- Engineer:
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
    Port ( In0 : in Bus_4_bit;
           In1 : in Bus_4_bit;
           sel : in STD_LOGIC;
           out_mux : out Bus_4_bit);
end Mux_2Way_4bit;

architecture Behavioral of Mux_2Way_4bit is

begin

    out_mux <= In0 when (sel = '0') else In1;

end Behavioral;
