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
         gen  : in std_logic;
         load : in std_logic;
         seed : in std_logic_vector(31 downto 0);
         valid : out std_logic;
         number  : out std_logic_vector(31 downto 0)); 
    end component;
    

    signal s_load : std_logic;                                               -- '1' when a new seed should be loaded
    signal s_seed  : std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);      -- LSFR seed to be loaded
    signal s_gen : std_logic;                                                -- '1' when new random value should be generated
    signal s_number  : std_logic_vector(C_S_AXIS_TDATA_WIDTH-1 downto 0);    -- Generated number
    signal s_valid : std_logic;                                              -- '1' when the LFSR as a new random number ready
    signal s_validOut : std_logic;                                           -- '1' when the generated number is ready to be consumed
    
begin
    randomGen : LFSR_Random 
    port map(clk => S_AXIS_ACLK,
             gen => s_gen,
             load => s_load, 
             seed => s_seed,
             valid => s_valid,
             number => s_number);
             
    process(S_AXIS_ACLK, s_valid)
    begin
        s_load <= '0'; 
        s_gen <= '0';
        s_validOut <= s_valid;
        
        if (rising_edge (S_AXIS_ACLK)) then
	        if (S_AXIS_ARESETN = '0') then         -- Reset
	           s_validOut <= '0';
	           
            elsif (S_AXIS_TVALID = '1') then       -- Load new seed
                s_seed <= S_AXIS_TDATA;
                s_load <= '1';
	        
	        elsif (readEnabled = '1') then         -- Generate new value
	           s_gen <= '1';               
            end if;
        end if;
    end process;

	dataValid     <= s_validOut;
	dataOut       <= s_number;
	S_AXIS_TREADY <= '1';	
end arch_imp;