----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:24:41 12/08/2013 
-- Design Name: 
-- Module Name:    Reg_8bits_complet - Arch_Reg_8bits_complet 
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

entity Reg_8bits_complet is
port(
init,load,shift,lr,s_in ,clk,set_bit_0,entry_bit_0: in std_logic;
E : in std_logic_vector (7 downto 0);
S : out std_logic_vector (7 downto 0);
s_out : out std_logic
);
end Reg_8bits_complet;

architecture Arch_Reg_8bits_complet of Reg_8bits_complet is

component Comb_Reg_8bits
port(
load,shift,lr,s_in : in std_logic;
E : in std_logic_vector (7 downto 0);
E_temp : in std_logic_vector (7 downto 0);
s_out_temp : in std_logic;
S : out std_logic_vector (7 downto 0);
s_out : out std_logic
);
end component;

component Reg_8bits
port(
clk,init,s_in,set_bit_0,entry_bit_0 : in std_logic;
Q_in : in std_logic_vector(7 downto 0);
Q_out : out std_logic_vector(7 downto 0);
s_out : out std_logic 
);
end component ;

Signal temp_q : std_logic_vector(7 downto 0) ;
Signal temp_s_comb : std_logic_vector(7 downto 0) ;
Signal temp_sout_comb: std_logic ;
Signal temp_sout_Reg: std_logic ;

begin

S( 7 downto 0) <=  temp_q(7 downto 0);
s_out <= temp_sout_Reg;

Comb : Comb_Reg_8bits port map (load => load,shift => shift,lr => lr,s_in => s_in,E (7 downto 0) => E (7 downto 0),E_temp(7 downto 0) => temp_q(7 downto 0),s_out_temp =>temp_sout_Reg ,S(7 downto 0) => temp_s_comb(7 downto 0),s_out => temp_sout_comb );
Reg8 : Reg_8bits port map (clk => clk , init => init ,s_in => temp_sout_comb, set_bit_0 => set_bit_0 , entry_bit_0 => entry_bit_0 ,Q_in(7 downto 0) => temp_s_comb(7 downto 0),Q_out (7 downto 0) => temp_q(7 downto 0),s_out => temp_sout_Reg);

end Arch_Reg_8bits_complet;

