----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/30/2026 06:37:13 AM
-- Design Name: 
-- Module Name: RegBank - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegBank is
    Port ( D : in STD_LOGIC_VECTOR (3 downto 0);
           WriteAddr : in STD_LOGIC_VECTOR (2 downto 0);
           WriteEn : in STD_LOGIC;
           ReadAddr : in STD_LOGIC_VECTOR (2 downto 0);
           Res : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0));
end RegBank;

architecture Behavioral of RegBank is

component Reg_4Bit
    Port ( D   : in  STD_LOGIC_VECTOR (3 downto 0);
           En  : in  STD_LOGIC;
           Res : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Q   : out STD_LOGIC_VECTOR (3 downto 0));
end component; 

component Decoder_3_to_8 
    Port ( I : in STD_LOGIC_VECTOR (2 downto 0);
           EN : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (7 downto 0));
end component;


signal Q0, Q1, Q2, Q3, Q4, Q5, Q6, Q7 : std_logic_vector(3 downto 0) := "0000";   
signal en_lines: std_logic_vector(7 downto 0);


begin

    Decoder_3_to_8_0 : Decoder_3_to_8
    port map(
        I => WriteAddr,
        EN => WriteEn,
        Y => en_lines);
        
    
    Reg0 : Reg_4Bit
    port map(
        D => D,
        En => en_lines(0),
        Res => Res,
        Clk => Clk,
        Q => Q0);
        
    Reg1 : Reg_4Bit
    port map(
        D => D,
        En => en_lines(1),
        Res => Res,
        Clk => Clk,
        Q => Q1);

    Reg2 : Reg_4Bit
    port map(
        D => D,
        En => en_lines(2),
        Res => Res,
        Clk => Clk,
        Q => Q2);
        
    Reg3 : Reg_4Bit
    port map(
        D => D,
        En => en_lines(3),
        Res => Res,
        Clk => Clk,
        Q => Q3);
            
    Reg4 : Reg_4Bit
    port map(
        D => D,
        En => en_lines(4),
        Res => Res,
        Clk => Clk,
        Q => Q4);

    Reg5 : Reg_4Bit
    port map(
        D => D,
        En => en_lines(5),
        Res => Res,
        Clk => Clk,
        Q => Q5);  

    Reg6 : Reg_4Bit
    port map(
        D => D,
        En => en_lines(6),
        Res => Res,
        Clk => Clk,
        Q => Q6);

    Reg7 : Reg_4Bit
    port map(
        D => D,
        En => en_lines(7),
        Res => Res,
        Clk => Clk,
        Q => Q7);  


with ReadAddr select
    Q <= "0000" when "000",
         Q1 when "001",
         Q2 when "010",
         Q3 when "011",
         Q4 when "100",
         Q5 when "101",
         Q6 when "110",
         Q7 when others;


end Behavioral;
