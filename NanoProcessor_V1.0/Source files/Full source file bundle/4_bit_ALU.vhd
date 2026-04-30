----------------------------------------------------------------------------------
-- Company:  SAIK
-- Engineer: Jayakody K.I.A
-- 
-- Create Date: 04/29/2026 02:20:34 PM
-- Design Name: 
-- Module Name: 4_bit_ALU - Behavioral
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
use WORK.BUSDEF.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( A : in Data_bus;
           B : in Data_bus;
           Add_Sub_Sel : in STD_LOGIC;
           S : out Data_bus;
           Zero : out STD_LOGIC;
           Overflow : out STD_LOGIC);
end ALU;

architecture Behavioral of ALU is

    component RCA_4
        Port ( A     : in Data_bus;
               B     : in Data_bus;
               C_in  : in STD_LOGIC;
               S     : out Data_bus;
               C_out : out STD_LOGIC);
    end component;

    signal B_XOR    : Data_bus;
    signal Sum_out  : Data_bus;
    signal C_out    : STD_LOGIC;

begin
    
    B_XOR(0) <= B(0) XOR Add_Sub_Sel;
    B_XOR(1) <= B(1) XOR Add_Sub_Sel;
    B_XOR(2) <= B(2) XOR Add_Sub_Sel;
    B_XOR(3) <= B(3) XOR Add_Sub_Sel; 
    --forsubstractor

    Ripple_Adder: RCA_4
        port map(
            A     => A,
            B     => B_XOR,        
            C_in  => Add_Sub_Sel,     
            S     => Sum_out,        
            C_out => C_out
        );
        
        S <= Sum_out;
        
        Zero <= NOT (Sum_out(0) OR Sum_out(1) OR Sum_out(2) OR Sum_out(3));
        
        Overflow <= (A(3) XNOR B_XOR(3)) AND (A(3) XOR Sum_out(3));
       

end Behavioral;
