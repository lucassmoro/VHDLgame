LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY saida_leds_test IS
END saida_leds_test;

ARCHITECTURE saida_leds_test OF saida_leds_test IS
	SIGNAL E6 : STD_LOGIC;
	SIGNAL pisca, termo, LEDR : STD_LOGIC_VECTOR(15 DOWNTO 0);
	COMPONENT saida_leds IS
		PORT (
			E6 : IN STD_LOGIC;
			Termo : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			Pisca : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			LEDR : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
BEGIN
	leds : saida_leds PORT MAP(
		E6 => E6,
		pisca => pisca,
		termo => termo,
		LEDR => LEDR
	);

	PROCESS
		CONSTANT period : TIME := 10 ns;
	BEGIN
		E6 <= '0';
		termo <= "0000000000000001";
		pisca <= "0000000000000010";
		WAIT FOR period;
		ASSERT (LEDR = termo)
		REPORT "Failed at termo 0." SEVERITY ERROR;

		termo <= "0000000000000100";
		WAIT FOR period;
		ASSERT (LEDR = termo)
		REPORT "Failed at termo 1." SEVERITY ERROR;

		E6 <= '1';
		WAIT FOR period;
		ASSERT (LEDR = pisca)
		REPORT "Failed at pisca 0." SEVERITY ERROR;

		pisca <= "0000000000001000";
		WAIT FOR period;
		ASSERT (LEDR = pisca)
		REPORT "Failed at pisca 1." SEVERITY ERROR;

		E6 <= '0';
		WAIT FOR period;
		ASSERT (LEDR = termo)
		REPORT "Failed at termo 2." SEVERITY ERROR;

		termo <= "0000000000010000";
		WAIT FOR period;
		ASSERT (LEDR = termo)
		REPORT "Failed at termo 3." SEVERITY ERROR;
		WAIT;
	END PROCESS;
END saida_leds_test;