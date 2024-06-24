LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY registrador_2 IS
	PORT (
		proxEntrada : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		RESET, CLOCK, ENABLED : IN STD_LOGIC;
		saida : OUT STD_LOGIC_VECTOR(1 DOWNTO 0) := "00"
	);
END registrador_2;

ARCHITECTURE registrador_2 OF registrador_2 IS
BEGIN
	PROCESS (CLOCK, RESET)
	BEGIN
		IF (RESET = '1') THEN
			saida <= "00";
		ELSIF (CLOCK'event AND CLOCK = '1') THEN
			IF (ENABLED = '1') THEN
				saida <= proxEntrada;
			END IF;
		END IF;
	END PROCESS;
END registrador_2;