LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY saida_leds IS
	PORT (
		E6 : IN STD_LOGIC;
		Termo : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		Pisca : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		LEDR : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END saida_leds;

ARCHITECTURE saida_leds OF saida_leds IS

	COMPONENT multiplexador_2_16 IS
		PORT (
			A : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			B : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			selector : IN STD_LOGIC;
			S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;
BEGIN
	MUX : multiplexador_2_16 PORT MAP(
		A => Termo,
		B => Pisca,
		selector => E6,
		S => LEDR
	);
END saida_leds;