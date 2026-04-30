----------------------------------------------------------------------------------
-- Company: SAIK
-- Engineer: Jayakody K.I.A
-- 
-- Create Date: 04/29/2026 03:00:09 PM
-- Design Name: 
-- Module Name: ALU_tb - Behavioral
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

entity ALU_tb is
--  Port ( );
end ALU_tb;

architecture Behavioral of ALU_tb is

    -- 1. Declare the ALU_4 component
    component ALU
        Port ( A           : in Data_bus;
               B           : in Data_bus;
               Add_Sub_Sel : in STD_LOGIC;
               S           : out Data_bus;
               Zero        : out STD_LOGIC;
               Overflow    : out STD_LOGIC);
    end component;

    -- 2. Declare internal signals to drive the inputs and read outputs
    signal A_in          : Data_bus := "0000";
    signal B_in          : Data_bus := "0000";
    signal Add_Sub_Sel_in: STD_LOGIC := '0';
    
    signal S_out         : Data_bus;
    signal Zero_out      : STD_LOGIC;
    signal Overflow_out  : STD_LOGIC;

begin

    
    UUT: ALU
        port map (
            A           => A_in,
            B           => B_in,
            Add_Sub_Sel => Add_Sub_Sel_in,
            S           => S_out,
            Zero        => Zero_out,
            Overflow    => Overflow_out
        );

    -- 4. Stimulus Process (Applying the test cases)
    stim_proc: process
    begin
        -- Hold initial state for 100 ns
        wait for 100 ns;

        -------------------------------------------------------------
        --Test 1- Index Number 240262 : 11 1010 1010 1000 0110 
        -------------------------------------------------------------
        A_in <= "0110"; 
        B_in <= "1000"; 
        Add_Sub_Sel_in <= '0'; 
        wait for 100 ns;

        -------------------------------------------------------------
        -- TEST 2: Subtraction Triggering ZERO Flag (4 - 4 = 0)
        -- Ensures 2's complement subtraction works and Zero flag goes HIGH.
        -------------------------------------------------------------
        A_in <= "0100"; 
        B_in <= "0100"; 
        Add_Sub_Sel_in <= '1'; 
        wait for 100 ns;

        -------------------------------------------------------------
        -- TEST 3: Addition Triggering OVERFLOW Flag (7 + 1 = 8)
        -------------------------------------------------------------
        A_in <= "0111"; 
        B_in <= "0001"; 
        Add_Sub_Sel_in <= '0'; 
        wait for 100 ns;

        -------------------------------------------------------------
        -- TEST 4: Subtraction Yielding Negative Result (2 - 5 = -3
        -------------------------------------------------------------
        A_in <= "0010"; 
        B_in <= "0101"; 
        Add_Sub_Sel_in <= '1'; 
        wait for 100 ns;

        -- End the simulation
        wait;
    end process;

end Behavioral;