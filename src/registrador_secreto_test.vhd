LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY registrador_secreto_test IS
END registrador_secreto_test;

ARCHITECTURE registrador_secreto_test OF registrador_secreto_test IS
	SIGNAL CLOCK, R1, E2 : STD_LOGIC := '0';
	SIGNAL SW : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";

	COMPONENT registrador_secreto IS
		PORT (
			SW : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			R1, E2, clock : IN STD_LOGIC;
			Alpha, Beta : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	END COMPONENT;
BEGIN
	seq : registrador_secreto PORT MAP(
		CLOCK => CLOCK,
		R1 => R1,
		E2 => E2,
		SW => SW
	);

	PROCESS
		CONSTANT period : TIME := 10 ns;
	BEGIN
		E2 <= '0';
		SW <= "00000000";
		WAIT FOR period;
		FOR i IN 1 TO 4 LOOP
			SW <= SW + '1';
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
		END LOOP;

		E2 <= '1';
		WAIT FOR period;
		FOR i IN 1 TO 10 LOOP
			SW <= SW + '1';
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
		END LOOP;

		R1 <= '1';
		SW <= "00000000";
		WAIT FOR period;
		R1 <= '0';
		FOR i IN 1 TO 30 LOOP
			SW <= SW + '1';
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
		END LOOP;
		WAIT;
	END PROCESS;

END registrador_secreto_test;