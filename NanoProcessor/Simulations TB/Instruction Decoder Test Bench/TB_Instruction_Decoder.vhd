----------------------------------------------------------------------------------
-- Company: SAIK
-- Engineer: ISIWARA M.A.G.A
-- 
-- Create Date: 30.04.2026 00:00:56
-- Design Name: 
-- Module Name: TB_Instruction_Decoder - Behavioral
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
use WORK.CONSTANTS.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TB_Instruction_Decoder is
--  Port ( );
end TB_Instruction_Decoder;

architecture Behavioral of TB_Instruction_Decoder is
    -- Component under test
    component Instruction_Decoder
        Port ( 
            Instruction         : in Instruction_bus;
            Reg_val_for_Jump    : in Data_bus;       
            Register_address    : out Address_sel;
            Register_select_A   : out Address_sel;
            Register_select_B   : out Address_sel;
            Immediate_value     : out Data_bus;
            ADD_SUB_Select      : out STD_LOGIC;
            Load_select         : out STD_LOGIC;
            Jump_flag           : out STD_LOGIC;
            Jump_Addr           : out Address_sel
        );
    end component;
    
    -- Inputs
    signal Instruction      : Instruction_bus := (others => '0');
    signal Reg_val_for_Jump : Data_bus := (others => '0');
    
    -- Outputs
    signal Register_address  : Address_sel;
    signal Register_select_A : Address_sel;
    signal Register_select_B : Address_sel;
    signal Immediate_value   : Data_bus;
    signal ADD_SUB_Select    : STD_LOGIC;
    signal Load_select       : STD_LOGIC;
    signal Jump_flag         : STD_LOGIC;
    signal Jump_Addr         : Address_sel;
    
begin
    uut: Instruction_Decoder PORT MAP (
        Instruction         => Instruction,
        Reg_val_for_Jump    => Reg_val_for_Jump,
        Register_address    => Register_address,
        Register_select_A   => Register_select_A,
        Register_select_B   => Register_select_B,
        Immediate_value     => Immediate_value,
        ADD_SUB_Select      => ADD_SUB_Select,
        Load_select         => Load_select,
        Jump_flag           => Jump_flag,
        Jump_Addr           => Jump_Addr
    );
    
    process
    begin        
        -- INSTRUCTION 1: MOVI R1, 10 
        -- Format: 10 RRR 000 dddd
        -- Instruction : 10 001 000 1010
        Instruction <= "100010001010";
        wait for 10 ns;
    
        -- INSTRUCTION 2: ADD R2, R3 
        -- Format: 00 RaRaRa RbRbRb 0000
        -- Instruction : 00 010 011 0000
        Instruction <= "000100110000";
        wait for 10 ns;
    
        -- INSTRUCTION 3: NEG R4 
        -- Format: 01 RRR 000 0000
        -- Instruction : 01 100 000 0000
        Instruction <= "011000000000";
        wait for 10 ns;
    
        -- INSTRUCTION 4: JZR R5, 7 (Jump Condition MET) 
        -- Format: 11 RRR 000 0ddd
        -- Instruction : 11 101 000 0111
        Instruction <= "111010000111";
        Reg_val_for_Jump <= "0000"; -- Register 5 holds 0, so it SHOULD jump (since we dont have mux we hardcode that)
        wait for 10 ns;
    
        -- INSTRUCTION 5: JZR R5, 7 (Jump Condition NOT MET)
        -- Format: 11 RRR 000 0ddd
         -- Instruction : 11 101 000 0111
        Instruction <= "111010000111";
        Reg_val_for_Jump <= "0011"; -- Register holds 3, so it should NOT jump (since we dont have mux we hardcode that)
        wait for 10 ns;
    
        -- End simulation
        wait;
    end process;
end Behavioral;
