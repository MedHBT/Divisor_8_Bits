----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:45:22 12/05/2013 
-- Design Name: 
-- Module Name:    BistableD - Arch_BistableD 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BistableD is
port(
preset,clear,D,clk:in std_logic;
Q :out std_logic
);
end BistableD;

architecture Arch_BistableD of BistableD is
	signal temp :std_logic;
begin
	Q <= temp;
	process(preset,clear,clk)
		begin
		if preset = '1' then
			temp <= '1';
		elsif clear = '1' then
			temp <= '0';
			elsif clk 'event and clk = '1' then
				temp <= D ;
			end if ;
	end process;	
end Arch_BistableD;

