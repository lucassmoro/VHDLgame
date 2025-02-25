LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY registrador_penalidade_test IS
END registrador_penalidade_test;

ARCHITECTURE registrador_penalidade_test OF registrador_penalidade_test IS
	SIGNAL CLOCK, R1, E1 : STD_LOGIC := '0';
	SIGNAL SW : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";

	COMPONENT registrador_penalidade IS
		PORT (
			SW : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			R1, E1, clock : IN STD_LOGIC;
			nivel_penalidade : OUT STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
			penalty : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) 
		);
	END COMPONENT;
BEGIN
	seq : registrador_penalidade PORT MAP(
		CLOCK => CLOCK,
		R1 => R1,
		E1 => E1,
		SW => SW
	);

	PROCESS
		CONSTANT period : TIME := 10 ns;
	BEGIN
		E1 <= '0';
		SW <= "00";
		WAIT FOR period;
		FOR i IN 1 TO 4 LOOP
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			SW <= SW + '1';
		END LOOP;

		E1 <= '1';
		SW <= "00";
		WAIT FOR period;
		FOR i IN 1 TO 3 LOOP
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			SW <= SW + '1';
		END LOOP;

		R1 <= '1';
		SW <= "00";
		WAIT FOR period;
		R1 <= '0';
		FOR i IN 1 TO 4 LOOP
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			SW <= SW + '1';
		END LOOP;
		WAIT;
	END PROCESS;

END registrador_penalidade_test;