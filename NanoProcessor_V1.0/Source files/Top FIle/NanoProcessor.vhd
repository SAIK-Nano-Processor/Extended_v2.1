----------------------------------------------------------------------------------
-- Company: SAIK
-- Engineer: Isiwara M.A.G.A
-- 
-- Module Name: NanoProcessor - Behavioral
-- Description: 
-- Top-level structural integration of the 4-bit NanoProcessor.
-- Optimized for minimum FPGA resource utilization (LUTs and Flip-Flops).
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.BUSDEF.ALL;
use WORK.CONSTANTS.ALL;

entity NanoProcessor is
    Port ( 
        clock             : in  STD_LOGIC; -- 100MHz System Clock
        reset             : in  STD_LOGIC; -- Global Reset
        overflow          : out STD_LOGIC; -- ALU Overflow Flag
        zero              : out STD_LOGIC; -- ALU Zero Flag
        seven_segment_out : out STD_LOGIC_VECTOR(6 downto 0); -- Display output
        anode_out         : out STD_LOGIC_VECTOR(3 downto 0); -- Display selector
        Data              : out Data_bus   -- Monitors Register 7
    );
end NanoProcessor;

architecture Behavioral of NanoProcessor is

    -- Internal Signals
    signal s_SlowClk         : std_logic;
    signal s_SelectedAddr    : Address_bus;
    signal s_PCCurrent       : Address_bus;
    signal s_PCNext          : Address_bus;
    signal s_JumpAddr        : Address_bus;
    signal s_JumpEn          : STD_LOGIC;
    signal s_Instruction     : Instruction_bus;
    signal s_RegBankSel      : Address_bus;
    signal s_RegSelA         : Address_bus;
    signal s_RegSelB         : Address_bus;
    signal s_ImmValue        : Data_bus;
    signal s_OpSelect        : std_logic;
    signal s_LoadSel         : std_logic;
    signal s_RegBankData_out : Data_bus_8x4;
    signal s_RegBankData_in  : Data_bus;
    signal s_MuxA_output     : Data_bus;
    signal s_MuxB_output     : Data_bus;
    signal s_ALU_output      : Data_bus;

    -- Component Declarations
    component slow_clock
        Port ( clk_in : in STD_LOGIC; clk_out : out STD_LOGIC );
    end component;
    
    component Program_Counter
        Port ( D : in Address_bus; Clk : in STD_LOGIC; Reset : in STD_LOGIC; Q : out Address_bus );
    end component;
    
    component RCA_3
        Port ( A, B : in Address_bus; C_in : in STD_LOGIC; S : out Address_bus; C_out : out STD_LOGIC );
    end component;
        
    component Mux_2Way_3bit
        Port ( In0, In1 : in Address_bus; sel : in STD_LOGIC; out_mux : out Address_bus );
    end component;
    
    component Program_ROM
        Port ( Memory_Select : in Address_bus; Instruction : out Instruction_bus ); 
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
        Port ( Clk, Reset : in STD_LOGIC; Data_in : in Data_bus; Register_Address : in Address_bus; Data_out : out Data_bus_8x4 );
    end component;
    
    component Mux_8way_4bit
        port ( input_bus : in Data_bus_8x4; reg_select : in Address_bus; output_bus : out Data_Bus );
    end component;
    
    component ALU
        port ( A, B : in Data_bus; Add_Sub_Sel : in STD_LOGIC; S : out Data_bus; Zero, Overflow : out STD_LOGIC );
    end component;
    
    component Mux_2Way_4bit
        port( In0, In1 : in Data_bus; sel : in STD_LOGIC; out_mux : out Data_bus );
    end component;
    
    component LUT_16_7
        port( binary_in : in Data_bus; seven_seg : out STD_LOGIC_VECTOR (6 downto 0) );
    end component;

begin
    -- External Pins Logic
    anode_out <= "1110"; -- Selects the rightmost 7-segment display (Active Low)
    Data      <= s_RegBankData_out(7); -- Map R7 to LEDs for hardware monitoring

    Clock_Unit: slow_clock PORT MAP (
        clk_in  => clock,
        clk_out => s_SlowClk
    );
    
    PC_Unit: Program_Counter PORT MAP (
        D     => s_SelectedAddr,
        Clk   => s_SlowClk,
        Reset => reset,
        Q     => s_PCCurrent
    );
        
    PC_Adder_Unit: RCA_3 PORT MAP (
        A     => s_PCCurrent,
        B     => "001",
        C_in  => '0',
        S     => s_PCNext,
        C_out => open 
    );
    
    Address_Mux: Mux_2Way_3bit PORT MAP (
        In0     => s_PCNext,
        In1     => s_JumpAddr,
        sel     => s_JumpEn,
        out_mux => s_SelectedAddr
    );
    
    ROM_Unit: Program_ROM PORT MAP (
        Memory_Select => s_PCCurrent,
        Instruction   => s_Instruction
    );
    
    Decoder_Unit: Instruction_Decoder PORT MAP (
        Instruction        => s_Instruction,
        Reg_val_for_Jump   => s_MuxA_output, 
        Register_address   => s_RegBankSel,
        Register_select_A  => s_RegSelA,
        Register_select_B  => s_RegSelB,
        Immediate_value    => s_ImmValue,
        ADD_SUB_Select     => s_OpSelect,
        Load_select        => s_LoadSel,
        Jump_flag          => s_JumpEn,
        Jump_Addr          => s_JumpAddr
    );
    
    Register_Bank_Unit: RegBank PORT MAP (
        Clk              => s_SlowClk,
        Reset            => reset,
        Data_in          => s_RegBankData_in,
        Register_Address => s_RegBankSel,
        Data_out         => s_RegBankData_out
    );
        
    Mux_A: Mux_8way_4bit PORT MAP (
        input_bus  => s_RegBankData_out,
        reg_select => s_RegSelA,
        output_bus => s_MuxA_output
    );
        
    Mux_B: Mux_8way_4bit PORT MAP (
        input_bus  => s_RegBankData_out,
        reg_select => s_RegSelB,
        output_bus => s_MuxB_output
    );  
        
    Arithmetic_Logic_Unit: ALU PORT MAP(
        A           => s_MuxA_output,
        B           => s_MuxB_output,
        Add_Sub_Sel => s_OpSelect,
        S           => s_ALU_output,
        Zero        => zero,
        Overflow    => overflow
    );
    
    Register_Input_Mux: Mux_2Way_4bit PORT MAP(
        In0     => s_ImmValue,
        In1     => s_ALU_output,
        sel     => s_LoadSel,
        out_mux => s_RegBankData_in
    );
        
    -- 5. Output Display Unit
    Display_LUT: LUT_16_7 PORT MAP(
        binary_in => s_RegBankData_out(7), -- Show R7 on 7-segment
        seven_seg => seven_segment_out
    );

end Behavioral;
