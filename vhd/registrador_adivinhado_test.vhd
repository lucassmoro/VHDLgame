LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY registrador_adivinhado_test IS
END registrador_adivinhado_test;

ARCHITECTURE registrador_adivinhado_test OF registrador_adivinhado_test IS
	SIGNAL CLOCK, R1, E4 : STD_LOGIC := '0';
	SIGNAL SW_BCD, Seq_BCD : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";

	COMPONENT registrador_adivinhado IS
		PORT (
			SW_BCD : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			Seq_BCD : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			R1, E4, clock : IN STD_LOGIC;
			Play : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
BEGIN
	ADV : registrador_adivinhado PORT MAP(
		CLOCK => CLOCK,
		R1 => R1,
		E4 => E4,
		SW_BCD => SW_BCD,
		Seq_BCD => Seq_BCD
	);

	PROCESS
		CONSTANT period : TIME := 10 ns;
	BEGIN
		E4 <= '0';
		SW_BCD <= "00000000";
		Seq_BCD <= "00000000";
		WAIT FOR period;
		FOR i IN 1 TO 4 LOOP
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			SW_BCD <= SW_BCD + '1';
		END LOOP;

		E4 <= '1';
		SW_BCD <= "00000000";
		Seq_BCD <= "00000000";
		WAIT FOR period;
		FOR i IN 1 TO 3 LOOP
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			SW_BCD <= SW_BCD + '1';
		END LOOP;

		R1 <= '1';
		Seq_BCD <= "00000000";
		WAIT FOR period;
		R1 <= '0';
		FOR i IN 1 TO 10 LOOP
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			CLOCK <= NOT CLOCK;
			WAIT FOR period;
			Seq_BCD <= Seq_BCD + '1';
		END LOOP;
		WAIT;
	END PROCESS;

END registrador_adivinhado_test;