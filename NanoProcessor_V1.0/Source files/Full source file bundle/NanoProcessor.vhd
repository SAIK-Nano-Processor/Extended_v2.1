----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.04.2026 12:54:22
-- Design Name: 
-- Module Name: NanoProcessor - Behavioral
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

entity NanoProcessor is
    Port ( 
        clock : in STD_LOGIC; -- Slowed clock signal
        reset : in STD_LOGIC; -- Reset button input
        overflow : out STD_LOGIC; -- Overflow flag
        zero : out STD_LOGIC; --Zero flag
        seven_segment_out : out STD_LOGIC_VECTOR(6 downto 0); -- Output for the seven segment display
        anode_out : out STD_LOGIC_VECTOR(3 downto 0); -- vector to select the seven segment display
        Data     : out Data_bus -- Bus to store data in a register  
    );
end NanoProcessor;

architecture Behavioral of NanoProcessor is
    signal s_SlowClk : std_logic;
    
    signal s_SelectedAddr : Address_bus;
    signal s_PCCurrent : Address_bus;
    
    signal s_PCNext : Address_bus;
    
    signal s_JumpAddr : Address_bus;
    signal s_JumpEn : STD_LOGIC;
    
    signal s_Instruction : Instruction_bus;
    
    signal s_RegBankSel     : Address_bus;      -- Which register to write to
    signal s_RegSelA        : Address_bus;      -- Which register to read into Port A
    signal s_RegSelB        : Address_bus;      -- Which register to read into Port B
    signal s_ImmValue       : Data_bus;         -- The 4-bit number for MOVI
    signal s_OpSelect       : std_logic;        -- 0 for ADD, 1 for SUB
    signal s_LoadSel        : std_logic;        -- 0 for Imm, 1 for ALU
    
    signal s_RegBankData_out : Data_bus_8x4;
    signal s_RegBankData_in : Data_bus;
    
    signal s_MuxA_output : Data_bus;
    signal s_MuxB_output : Data_bus;
    
    signal s_Add_Sub_unit_output : Data_bus;
    
    component slow_clock
    Port ( clk_in  : in  STD_LOGIC;
           clk_out : out STD_LOGIC );
    end component;
    
    component Program_Counter
    Port ( D     : in  Address_bus;
           Clk   : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Q     : out Address_bus);
    end component;
    
    component RCA_3
    Port ( A     : in  Address_bus;
           B     : in  Address_bus;
           C_in  : in  STD_LOGIC;
           S     : out Address_bus;
           C_out : out STD_LOGIC);
    end component;
        
    component Mux_2Way_3bit
    Port ( In0     : in  Address_bus;
           In1     : in  Address_bus;
           sel     : in  STD_LOGIC;
           out_mux : out Address_bus);
    end component;
    
    component Program_ROM
    Port ( Memory_Select : in  Address_bus;
           Instruction    : out Instruction_bus ); 
    end component;
    
    component Instruction_Decoder
    Port ( 
        Instruction        : in Instruction_bus;
        Reg_val_for_Jump   : in Data_bus;
        Register_address   : out Address_bus;
        Register_select_A  : out Address_bus;
        Register_select_B  : out Address_bus;
        Immediate_value    : out Data_bus;
        ADD_SUB_Select     : out STD_LOGIC;
        Load_select        : out STD_LOGIC;
        Jump_flag          : out STD_LOGIC;
        Jump_Addr          : out Address_bus
    );
    end component;
    
    component RegBank
        Port ( 
           Clk : in STD_LOGIC;
           Reset : in  STD_LOGIC;
           Data_in : in Data_bus;
           Register_Address : in Address_bus;
           Data_out : out Data_bus_8x4
        );
    end component;
    
    component Mux_8way_4bit
        port (
            input_bus : in Data_bus_8x4;
            reg_select : in Address_bus;
            output_bus : out Data_Bus
        );
    end component;
    
    component ALU
        port (
            A : in Data_bus;
            B : in Data_bus;
            Add_Sub_Sel : in STD_LOGIC;
            S : out Data_bus;
            Zero : out STD_LOGIC;
            Overflow : out STD_LOGIC
        );
    end component;
    
    component Mux_2Way_4bit
        port(
            In0 : in Data_bus;
            In1 : in Data_bus;
            sel : in STD_LOGIC;
            out_mux : out Data_bus
        );
    end component;
    
    component LUT_16_7
        port(
            binary_in : in Data_bus; 
            seven_seg : out STD_LOGIC_VECTOR (6 downto 0)
        );
    end component;

