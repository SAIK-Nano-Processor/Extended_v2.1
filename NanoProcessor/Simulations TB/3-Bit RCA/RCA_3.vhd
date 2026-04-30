----------------------------------------------------------------------------------
-- Company: SAIK 
-- Engineer: Jayakody K.I.A
-- 
-- Create Date: 04/26/2026 02:41:08 PM
-- Design Name: 
-- Module Name: RCA_3 - Behavioral
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

entity tb_RCA_3 is
--  Port ( );
end tb_RCA_3;

architecture Behavioral of tb_RCA_3 is
component RCA_3
        Port ( A : in Data_bus_3_bit;
               B : in Data_bus_3_bit;
               C_in : in STD_LOGIC;
               S : out Data_bus_3_bit;
               C_out : out STD_LOGIC);
    end component;
    
    -- Inputs 
        signal tb_A : Data_bus_3_bit := "000";
        signal tb_B : Data_bus_3_bit := "000";
        signal tb_C_in : STD_LOGIC := '0';
     --outputs   
        signal tb_S : Data_bus_3_bit;
        signal tb_C_out : STD_LOGIC;

begin
UUT: RCA_3 port map (
        A => tb_A,
        B => tb_B,
        C_in => tb_C_in,
        S => tb_S,
        C_out => tb_C_out
    );
    
    stimulus_process: process
        begin
            
            wait for 100 ns;
            
            --111 010 101 010 000 110 my index : 240262T
            
            tb_A <= "110"; --6
            tb_B <= "000"; --0
            tb_C_in <= '0';
            wait for 100 ns;
    
            
            tb_A <= "010"; --2
            tb_B <= "101"; --5
            tb_C_in <= '0';
            wait for 100 ns;
    
            
            tb_A <= "010"; --2
            tb_B <= "111"; --7
            tb_C_in <= '0';
            wait for 100 ns;
    

            tb_A <= "010"; --2
            tb_B <= "010"; --2
            tb_C_in <= '0';
            wait for 100 ns;
    
            
            wait;
        end process;


end Behavioral;

