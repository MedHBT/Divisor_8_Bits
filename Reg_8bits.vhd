----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:26:23 12/06/2013 
-- Design Name: 
-- Module Name:    Reg_8bits - Arch_reg_8bits 
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

entity Reg_8bits is
port(
clk,init,s_in ,set_bit_0,entry_bit_0 : in std_logic;
Q_in : in std_logic_vector(7 downto 0);
Q_out : out std_logic_vector(7 downto 0);
s_out : out std_logic 
);
end Reg_8bits;

architecture Arch_reg_8bits of Reg_8bits is

Signal temp_q : std_logic_vector (7 downto 0);
signal preset_d0,clear_d0 : std_logic;

component BistableD
port(preset,clear,D,clk:in std_logic;Q :out std_logic);
end component;

begin

Q_out (7 downto 0) <= temp_q(7 downto 0);
preset_d0 <= set_bit_0 and entry_bit_0;
clear_d0 <= (set_bit_0 and (not entry_bit_0)) or init;
D0 : BistableD port map (preset => preset_d0,clear => clear_d0,D => Q_in(0),clk => clk ,Q => temp_q(0));

bcl :for i in 1 to 7 generate 
	Di : BistableD port map (preset => '0',clear => init,D => Q_in(i),clk => clk ,Q => temp_q(i));
end generate ;

s_out <= s_in;

end Arch_reg_8bits;

