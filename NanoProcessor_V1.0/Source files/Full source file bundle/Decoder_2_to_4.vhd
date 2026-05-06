----------------------------------------------------------------------------------
-- Company: SAIK
-- Engineer: Jayalath K.D
-- 
-- Create Date: 02/24/2026 01:47:29 PM
-- Design Name: 
-- Module Name: Decoder_2_to_4 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder_2_to_4 is
    Port ( 
        I  : in  STD_LOGIC_VECTOR (1 downto 0);
        EN : in  STD_LOGIC;
        Y  : out STD_LOGIC_VECTOR (3 downto 0)
    );
end Decoder_2_to_4;

architecture Behavioral of Decoder_2_to_4 is

begin

    -- Minimum logic gate implementation for 2-to-4 decoding
    Y(0) <= (NOT I(1)) AND (NOT I(0)) AND EN;
    Y(1) <= (NOT I(1)) AND I(0)       AND EN;
    Y(2) <= I(1)       AND (NOT I(0)) AND EN;
    Y(3) <= I(1)       AND I(0)       AND EN;

end Behavioral;
