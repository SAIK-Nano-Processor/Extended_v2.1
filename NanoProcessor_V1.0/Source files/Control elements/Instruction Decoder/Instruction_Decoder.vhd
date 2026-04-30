----------------------------------------------------------------------------------
-- Company: SAIK
-- Engineer: ISIWARA M.A.G.A
-- 
-- Create Date: 29.04.2026 21:29:24
-- Design Name: 
-- Module Name: Instruction_Decoder - Behavioral
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

entity Instruction_Decoder is
    Port ( 
        Instruction         : in Instruction_bus;   -- Instruction form the ROM
        Reg_val_for_Jump    : in Data_bus;          -- Register for jump       
        Register_address    : out Address_bus;      -- Address selector for register bank
        Register_select_A   : out Address_bus;      -- Address selector for register A
        Register_select_B   : out Address_bus;      -- Address selector for register B
        Immediate_value     : out Data_bus;         -- Immediate value from instruction
        ADD_SUB_Select      : out STD_LOGIC;        -- '0' for ADD and '1' for SUB
        Load_select         : out STD_LOGIC;        -- '0' for Immediate value and '1' for ALU
        Jump_flag           : out STD_LOGIC;        -- Jump flag for PC -- '1' to jump
        Jump_Addr           : out Address_bus       -- Jump address
    );
end Instruction_Decoder;

architecture Behavioral of Instruction_Decoder is
    signal Opcode : std_logic_vector(1 downto 0); -- variable to store opcode
begin
    Opcode <= Instruction(11 downto 10); -- Extract the opcode from the instruction (11th and 10th bit)
    
    decode : process(Opcode, Reg_val_for_Jump, Instruction)
    begin
        --initializing outputs to 0
        Register_address    <= "000";
        Register_select_A   <= "000";
        Register_select_B   <= "000";
        Immediate_value     <= "0000";
        ADD_SUB_Select      <= '0';
        Load_select         <= '0';
        Jump_flag           <= '0';
        Jump_Addr           <= "000";
        
        case Opcode is
            when MOVI_OP =>                                         -- Move Immediate value d to register r
                Immediate_Value     <= Instruction(3 downto 0);
                Load_Select         <= '0';                         -- Immediate load mode
                Register_address    <= Instruction(9 downto 7);
                
            when ADD_OP =>                                          -- Add operation
                Register_Select_A   <= Instruction(9 downto 7);
                Register_Select_B   <= Instruction(6 downto 4);
                ADD_SUB_Select      <= '0';                         -- Addition
                Load_Select         <= '1';                         -- ALU load mode
                Register_address    <= Instruction(9 downto 7);
                
            when NEG_OP =>                                          -- Negate operation
                Register_Select_A   <= "000";                       -- Select Register 0 (= zero)
                Register_Select_B   <= Instruction(9 downto 7);
                ADD_SUB_Select      <= '1';                         -- Subtraction
                Load_Select         <= '1';                         -- ALU load mode
                Register_address    <= Instruction(9 downto 7);
                
            when JZR_OP =>                                          -- Jump if Zero
                Register_Select_A   <= Instruction(9 downto 7);
                
                if Reg_val_for_Jump = "0000" then
                    Jump_flag       <= '1';                         -- Jump flag set to '1'
                    Jump_Addr       <= Instruction(2 downto 0);
                else
                    Jump_flag       <= '0';                         -- No jump (Register value for jump is not zero)
                end if;
                
            when others =>
                -- All outputs already have default values (= Zeros)
        end case;
    end process decode;
end Behavioral;
