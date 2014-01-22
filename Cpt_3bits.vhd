----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:21:09 12/05/2013 
-- Design Name: 
-- Module Name:    Cpt_3bits - Arch_Cpt_3bits 
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

entity Cpt_3bits is
port(
clk,incr,init: in std_logic;
I : out std_logic_vector(2 downto 0)
);
end Cpt_3bits;

architecture Arch_Cpt_3bits of Cpt_3bits is

Signal temp :std_logic_vector(2 downto 0);
Signal tempT1 : std_logic;
Signal tempT2 : std_logic; 

component BistableT
port(preset,clear,clk,T: in std_logic;Q:out std_logic);
end component;

begin
	I(2 downto 0) <= temp (2 downto 0);
	tempT1 <= (incr and temp (0)) ;
	tempT2 <= (incr and temp(0) and temp(1));
	T0 :bistableT port map (preset => '0' , clear => init , clk => clk , T => incr , Q => temp(0));
	T1 :bistableT port map (preset => '0' , clear => init , clk => clk , T => tempT1 , Q => temp(1));
	T2 :bistableT port map (preset => '0' , clear => init , clk => clk , T => tempT2 ,Q => temp(2));
end Arch_Cpt_3bits;

