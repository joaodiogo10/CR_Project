library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LSFR_Random_v1_0_S00_AXIS is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line

		-- AXI4Stream sink: Data Width
		C_S_AXIS_TDATA_WIDTH	: integer	:= 32
	);
	port (
		-- Users to add ports here
        dataValid    : out std_logic;
        dataOut      : out std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
        readEnabled  : in  std_logic;
        
		-- User ports ends
		-- Do not modify the ports beyond this line

		-- AXI4Stream sink: Clock
		S_AXIS_ACLK	: in std_logic;
		-- AXI4Stream sink: Reset
		S_AXIS_ARESETN	: in std_logic;
		-- Ready to accept data in
		S_AXIS_TREADY	: out std_logic;
		-- Data in
		S_AXIS_TDATA	: in std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
		-- Byte qualifier
		S_AXIS_TSTRB	: in std_logic_vector((C_S_AXIS_TDATA_WIDTH/8)-1 downto 0);
		-- Indicates boundary of last packet
		S_AXIS_TLAST	: in std_logic;
		-- Data is in valid
		S_AXIS_TVALID	: in std_logic
	);
end LSFR_Random_v1_0_S00_AXIS;

architecture arch_imp of LSFR_Random_v1_0_S00_AXIS is

    component LFSR_Random
    port(clk  : in  std_logic;
         number  : out std_logic_vector(31 downto 0)); 
    end component;
    
	signal s_ready    : std_logic;
    signal s_validOut : std_logic;
    
    signal s_dataIn  : std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
    signal s_number  : std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);
    
begin
    randomGen : LFSR_Random 
    port map(clk => S_AXIS_ACLK,
             number => s_number);
             
   -- s_ready <= (not s_validOut) or readEnabled;
    
    
--    process(S_AXIS_ACLK)
--	begin
--        if (rising_edge (S_AXIS_ACLK)) then
--	        if (S_AXIS_ARESETN = '0') then
--	           s_validOut <= '0';
       
--            elsif (S_AXIS_TVALID = '1') then
--	           if (s_ready = '1') then
--                    s_validOut <= '1';
--                    s_dataIn <= S_AXIS_TDATA;
--	           end if;
	      
--	        elsif (readEnabled = '1') then
--	           s_validOut <= '0';               
--            end if;
--        end if;
--    end process;

	dataValid     <= '1';
	dataOut       <= s_number;
	S_AXIS_TREADY <= '1';	
end arch_imp;