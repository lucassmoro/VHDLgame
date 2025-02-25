LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY registrador_secreto IS
	PORT (
		SW : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		R1, E2, clock : IN STD_LOGIC;
		Alpha, Beta : OUT STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000"
	);
END registrador_secreto;

ARCHITECTURE registrador_secreto OF registrador_secreto IS
	COMPONENT registrador_8 IS
		PORT (
			proxEntrada : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			reset, clock, enabled : IN STD_LOGIC;
			saida : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;
BEGIN
	salvar : registrador_8 PORT MAP(
		proxEntrada => SW,
		reset => R1,
		enabled => E2,
		clock => clock,
		saida(7 DOWNTO 4) => Alpha,
		saida(3 DOWNTO 0) => Beta
	);
END registrador_secreto;