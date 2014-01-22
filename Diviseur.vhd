----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:28:29 12/12/2013 
-- Design Name: 
-- Module Name:    Diviseur - Arch_Diviseur 
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

entity Diviseur is
	port (
		CLK, DIV, INIT : in std_logic;
		X, Y : in std_logic_vector(7 downto 0);
		F : out std_logic;
		Q, R : out std_logic_vector(7 downto 0)
	);
end Diviseur;

architecture Arch_Diviseur of Diviseur is

	component BistableD
		port(
		preset,clear,D,clk:in std_logic;
		Q :out std_logic
		);
	end component;

	component UAL
		port (
			op : in std_logic;
			A,B : in std_logic_vector(7 downto 0);
			R : out std_logic_vector(7 downto 0)
		);
	end component;
	
	component Reg_8bits_complet
	port(
		init,load,shift,lr,s_in ,clk,set_bit_0,entry_bit_0: in std_logic;
		E : in std_logic_vector (7 downto 0);
		S : out std_logic_vector (7 downto 0);
		s_out : out std_logic
	);
	end component;
	
	component Cpt_3bits 
	port(
		clk,incr,init: in std_logic;
		I : out std_logic_vector(2 downto 0)
	);
	end component;

	component Sequenceur_Diviseur
		port (
			START, CLK, E, A7, I7 : in std_logic;
			INIT, LOAD, SHIFT, INCR, AS, B0, F, LOAD_ACCU: out std_logic
		);
	end component;

	signal OUT_SEQ : std_logic_vector(6 downto 0);
	signal APlus, CPlus, AUPlus : std_logic_vector(7 downto 0);
	signal I : std_logic_vector(2 downto 0);
	signal Bout : std_logic;
	signal temp_I :std_logic;
	
begin
   temp_I <= I(0) and I(1) and I(2);
	
	S : Sequenceur_Diviseur port map(START => INIT, CLK => CLK, E => DIV, A7 =>AUPLUS(7), I7 => temp_I, 
					INIT =>OUT_SEQ(0), LOAD =>OUT_SEQ(1), SHIFT => OUT_SEQ(2),
					INCR => OUT_SEQ(3), AS => OUT_SEQ(4), B0 =>OUT_SEQ(5), F => F, LOAD_ACCU => OUT_SEQ(6));
									
	AU : UAL port map(Op => OUT_SEQ(4), A => APlus, B => CPlus, R => AUPlus);
	
	CPT : Cpt_3bits port map(clk => CLK,incr => OUT_SEQ(3), INIT => OUT_SEQ(0), I => I);
	
	C : Reg_8bits_complet port map(INIT => '0', LOAD => OUT_SEQ(1), SHIFT => '0', LR => '1', S_in => '0', CLK => CLK, set_bit_0 => '0',entry_bit_0 => '0',
											 E => Y,
											 S => CPlus);
											 
	A : Reg_8bits_complet port map(INIT => OUT_SEQ(0), LOAD => OUT_SEQ(6), SHIFT => OUT_SEQ(2), LR => '1', S_in => Bout, CLK => CLK, set_bit_0 => '0',entry_bit_0 => '0',
											 E => AUPlus,
											 S => APlus);
	
	B : Reg_8bits_complet port map(INIT => '0', LOAD => OUT_SEQ(1), SHIFT => OUT_SEQ(2), LR => '1', S_in => '0', CLK => CLK, 
											 set_bit_0 => OUT_SEQ(5),entry_bit_0 => '1',
											 E => X,
											 S => Q, S_out => Bout);
	R <= APlus;
	
end Arch_Diviseur;

