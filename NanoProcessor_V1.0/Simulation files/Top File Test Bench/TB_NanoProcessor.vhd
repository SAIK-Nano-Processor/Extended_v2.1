library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.BUSDEF.ALL;

entity TB_NanoProcessor is
-- Testbench entities are always completely empty!
end TB_NanoProcessor;

architecture Behavioral of TB_NanoProcessor is

    -- 1. Declare the Unit Under Test (UUT)
    component NanoProcessor
        Port ( 
            clock : in STD_LOGIC;
            reset : in STD_LOGIC;
            overflow : out STD_LOGIC;
            zero : out STD_LOGIC;
            seven_segment_out : out STD_LOGIC_VECTOR(6 downto 0);
            anode_out : out STD_LOGIC_VECTOR(3 downto 0);
            Data     : out Data_bus
        );
    end component;

    -- 2. Internal signals to connect to the processor
    -- Inputs (Initialized to 0)
    signal tb_clock : STD_LOGIC := '0';
    signal tb_reset : STD_LOGIC := '0';

    -- Outputs
    signal tb_overflow : STD_LOGIC;
    signal tb_zero : STD_LOGIC;
    signal tb_seven_segment_out : STD_LOGIC_VECTOR(6 downto 0);
    signal tb_anode_out : STD_LOGIC_VECTOR(3 downto 0);
    signal tb_Data : Data_bus;

    -- 3. Define the clock speed (10ns = 100MHz, standard for Basys 3 board)
    constant clock_period : time := 10 ns;

begin

    -- 4. Solder the processor to the testbench signals
    UUT: NanoProcessor PORT MAP (
        clock => tb_clock,
        reset => tb_reset,
        overflow => tb_overflow,
        zero => tb_zero,
        seven_segment_out => tb_seven_segment_out,
        anode_out => tb_anode_out,
        Data => tb_Data
    );

    -- 5. The Clock Generator (Ticks forever)
    clock_process :process
    begin
        tb_clock <= '0';
        wait for clock_period/2;
        tb_clock <= '1';
        wait for clock_period/2;
    end process;

    -- 6. The Stimulus (The "Human" interacting with the board)
    stim_proc: process
    begin       
        -- Push the reset button to clear everything
        tb_reset <= '1';
        wait for 100 ns;    
        
        -- Release the reset button and let the processor run!
        tb_reset <= '0';
        
        -- The testbench will now just wait forever while your 
        -- processor automatically fetches and executes instructions!
        wait;
    end process;

end Behavioral;