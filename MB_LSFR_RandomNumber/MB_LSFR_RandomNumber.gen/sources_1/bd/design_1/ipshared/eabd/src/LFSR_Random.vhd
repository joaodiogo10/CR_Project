----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/07/2022 06:08:46 PM
-- Design Name: 
-- Module Name: LFSR_Random - Behavioral
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

entity LFSR_Random is
Port ( clk      : in std_logic;
       --gen      : in std_logic;
       --load     : in std_logic;
       --seed     : in std_logic_vector(31 downto 0);
       --valid    : out std_logic;
       number   : out std_logic_vector(31 downto 0));
end LFSR_Random;

architecture Behavioral of LFSR_Random is

--   bit = ((lfsr >> 0) ^ (lfsr >> 2) ^ (lfsr >> 3) ^ (lfsr >> 5)) & 1u;
--     lfsr = (lfsr >> 1) | (bit << 15);
--taps 32 31 30 10
    --signal s_count : natural := 0;
    signal s_state : std_logic_vector(31 downto 0) := X"FA111111";

begin
    
    process(clk)
    begin
        if(rising_edge(clk)) then
            s_state <= (s_state(31) xor s_state(30) xor s_state(29) xor s_state(9)) & s_state(31 downto 1);
            -- load new seed
            --if(load  = '1') then
                --s_state <= seed;        
                --s_count <= 0;
              
            -- generating random number
            --elsif(s_count /= 32) then
                --s_state <= (s_state(31) xor s_state(30) xor s_state(29) xor s_state(9)) & s_state(31 downto 1);
               -- s_count <= s_count + 1;

            -- start new random number
            --elsif(gen = '1') then
                --s_state <= (s_state(31) xor s_state(30) xor s_state(29) xor s_state(9)) & s_state(31 downto 1);
                --s_count <= 1;
            --end if;
        end if;
    end process;
    
    --valid <= '1' when s_count = 32 else '0';
    number <= s_state;
end Behavioral;
