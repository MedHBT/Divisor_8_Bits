----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:21:03 12/11/2013 
-- Design Name: 
-- Module Name:    UAL - Arch_UAL 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_signed.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UAL is
	port (
		op : in std_logic;
		A,B : in std_logic_vector(7 downto 0);
		R : out std_logic_vector(7 downto 0)
	);
end UAL;

architecture Arch_UAL of UAL is
	signal temp : signed(7 downto 0);
begin

	R<=std_logic_vector(temp);
	temp <=signed(A)+signed(B) when op='0'
	else signed(A)-signed(B);
	
end Arch_UAL;

