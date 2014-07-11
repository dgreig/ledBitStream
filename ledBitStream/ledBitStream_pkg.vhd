--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package ledBitStream_pkg is

-- type <new_type> is
--  record
--    <type_name>        : std_logic_vector( 7 downto 0);
--    <type_name>        : std_logic;
-- end record;
--
-- Declare constants
--
-- constant <constant_name>		: time := <time_unit> ns;
-- constant <constant_name>		: integer := <value;
--

-- 23,47,95,191,383,767
--constant dataBitSize: integer := 4079; -- # of bits received from pc (512bytes/510)
constant dataBitSize: integer := 23; -- # of bits received from pc (512bytes/510)
-- allWhtNoEnds constant allOnes: std_logic_vector (dataBitSize downto 0) := x"000000202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020000000";
-- 767 blue constant allOnes: std_logic_vector (dataBitSize downto 0) := x"200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000200000";
-- 767 red constant allOnes: std_logic_vector (dataBitSize downto 0) := x"002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000002000";
-- 767 grn constant allOnes: std_logic_vector (dataBitSize downto 0) := x"000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020000020";
-- 767 grnRed constant allOnes: std_logic_vector (dataBitSize downto 0) := x"002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020002020";
-- 767 bluRed constant allOnes: std_logic_vector (dataBitSize downto 0) := x"202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000202000";
-- 767 bluGrn constant allOnes: std_logic_vector (dataBitSize downto 0) := x"200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020";
constant allOnes: std_logic_vector (dataBitSize downto 0) := x"200000";
-- bluGrnWith4Wht constant allOnes: std_logic_vector (dataBitSize downto 0) := x"200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020200020202020202020202020202020";
-- 383 constant allOnes: std_logic_vector (dataBitSize downto 0) := x"202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020";
-- 191 constant allOnes: std_logic_vector (dataBitSize downto 0) := x"202020202020202020202020202020202020202020202020";
constant bitsToDup: std_logic_vector(4 downto 0) := "11000";	-- 24 bits = 1 pixel
constant pixDupFactor: std_logic_vector (1 downto 0) := "00";		-- temp - number of times to duplicate pixels

-- Declare functions and procedure
--
-- function <function_name>  (signal <signal_name> : in <type_declaration>) return <type_declaration>;
-- procedure <procedure_name> (<type_declaration> <constant_name>	: in <type_declaration>);
--

end ledBitStream_pkg;

package body ledBitStream_pkg is

---- Example 1
--  function <function_name>  (signal <signal_name> : in <type_declaration>  ) return <type_declaration> is
--    variable <variable_name>     : <type_declaration>;
--  begin
--    <variable_name> := <signal_name> xor <signal_name>;
--    return <variable_name>; 
--  end <function_name>;

---- Example 2
--  function <function_name>  (signal <signal_name> : in <type_declaration>;
--                         signal <signal_name>   : in <type_declaration>  ) return <type_declaration> is
--  begin
--    if (<signal_name> = '1') then
--      return <signal_name>;
--    else
--      return 'Z';
--    end if;
--  end <function_name>;

---- Procedure Example
--  procedure <procedure_name>  (<type_declaration> <constant_name>  : in <type_declaration>) is
--    
--  begin
--    
--  end <procedure_name>;
 
end ledBitStream_pkg;
