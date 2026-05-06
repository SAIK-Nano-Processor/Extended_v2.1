----------------------------------------------------------------------------------
-- Company: SAIK
-- Engineer: ISIWARA M.A.G.A
-- 
-- Create Date: 29.04.2026 21:29:24
-- Design Name: 
-- Module Name: Instruction_Decoder - Behavioral
-- Project Name: 
-- Target Devices: Basys 3
-- Description: 
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.BUSDEF.ALL;
use WORK.CONSTANTS.ALL;

entity Instruction_Decoder is
    Port ( 
        Instruction        : in Instruction_bus;   -- Instruction from the ROM
        Reg_val_for_Jump   : in Data_bus;          -- Register value for jump check        
        Register_address   : out Address_bus;      -- Address selector for register bank
        Register_select_A  : out Address_bus;      -- Address selector for Mux A
        Register_select_B  : out Address_bus;      -- Address selector for Mux B
        Immediate_value    : out Data_bus;         -- Immediate value from instruction
        ADD_SUB_Select     : out STD_LOGIC;        -- '0' for ADD, '1' for SUB/NEG
        Load_select        : out STD_LOGIC;        -- '0' for Immediate, '1' for ALU
        Jump_flag          : out STD_LOGIC;        -- Jump flag for PC ('1' to jump)
        Jump_Addr          : out Address_bus       -- Jump address
    );
end Instruction_Decoder;

architecture Behavioral of Instruction_Decoder is
    signal Opcode : std_logic_vector(1 downto 0); 
begin
    
    -- Extract the opcode from the 12-bit instruction (11th and 10th bit)
    Opcode <= Instruction(11 downto 10); 
    
    -- These wire directly to the outputs to save LUTs. Downstream MUXes 
    -- will safely ignore these buses when they are not needed.
    Immediate_value <= Instruction(3 downto 0);
    Jump_Addr       <= Instruction(2 downto 0);
    
    decode : process(Opcode, Reg_val_for_Jump, Instruction)
    begin
        -- Default assignments to prevent unwanted memory latches
        Register_address    <= "000";
        Register_select_A   <= "000";
        Register_select_B   <= "000";
        ADD_SUB_Select      <= '0';
        Load_select         <= '0';
        Jump_flag           <= '0';
        
        case Opcode is
            when MOVI_OP =>                                         
                Load_Select         <= '0';                             
                Register_address    <= Instruction(9 downto 7);
                
            when ADD_OP =>                                          
                Register_Select_A   <= Instruction(9 downto 7);
                Register_Select_B   <= Instruction(6 downto 4);
                ADD_SUB_Select      <= '0';                             
                Load_Select         <= '1';                             
                Register_address    <= Instruction(9 downto 7);
                
            when NEG_OP =>                                          
                Register_Select_A   <= "000"; -- Hardwired to R0 (0000)                           
                Register_Select_B   <= Instruction(9 downto 7);
                ADD_SUB_Select      <= '1';                             
                Load_Select         <= '1';                             
                Register_address    <= Instruction(9 downto 7);
                
            when JZR_OP =>                                          
                Register_Select_A   <= Instruction(9 downto 7);
                if Reg_val_for_Jump = "0000" then
                    Jump_flag       <= '1';                             
                end if;
                
            when others =>
                null; -- Safely fall back to default assignments
                
        end case;
    end process decode;
    
end Behavioral;
