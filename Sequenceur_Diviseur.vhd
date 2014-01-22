----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:33:38 12/12/2013 
-- Design Name: 
-- Module Name:    Sequenceur_Diviseur - Arch_Diviseur 
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

entity Sequenceur_Diviseur is
	port (
		START, CLK, E, A7, I7 : in std_logic;
		INIT, LOAD, SHIFT, INCR, AS, B0, F, LOAD_ACCU: out std_logic
	);
end Sequenceur_Diviseur;

architecture Arch_Diviseur of Sequenceur_Diviseur is

	component BistableT 
		port(
			preset,clear,clk,T: in std_logic;
			Q:out std_logic 
		);
	end component;

	signal Q, T : std_logic_vector(10 downto 0);
begin
	
	T0 : BistableT port map(preset => START, clear => '0', clk => CLK, T => T(0), Q => Q(0));
	boucle:
		for i in 1 to 10 generate
			Ti : BistableT port map(preset => '0', clear => START, clk => CLK, T => T(i), Q => Q(i));
		end generate;
	T(0) <= (E and Q(0)) or Q(9) or Q(10);
	T(1) <= (E and Q(0)) or Q(1);
	T(2) <= Q(1) or Q(2);
	T(3) <= Q(3) or Q(2);
	T(4) <= (Q(3) and A7) or (Q(4)) or (not I7 and A7 and ( Q(5) or Q(8) ));
	T(5) <= Q(4) or Q(5);
	T(6) <= (Q(3) and not A7) or (Q(6)) or (not I7 and not A7 and ( Q(5) or Q(8) ));
	T(7) <= Q(6) or Q(7);
	T(8) <= Q(7) or Q(8);
	T(9) <= (I7 and A7 and (Q(5) or Q(8))) or Q(9);
	T(10) <= (I7 and not A7 and (Q(5) or Q(8))) or Q(10);
	INIT <= Q(1);
	LOAD <= Q(1);
	SHIFT <= Q(2) or Q(4) or Q(7);
	INCR <= Q(4) or Q(7);
	AS <= Q(8) or Q(3);
	LOAD_ACCU <= Q(3) or Q(5) or Q(8) or Q(9);
	B0 <= Q(6) or Q(10);
	F <= Q(0);

end Arch_Diviseur;

