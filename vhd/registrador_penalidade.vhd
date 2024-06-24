LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY registrador_penalidade IS
	PORT (
		SW : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		R1, E1, clock : IN STD_LOGIC;
		nivel_penalidade : OUT STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
		penalty : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000"
	);
END registrador_penalidade;

ARCHITECTURE registrador_penalidade OF registrador_penalidade IS
	SIGNAL id_penalidade : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";

	COMPONENT registrador_2 IS
		PORT (
			proxEntrada : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			reset, clock, enabled : IN STD_LOGIC;
			saida : OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT multiplexador_4_8 IS
		PORT (
			A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			C : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			D : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			selector : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			S : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;
BEGIN
	salvar : registrador_2 PORT MAP(
		proxEntrada => SW,
		reset => R1,
		enabled => E1,
		clock => clock,
		saida => id_penalidade
	);

	nivel_penalidade <= id_penalidade;

	mux : multiplexador_4_8 PORT MAP(
		A => "11111110",
		B => "11111100",
		C => "11111010",
		D => "11111000",
		selector => id_penalidade,
		S => penalty
	);
END registrador_penalidade;