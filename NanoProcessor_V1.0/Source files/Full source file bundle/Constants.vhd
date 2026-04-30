----------------------------------------------------------------------------------
-- Company: SAIK
-- Engineer: ISIWARA M.A.G.A
-- 
-- Create Date: 30.04.2026 12:59:33
-- Design Name: 
-- Module Name: Constants - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


package Constants is
    -- OP Codes
    constant MOVI_OP : std_logic_vector(1 downto 0) := "10";
    constant ADD_OP : std_logic_vector(1 downto 0) := "00";
    constant NEG_OP : std_logic_vector(1 downto 0) := "01";
    constant JZR_OP : std_logic_vector(1 downto 0) := "11";

end package Constants;