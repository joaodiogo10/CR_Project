----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/04/2022 08:25:41 PM
-- Design Name: 
-- Module Name: PopCounter - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

entity PopCounter is
  port(clk  : in  std_logic;
       cntOut  : out std_logic_vector(31 downto 0));
end PopCounter;

architecture Behavioral of PopCounter is
    signal s_state : std_logic_vector(31 downto 0) := x"F000F000";
begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            s_state <= s_state(0) & s_state(31 downto 1);
        end if;
    end process;
    
    cntOut <= s_state;
end Behavioral;
