library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use work.numeric_std.all;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity counter is
    Port ( clock : in std_logic;
           count : inout std_logic_vector(23 downto 0);
           reset : in std_logic;
		 LEDcount : inout std_logic_vector(7 downto 0);
		 LEDout :	out std_logic_vector(7 downto 0));
		 
end counter;

architecture Behavioral of counter is

begin

process (CLOCK, RESET, COUNT, LEDcount)
begin
	LEDcount = "00000001";
	if RESET='1' then
		COUNT <= "000000000000000000000000";
		LEDout <= "00000000";	-- assumes active high LEDs
	elsif CLOCK='1' and CLOCK'event then
		COUNT <= COUNT + 1;
	end if;

	if COUNT = "111111111111111111111111" and  and CLOCK'event then
		LEDcount <= LEDcount + 1;
		LEDout <= LEDout sll 1;

	end if;


end process;

end Behavioral;
