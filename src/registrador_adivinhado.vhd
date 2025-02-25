LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY registrador_adivinhado IS
	PORT (
		SW_BCD : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		Seq_BCD : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		R1, E4, clock : IN STD_LOGIC;
		Play : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000"
	);
END registrador_adivinhado;

ARCHITECTURE registrador_adivinhado OF registrador_adivinhado IS
	SIGNAL prox_entrada : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";

	COMPONENT registrador_16 IS
		PORT (
			proxEntrada : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			reset, clock, enabled : IN STD_LOGIC;
			saida : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
BEGIN
	prox_entrada <= SW_BCD&Seq_BCD;
	salvar : registrador_16 PORT MAP(
		proxEntrada => prox_entrada,
		reset => R1,
		enabled => E4,
		clock => clock,
		saida => Play
	);
END registrador_adivinhado;