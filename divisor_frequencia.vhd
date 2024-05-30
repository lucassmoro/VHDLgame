LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY divisor_frequencia IS
	PORT (
		E1, E2 : IN STD_LOGIC;
		CLOCK : IN STD_LOGIC;
		CLK_1Hz : OUT STD_LOGIC;
		Sim_2Hz : OUT STD_LOGIC;
		Pisca : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END divisor_frequencia;

ARCHITECTURE divisor_frequencia OF divisor_frequencia IS
	SIGNAL reset : STD_LOGIC := '0';
	SIGNAL hz_1, hz_2 : STD_LOGIC := '0';

	COMPONENT Div_Freq IS
		PORT (
			clk : IN STD_LOGIC;
			reset : IN STD_LOGIC;
			CLK_1Hz, sim_2hz : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT Div_Freq_DE2 IS
		PORT (
			clk : IN STD_LOGIC;
			reset : IN STD_LOGIC;
			CLK_1Hz, sim_2hz : OUT STD_LOGIC
		);
	END COMPONENT;
BEGIN
	reset <= E1 OR E2;
	DIV : Div_Freq PORT MAP(
		clk => CLOCK,
		reset => reset,
		CLK_1Hz => hz_1,
		Sim_2Hz => hz_2
	);

	CLK_1HZ <= hz_1;
	SIM_2HZ <= hz_2;

	Pisca <= (hz_2 & hz_2 & hz_2 & hz_2 & hz_2 & hz_2 & hz_2 & hz_2 & hz_2 & hz_2 & hz_2 & hz_2 & hz_2 & hz_2 & hz_2 & hz_2) and "1111111111111111";
END divisor_frequencia;