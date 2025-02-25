LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY count_time_test IS
END count_time_test;

ARCHITECTURE count_time_test OF count_time_test IS
	SIGNAL CLOCK, R1, E5, E4, CLK_1Hz, Control : STD_LOGIC := '0';
	SIGNAL Penalty : STD_LOGIC_VECTOR(7 downto 0) := "00000101";
	

	COMPONENT count_time IS PORT (
		CLOCK, R1, E5, E4, CLK_1Hz : IN STD_LOGIC;
		Penalty : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		Control : IN STD_LOGIC;
		HEX6, HEX7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		end_game : OUT STD_LOGIC);
	END COMPONENT;
BEGIN
	seq : count_time PORT MAP(
		CLOCK => CLOCK,
		CLK_1Hz => CLOCK,
		R1 => R1,
		E4 => E4,
		E5 => E5,
		Penalty => Penalty,
		Control => Control
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
		FOR i IN 1 TO 22 LOOP
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
		END LOOP;

		R1 <= '1';
		WAIT FOR period;
		R1 <= '0';
		FOR i IN 1 TO 22 LOOP
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
		END LOOP;
		WAIT;
	END PROCESS;

END count_time_test;