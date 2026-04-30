library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.BUSDEF.ALL; 


entity TB_Mux_2Way_3bit is
end TB_Mux_2Way_3bit;

architecture Behavioral of TB_Mux_2Way_3bit is

    
    component Mux_2Way_3bit
        Port ( In0     : in Bus_3_bit;
               In1     : in Bus_3_bit;
               sel     : in STD_LOGIC;
               out_mux : out Bus_3_bit);
    end component;

    signal In0_tb     : Bus_3_bit := "000";
    signal In1_tb     : Bus_3_bit := "000";
    signal sel_tb     : STD_LOGIC := '0';
    
    
    signal out_mux_tb : Bus_3_bit;

begin

    
    UUT: Mux_2Way_3bit port map (
        In0     => In0_tb,
        In1     => In1_tb,
        sel     => sel_tb,
        out_mux => out_mux_tb
    );

    
    stim_proc: process
    begin
        
        wait for 100 ns;
        
        --111 010 101 010 000 110 - 240262 index
        -------------------------------------------------------------
        -- TEST CASE 1: Select In0 (Normal PC execution)
        -- sel = '0', expect out_mux to equal In0 ("110")
        -------------------------------------------------------------
        In0_tb <= "110"; 
        In1_tb <= "000"; 
        sel_tb <= '0';
        wait for 100 ns;

        -------------------------------------------------------------
        -- TEST CASE 2: Select In1 (Jump Instruction triggered)
        -- sel = '1', expect out_mux to instantly switch to In1 ("111")
        -------------------------------------------------------------
        sel_tb <= '1';
        wait for 100 ns;

        -------------------------------------------------------------
        -- TEST CASE 3: Change inputs while jumping
        -- Keep sel = '1', change In1 to ensure output tracks the change
        -------------------------------------------------------------
        In0_tb <= "010";
        In1_tb <= "101";
        wait for 100 ns;

        -------------------------------------------------------------
        -- TEST CASE 4: Switch back to normal execution
        -- sel = '0', expect out_mux to switch back to In0 
        -------------------------------------------------------------
        sel_tb <= '0';
        wait for 100 ns;

        -- End the simulation
        wait;
    end process;

end Behavioral;