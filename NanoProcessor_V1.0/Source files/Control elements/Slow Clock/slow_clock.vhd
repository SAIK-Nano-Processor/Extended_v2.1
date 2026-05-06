----------------------------------------------------------------------------------
-- Company: SAIK
-- Engineer: Jayarathne D.G.S.A
-- 
-- Create Date: 04/27/2026 02:00:03 PM
-- Module Name: slow_clock - Behavioral
-- Description: 
-- Optimized 1Hz clock generator. Uses a constrained integer to minimize 
-- Flip-Flop usage (26-bit vs default 32-bit).
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity slow_clock is
    Port ( 
        clk_in  : in  STD_LOGIC; 
        clk_out : out STD_LOGIC 
    );
end slow_clock;

architecture Behavioral of slow_clock is
    -- Range constraint prevents Vivado from using a 32-bit register.
    signal count      : integer range 1 to 50000000 := 1;
    signal clk_status : std_logic := '0';
begin

    -- Concurrent assignment ensures clk_out always follows the status bit
    clk_out <= clk_status;

    process (clk_in)
    begin
        if rising_edge(clk_in) then
            if (count = 50000000) then 
                clk_status <= not clk_status; -- Toggle every 0.5s for 1Hz frequency
                count <= 1;                   -- Reset the counter
            else
                count <= count + 1;
            end if;
        end if;
    end process;

end Behavioral;
