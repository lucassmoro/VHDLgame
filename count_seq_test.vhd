LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY count_seq_test IS
END count_seq_test;

ARCHITECTURE count_seq_test OF count_seq_test IS
	SIGNAL CLOCK, R1, E5, E3 : STD_LOGIC := '0';

	COMPONENT count_seq IS
		PORT (
			CLOCK, R1, E5, E3 : IN STD_LOGIC;
			X : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
			end_sequence : OUT STD_LOGIC
		);
	END COMPONENT;
BEGIN
	seq : count_seq PORT MAP(
		CLOCK => CLOCK,
		R1 => R1,
		E5 => E5,
		E3 => E3
	);

	PROCESS
		CONSTANT period : TIME := 10 ns;
	BEGIN
		E3 <= '0';
		WAIT FOR period;
		FOR i IN 1 TO 2 LOOP
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
		END LOOP;

		E3 <= '1';
		WAIT FOR period;
		FOR i IN 1 TO 2 LOOP
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
		END LOOP;

		R1 <= '1';
		WAIT FOR period;
		R1 <= '0';
		WAIT FOR period;
		FOR i IN 1 TO 4 LOOP
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
		END LOOP;

		E5 <= '1';
		WAIT FOR period;
		E5 <= '0';
		WAIT FOR period;
		FOR i IN 1 TO 6 LOOP
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
		END LOOP;
		WAIT;
	END PROCESS;

END count_seq_test;