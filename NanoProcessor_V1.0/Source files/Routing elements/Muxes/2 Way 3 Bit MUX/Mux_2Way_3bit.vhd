----------------------------------------------------------------------------------
-- Company: SAIK
-- Engineer: Jyakody KIA
-- 
-- Create Date: 04/30/2026 11:58:22 AM
-- Design Name: 
-- Module Name: Mux_2Way_3bit - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux_2Way_3bit is
    Port ( In0 : in Address_bus;
           In1 : in Address_bus;
           sel : in STD_LOGIC;
           out_mux : out Address_bus);
end Mux_2Way_3bit;

architecture Behavioral of Mux_2Way_3bit is

begin

    out_mux <= In0 when (sel = '0') else In1;

end Behavioral;