begin
    anode_out <= "1110";
    Data <= s_RegBankData_out(7);
    
    Clock_Unit: slow_clock PORT MAP (
        clk_in  => Clock,      -- Connect the board's fast clock to the chip's input
        clk_out => s_SlowClk   -- Connect the chip's output to our internal motherboard wire
    );
    
    PC_Unit: Program_Counter PORT MAP (
        D     => s_SelectedAddr, -- The next address coming from the Mux
        Clk   => s_SlowClk,    
        Reset => reset,          -- Connected to the physical reset button
        Q     => s_PCCurrent     -- Sends current address out to the ROM and Adder
        );
        
    PC_Adder_Unit: RCA_3 PORT MAP (
        A     => s_PCCurrent, -- The current address from PC
        B     => "001",       -- Hardwired to '1' (to go to the next line)
        C_in  => '0',         -- no carry-in needed
        S     => s_PCNext,    -- The sum (PC + 1) goes out to the Mux
        C_out => open         -- leave disconnected!
    );
    
    Address_Mux: Mux_2Way_3bit PORT MAP (
        In0     => s_PCNext,      -- Default: go to next line (sel = '0')
        In1     => s_JumpAddr,    -- Override: go to jump address (sel = '1')
        sel     => s_JumpEn,      -- The toggle switch from the Instruction Decoder
        out_mux => s_SelectedAddr -- Goes back to the Program Counter
    );
    
    ROM_Unit: Program_ROM PORT MAP (
        Memory_Select => s_PCCurrent,
        Instruction    => s_Instruction
    );
    
    Decoder_Unit: Instruction_Decoder PORT MAP (
        Instruction        => s_Instruction,  -- Fed from the ROM
        Reg_val_for_Jump   => s_MuxA_output,     -- Fed from Register Mux A
        Register_address   => s_RegBankSel,
        Register_select_A  => s_RegSelA,
        Register_select_B  => s_RegSelB,
        Immediate_value    => s_ImmValue,
        ADD_SUB_Select     => s_OpSelect,
        Load_select        => s_LoadSel,
        Jump_flag          => s_JumpEn,       -- Connects back to the Address Mux!
        Jump_Addr          => s_JumpAddr      -- Connects back to the Address Mux!
    );
    
    Register_Bank_Unit: RegBank PORT MAP (
        Clk => s_SlowClk,
        Reset => reset,
        Data_in => s_RegBankData_in,
        Register_Address => s_RegBankSel,
        Data_out => s_RegBankData_out
        );
        
    Mux_8_way_4_bit_A: Mux_8way_4bit PORT MAP (
        input_bus => s_RegBankData_out,
        reg_select => s_RegSelA,
        output_bus => s_MuxA_output
        );
        
    Mux_8_way_4_bit_B: Mux_8way_4bit PORT MAP (
        input_bus => s_RegBankData_out,
        reg_select => s_RegSelB,
        output_bus => s_MuxB_output
        );  
        
    ADD_SUB_unit: ALU PORT MAP(
        A => s_MuxA_output,
        B => s_MuxB_output,
        Add_Sub_Sel => s_OpSelect,
        S => s_Add_Sub_unit_output,
        Zero => zero,
        Overflow => overflow
        );
    
    Mux_2_way_4_bi: Mux_2Way_4bit PORT MAP(
        In0 => s_ImmValue,
        In1 => s_Add_Sub_unit_output,
        sel => s_LoadSel,
        out_mux => s_RegBankData_in
        );
        
    Lokup_table: LUT_16_7 PORT MAP(
        binary_in => s_RegBankData_out(7),
        seven_seg => seven_segment_out
        );

end Behavioral;