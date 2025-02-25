LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY registrador_8 IS
	PORT (
		proxEntrada : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		RESET, CLOCK, ENABLED : IN STD_LOGIC;

		saida : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000"
	);
END registrador_8;

ARCHITECTURE registrador_8 OF registrador_8 IS
BEGIN
	PROCESS (CLOCK, RESET)
	BEGIN
		IF (RESET = '1') THEN
			saida <= "00000000";
		ELSIF (CLOCK'event AND CLOCK = '1') THEN
			IF (ENABLED = '1') THEN
				saida <= proxEntrada;
			END IF;
		END IF;
	END PROCESS;
END registrador_8;