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
use WORK.BUSDEF.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegBank is
    Port ( Clk : in STD_LOGIC;
           Reset : in  STD_LOGIC;
           Data_in : in Data_bus;
           Register_Address : in Address_bus;
           Data_out : out Data_bus_8x4
          );
end RegBank;

architecture Behavioral of RegBank is

component Reg_4Bit
    Port ( D   : in  Data_bus;
           En  : in  STD_LOGIC;
           Res : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Q   : out Data_bus
          );
end component; 

component Decoder_3_to_8 
    Port ( I : in Address_bus;
           EN : in STD_LOGIC;
           Y : out Memory_selector 
          );
end component;
   
signal Decoder_out : Memory_selector;

begin
    Decoder_3_to_8_0 : Decoder_3_to_8
    port map(
        I => Register_Address,
        EN => '1',
        Y => Decoder_out
        );
        
    
    Reg0 : Reg_4Bit
    port map(
        D => "0000",
        En => Decoder_out(0),
        Res => Reset,
        Clk => Clk,
        Q => Data_out(0)
        );
        
    Reg1 : Reg_4Bit
    port map(
        D => Data_in,
        En => Decoder_out(1),
        Res => Reset,
        Clk => Clk,
        Q => Data_out(1)
        );

    Reg2 : Reg_4Bit
    port map(
        D => Data_in,
        En => Decoder_out(2),
        Res => Reset,
        Clk => Clk,
        Q => Data_out(2)
        );
        
    Reg3 : Reg_4Bit
    port map(
        D => Data_in,
        En => Decoder_out(3),
        Res => Reset,
        Clk => Clk,
        Q => Data_out(3)
        );
            
    Reg4 : Reg_4Bit
    port map(
        D => Data_in,
        En => Decoder_out(4),
        Res => Reset,
        Clk => Clk,
        Q => Data_out(4)
        );

    Reg5 : Reg_4Bit
    port map(
        D => Data_in,
        En => Decoder_out(5),
        Res => Reset,
        Clk => Clk,
        Q => Data_out(5)
        );  

    Reg6 : Reg_4Bit
    port map(
        D => Data_in,
        En => Decoder_out(6),
        Res => Reset,
        Clk => Clk,
        Q => Data_out(6)
        );

    Reg7 : Reg_4Bit
    port map(
        D => Data_in,
        En => Decoder_out(7),
        Res => Reset,
        Clk => Clk,
        Q => Data_out(7)
        );  
end Behavioral;
