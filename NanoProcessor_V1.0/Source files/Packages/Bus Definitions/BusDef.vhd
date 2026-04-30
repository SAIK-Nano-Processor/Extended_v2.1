----------------------------------------------------------------------------------
-- Company: SAIK
-- Engineer: ISIWARA M.A.G.A
-- 
-- Create Date: 30.04.2026 12:57:01
-- Design Name: 
-- Module Name: BusDef - Behavioral
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

package BusDef is

    -- All bus types
    subtype Bus_3_bit is std_logic_vector(2 downto 0);      -- 3 bit bus
    subtype Bus_4_bit is std_logic_vector(3 downto 0);      -- 4 bit bus
    subtype Bus_8_bit is std_logic_vector(7 downto 0);      -- 8 bit bus
    subtype Bus_12_bit is std_logic_vector(11 downto 0);    -- 12 bit bus

    -- Array of buses
    type Bus_8x4 is array (7 downto 0) of Bus_4_bit;        -- 8 buses of 4 bits each
    
    -- Extended Custom Buses
    subtype Address_bus is Bus_3_bit;                       -- Bus for memory address
    subtype Memory_selector is Bus_8_bit;                   -- Bus for memory selection in register
    subtype Data_bus is Bus_4_bit;                          -- Bus for 4 bit data transfer
    subtype Data_bus_8x4 is Bus_8x4;                        -- Bus for data output from register bank
    subtype Instruction_bus is Bus_12_bit;                  -- Instruction bus
    
end package BusDef;
