----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:50:09 12/06/2013 
-- Design Name: 
-- Module Name:    Comb_Reg_8bits - Arch_Comb_Reg_8bits 
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

entity Comb_Reg_8bits is
port(
	load,shift,lr,s_in: in std_logic;
	E : in std_logic_vector (7 downto 0);
	E_temp : in std_logic_vector (7 downto 0);
	s_out_temp : in std_logic;
	S : out std_logic_vector (7 downto 0);
	s_out : out std_logic
);
end Comb_Reg_8bits;

architecture Arch_Comb_Reg_8bits of Comb_Reg_8bits is

Signal temp_s : std_logic_vector (7 downto 0);
Signal temp : std_logic;

begin
	S ( 7 downto 0)<= temp_s (7 downto 0);
	s_out <= temp ;
	temp_s(0) <= (load and E(0)) or (not load and ((shift and ((lr and s_in)or(not lr and E_temp(1))))or(not shift and E_temp(0))));
	bcl : for i in 6 downto 1 generate
		temp_s(i) <= (load and E(i)) or (not load and ((shift and ((lr and E_temp(i-1))or(not lr and E_temp(i+1))))or(not shift and E_temp(i))));
	end generate;
	temp_s(7) <= (load and E(7)) or (not load and ((shift and ((lr and E_temp(6))or(not lr and s_in)))or(not shift and E_temp(7))));
	temp <= (load and s_in) or (not load and ((shift and ((lr and E_temp(7))or(not lr and E_temp(0))))or(not shift and s_out_temp)));
end Arch_Comb_Reg_8bits;

