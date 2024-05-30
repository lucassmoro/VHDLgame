LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY count_round_test IS
END count_round_test;

ARCHITECTURE count_round_test OF count_round_test IS
	SIGNAL CLOCK, R1, E5 : STD_LOGIC := '0';

	COMPONENT count_round IS
		PORT (
			CLOCK, R1, E5 : IN STD_LOGIC;
			termo : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			end_round : OUT STD_LOGIC
		);
	END COMPONENT;
BEGIN
	seq : count_round PORT MAP(
		CLOCK => CLOCK,
		R1 => R1,
		E5 => E5
	);

	PROCESS
		CONSTANT period : TIME := 10 ns;
	BEGIN
		E5 <= '0';
		WAIT FOR period;
		FOR i IN 1 TO 2 LOOP
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
		END LOOP;

		E5 <= '1';
		WAIT FOR period;
		FOR i IN 1 TO 16 LOOP
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
		END LOOP;

		R1 <= '1';
		WAIT FOR period;
		R1 <= '0';
		FOR i IN 1 TO 20 LOOP
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
		END LOOP;
		WAIT;
	END PROCESS;

END count_round_test;