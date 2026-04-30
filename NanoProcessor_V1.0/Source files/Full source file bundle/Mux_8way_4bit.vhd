----------------------------------------------------------------------------------
-- Company: SAIK
-- Engineer: Jayarathne D.G.S.A
-- 
-- Create Date: 04/26/2026 03:09:31 PM
-- Design Name: 
-- Module Name: Mux_8way_4bit - Behavioral
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
use WORK.BusDef.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux_8way_4bit is
    Port ( input_bus : in Data_bus_8x4;
           reg_select : in Address_bus;
           output_bus : out Data_Bus);
end Mux_8way_4bit;

architecture Behavioral of Mux_8way_4bit is

begin
    with reg_select select output_bus <=
        input_bus(0) when "000",
        input_bus(1) when "001",
        input_bus(2) when "010",
        input_bus(3) when "011",
        input_bus(4) when "100",
        input_bus(5) when "101",
        input_bus(6) when "110",
        input_bus(7) when "111",
        "XXXX" when others; -- Safety fallback

end Behavioral;
