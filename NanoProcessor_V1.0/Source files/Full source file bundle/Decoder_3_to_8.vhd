----------------------------------------------------------------------------------
-- Company: SAIK
-- Engineer: Jayalath K.D
-- 
-- Create Date: 02/24/2026 03:04:58 PM
-- Design Name: 
-- Module Name: Decoder_3_to_8 - Behavioral
-- Project Name: 
-- Target Devices: 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.BUSDEF.ALL;

entity Decoder_3_to_8 is
    Port ( 
        I  : in  Address_bus;
        EN : in  STD_LOGIC;
        Y  : out Memory_selector
    );
end Decoder_3_to_8;

architecture Behavioral of Decoder_3_to_8 is

    component Decoder_2_to_4
        port( 
            I  : in  STD_LOGIC_VECTOR(1 downto 0);
            EN : in  STD_LOGIC;
            Y  : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;
    
    signal I_sub      : STD_LOGIC_VECTOR(1 downto 0);
    signal Y_low, Y_high : STD_LOGIC_VECTOR(3 downto 0);
    signal en0, en1   : STD_LOGIC;

begin

    -- Use MSB (I(2)) to determine which 2-to-4 block is active
    en0 <= NOT(I(2)) AND EN;
    en1 <= I(2)      AND EN;
    
    -- Pass shared lower 2 bits to both decoders
    I_sub <= I(1 downto 0);

    Decoder_2_to_4_0 : Decoder_2_to_4
    port map(
        I  => I_sub,
        EN => en0,
        Y  => Y_low
    );
        
    Decoder_2_to_4_1 : Decoder_2_to_4
    port map(
        I  => I_sub,
        EN => en1,
        Y  => Y_high
    );
    
    -- Combine outputs into the 8-bit memory selector bus
    Y(3 downto 0) <= Y_low;
    Y(7 downto 4) <= Y_high;

end Behavioral;
