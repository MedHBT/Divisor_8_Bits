----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:49:31 12/12/2013 
-- Design Name: 
-- Module Name:    Sequentiel_Diviseur - Arch_Sequentiel_Diviseur 
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

entity Sequentiel_Diviseur is
port(
	INIT_A,CLK_A, LOAD_A, SHIFT_A, LR_A, S_IN_A : in std_logic;
	INIT_B,CLK_B, LOAD_B, SHIFT_B, LR_B, S_IN_B ,SET_B, ENTRY_B: in std_logic;
	INIT_C,CLK_C, LOAD_C, SHIFT_C, LR_C, S_IN_C : in std_logic;
	OP: in std_logic;
	INIT_CPT,CLK_CPT,INCR_CPT : in std_logic ;
	E_A,E_B,E_C,UAL_A,UAL_B: in std_logic_vector(7 downto 0);
	S_A,S_B,S_C,UAL_R: out std_logic_vector(7 downto 0);
	I_CPT : out std_logic_vector(2 downto  0);
	S_OUT_A,S_OUT_B,S_OUT_C: out std_logic
);
end Sequentiel_Diviseur;

architecture Arch_Sequentiel_Diviseur of Sequentiel_Diviseur is
	
	component Reg_8bits_Complet
		port(
			init,load,shift,lr,s_in ,clk, set_bit_0,entry_bit_0: in std_logic;
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
	
	component UAL
		port (
		op : in std_logic;
		A,B : in std_logic_vector(7 downto 0);
		R : out std_logic_vector(7 downto 0)
		);
	end component;
	
begin

	A : Reg_8bits_complet port map (init=>INIT_A,load=>LOAD_A,shift=>SHIFT_A,lr=>LR_A,s_in=>S_IN_A ,clk=>CLK_A,set_bit_0=>'0',entry_bit_0=>'0',
												E(7 downto 0) => E_A(7 downto 0),
												S(7 downto 0) => S_A(7 downto 0),
												s_out=>S_OUT_A);
												
	B : Reg_8bits_complet port map (init=>INIT_B,load=>LOAD_B,shift=>SHIFT_B,lr=>LR_B,s_in=>S_IN_B ,clk=>CLK_B,set_bit_0=>SET_B,entry_bit_0=> ENTRY_B,
												E(7 downto 0) => E_B(7 downto 0),
												S(7 downto 0) => S_B(7 downto 0),
												s_out=>S_OUT_B);
												
	C : Reg_8bits_complet port map (init=>INIT_C,load=>LOAD_C,shift=>SHIFT_C,lr=>LR_C,s_in=>S_IN_C ,clk=>CLK_C,set_bit_0=>'0',entry_bit_0=>'0',
												E(7 downto 0) => E_C(7 downto 0),
												S(7 downto 0) => S_C(7 downto 0),
												s_out=>S_OUT_C);
							
	Cpt : Cpt_3bits port map (clk => CLK_CPT,incr => INCR_CPT,init => INIT_CPT,I(2 downto 0) => I_CPT(2 downto 0));
												
	UAL_Diviseur : UAL port map (op => OP,A(7 downto 0) => UAL_A (7 downto 0) ,B (7 downto 0) => UAL_B (7 downto 0),R (7 downto 0) => UAL_R(7 downto 0));
	
end Arch_Sequentiel_Diviseur;

