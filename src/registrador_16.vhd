LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY registrador_16 IS
	PORT (
		proxEntrada : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		RESET, CLOCK, ENABLED : IN STD_LOGIC;
		saida : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000"
	);
END registrador_16;

ARCHITECTURE registrador_16 OF registrador_16 IS
BEGIN
	PROCESS (CLOCK, RESET)
	BEGIN
		IF (RESET = '1') THEN
			saida <= "0000000000000000";
		ELSIF (CLOCK'event AND CLOCK = '1') THEN
			IF (ENABLED = '1') THEN
				saida <= proxEntrada;
			END IF;
		END IF;
	END PROCESS;
END registrador_16;