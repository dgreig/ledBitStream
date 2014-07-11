library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.ledBitStream_pkg.all;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ledBitStream is
    Port (	clk : in bit;
				pixDupFactor : in std_logic_vector(1 downto 0);
--				pixDimFactor : in std_logic_vector(7 downto 0); -- apply this as the bytes are received and stored in aReg/bReg
				hbOut : out std_logic := '0';
				dataOut : out std_logic := '0');
end ledBitStream;

architecture Behavioral of ledBitStream is

-- 23,47,95,191,383,767
--constant dataBitSize: integer := 4079; -- # of bits received from pc (512bytes/510)
constant dataBitSize: integer := 47; -- # of bits received from pc (512bytes/510)
-- allWhtNoEnds constant allOnes: std_logic_vector (dataBitSize downto 0) := x"000000202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020000000";
-- 767 blue constant allOnes: std_logic_vector (dataBitSize downto 0) := x"200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000";
-- 767 red constant allOnes: std_logic_vector (dataBitSize downto 0) := x"002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000";
-- 767 grn constant allOnes: std_logic_vector (dataBitSize downto 0) := x"000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020";
-- 767 grnRed constant allOnes: std_logic_vector (dataBitSize downto 0) := x"002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020";
-- 767 bluRed constant allOnes: std_logic_vector (dataBitSize downto 0) := x"202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000";
-- 767 bluGrn constant allOnes: std_logic_vector (dataBitSize downto 0) := x"200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020";
constant allOnes: std_logic_vector (dataBitSize downto 0) := x"200000300000";
-- bluGrnWith4Wht constant allOnes: std_logic_vector (dataBitSize downto 0) := x"200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020202020202020202020202020";
-- 383 constant allOnes: std_logic_vector (dataBitSize downto 0) := x"202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020";
-- 191 constant allOnes: std_logic_vector (dataBitSize downto 0) := x"202020202020202020202020202020202020202020202020";
constant bitsToDup: std_logic_vector(4 downto 0) := "10111";		-- 24 bits = 1 pixel
--constant pixDupFactor: std_logic_vector (1 downto 0) := "00";		-- temp - number of times to duplicate pixels

signal counter : std_logic_vector(11 downto 0) := "000000000000";	-- counter for op pulse time and reset (latch)
signal aReg : std_logic_vector(dataBitSize downto 0) := allOnes; 	-- debug data to output all ones
signal timer1 : std_logic_vector(25 downto 0);							-- hb timer
signal bitCount : integer := 0;												-- tracks current data bit

signal pixDupCount : std_logic_vector(1 downto 0) := "00";			-- counts pixel duplication loops
signal pixBitCount : std_logic_vector(4 downto 0) := "00000";		-- monitors for 24bits (1 pixel)

begin

process(clk)
begin
	if clk = '1' and clk'event then
		hbOut <= timer1(25);
		timer1 <= timer1 + 1;
------------------  latch signal  ----------------------------------
		if bitCount > dataBitSize then			-- send reset code at end(60uSec low)
			if counter <= "101110111000" then
				dataOut <= '0';
				counter <= counter + 1;
			else
				counter <= "000000000000";
				bitCount <= 0;
				pixDupCount <= "00";
				pixBitCount <= "00000";
			end if;
------------------  bit is a 0  -----------------------------------				
		elsif aReg(bitCount) = '0' then
			if counter <= "000000010011" then		-- high for 400nS
				dataOut <= '1';
				counter <= counter + 1;
			elsif counter <= "000000111100" then	-- low for rest of 1.25uS(850nS)
				dataOut <= '0';
				counter <= counter + 1;
			else
				counter <= "000000000000";				-- reset 1.25uS counter
				if pixBitCount = bitsToDup then		-- pixel duplication loop
					pixBitCount <= "00000";				-- at 24 bits (23) reset pixel bit count
					if pixDupCount = pixDupFactor then
						pixDupCount <= "00";
						bitCount <= bitCount + 1;
					else
						pixDupCount <= pixDupCount + '1';
						bitCount <= bitCount - 23;
					end if;
				else
					pixBitCount <= pixBitCount + '1';-- increment pixel bit count
					bitCount <= bitCount + 1;			-- increment bit count
				end if;
			end if;
------------------  bit is a 1  -----------------------------------		
		elsif aReg(bitCount) = '1' then
			if counter <= "000000100111" then		-- high for 800nS
				dataOut <= '1';
				counter <= counter + 1;
			elsif counter <= "000000111100" then	-- low for rest of 1.25uS(450nS)
				dataOut <= '0';
				counter <= counter + 1;
			else
				counter <= "000000000000";				-- reset counter
				if pixBitCount = bitsToDup then		-- pixel duplication loop
					pixBitCount <= "00000";				-- at 24 bits (23) reset pixel bit count
					if pixDupCount = pixDupFactor then
						pixDupCount <= "00";
						bitCount <= bitCount + 1;
					else
						pixDupCount <= pixDupCount + '1';
						bitCount <= bitCount - 23;
					end if;
				else
					pixBitCount <= pixBitCount + '1';-- increment pixel bit count
					bitCount <= bitCount + 1;			-- increment bit count
				end if;
			end if;
		end if;
	end if;
end process;
end Behavioral;
