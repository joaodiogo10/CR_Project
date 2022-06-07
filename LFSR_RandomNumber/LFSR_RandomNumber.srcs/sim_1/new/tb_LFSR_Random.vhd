----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/07/2022 07:20:28 PM
-- Design Name: 
-- Module Name: tb_LFSR_Random - Behavioral
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

entity tb_LFSR_Random is
--  Port ( );
end tb_LFSR_Random;

architecture Behavioral of tb_LFSR_Random is
    component LFSR_Random
    port(clk      : in std_logic;
         gen      : in std_logic;
         load     : in std_logic;
         seed     : in std_logic_vector(31 downto 0);
         valid    : out std_logic;
         number   : out std_logic_vector(31 downto 0));
    end component;
        
    procedure wait_next_number(signal s_clk : in std_logic) is
    begin
        for i in 0 to 31 loop
            wait until rising_edge(s_clk);
        end loop;
        wait for 2 ns;
    end procedure;
    
    
    signal s_clk : std_logic := '0';
    signal s_gen : std_logic := '0';
    signal s_load : std_logic := '0';
    signal s_seed : std_logic_vector(31 downto 0) := X"00000000";
    signal s_valid : std_logic := '0';
    signal s_number : std_logic_vector(31 downto 0) := X"00000000";
    
begin
    
    uut : LFSR_Random PORT MAP (
        clk => s_clk,
        gen => s_gen,
        load => s_load,
        seed => s_seed,
        valid => s_valid,
        number => s_number);
    
    clock_process : process
    begin
        s_clk <= '0'; wait for 5 ns;
        s_clk <= '1'; wait for 5 ns;
    end process;
    
    stim_process : process
        
    begin
        s_load <= '1';
        s_seed <= X"A2B523F5";
        
        wait for 7 ns;
        s_load <= '0';
        s_gen <= '1';

        wait_next_number(s_clk);
        ASSERT s_valid = '1' REPORT "Failed valid" SEVERITY error;
        ASSERT s_number = X"1a703d29" REPORT "Failed number=1a703d29" SEVERITY error;
        
        wait_next_number(s_clk);
        ASSERT s_valid = '1' REPORT "Failed valid" SEVERITY error;
        ASSERT s_number = X"99abc802" REPORT "Failed number=99abc802" SEVERITY error;
        
        wait_next_number(s_clk);
        ASSERT s_valid = '1' REPORT "Failed valid" SEVERITY error;
        ASSERT s_number = X"d1ebe975" REPORT "Failed number=d1ebe975" SEVERITY error;
        
        wait_next_number(s_clk);
        ASSERT s_valid = '1' REPORT "Failed valid" SEVERITY error;
        ASSERT s_number = X"d4c7ef10" REPORT "Failed number=d4c7ef10";
        

        wait for 200 ns;
        s_load <= '1';
        s_gen <= '1';
        s_seed <= X"10000001";
        
        wait until rising_edge(s_clk);
        s_load <= '0';
        s_gen <= '1';
        
        wait until rising_edge(s_clk);
        s_gen <= '0';
        
        wait for 500 ns;
    end process;
end Behavioral;
