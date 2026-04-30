----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2026 12:21:59 PM
-- Design Name: 
-- Module Name: Program Counter - Behavioral
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

entity Program_Counter is
    Port ( D : Address_sel;
           Clk : in STD_LOGIC;
           Reset : in STD_LOGIC;
           Q : out Address_sel);
end Program_Counter;

architecture Behavioral of Program_Counter is

begin
    process (Clk, Reset)
        begin
            -- Asynchronous Reset: If the reset button is pushed, clear the PC immediately
            if (Reset = '1') then
                Q <= "000";
                
            -- Synchronous Update: Only update the PC on the rising edge of the clock
            elsif rising_edge(Clk) then
                Q <= D; 
                
            end if;
    end process;

end Behavioral;
