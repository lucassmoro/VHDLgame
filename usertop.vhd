LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY usertop IS
	PORT (
		SW : IN STD_LOGIC_VECTOR(17 DOWNTO 0);
		KEY : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		CLOCK_50 : IN STD_LOGIC;
		LEDR : OUT STD_LOGIC_VECTOR(17 DOWNTO 0);
		HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END usertop;

ARCHITECTURE rtl OF usertop IS
	SIGNAL BTN : STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL r1, e1, e2, e3, e4, e5, e6 : STD_LOGIC;
	SIGNAL end_game, end_sequence, end_round, enter : STD_LOGIC;
	COMPONENT ButtonSync IS PORT (
		KEY1, KEY0, CLK : IN STD_LOGIC;
		BTN1, BTN0 : OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT controle IS PORT (
		clock, enter, reset : IN STD_LOGIC;
		end_game, end_sequence, end_round : IN STD_LOGIC;
		R1, E1, E2, E3, E4, E5, E6 : OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT datapath IS PORT (
		SW : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		CLK : IN STD_LOGIC;
		Enter : IN STD_LOGIC;
		R1, E1, E2, E3, E4, E5, E6 : IN STD_LOGIC;
		end_game, end_sequence, end_round : OUT STD_LOGIC;
		HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		LEDR : OUT STD_LOGIC_VECTOR(17 DOWNTO 0));
	END COMPONENT;

BEGIN

	bsc : ButtonSync PORT MAP(KEY(1), KEY(0), CLOCK_50, BTN(1), BTN(0));

	ctr : controle PORT MAP(
		CLOCK_50, BTN(1), BTN(0),
		end_game, end_sequence, end_round,
		r1, e1, e2, e3, e4, e5, e6);

	dtp : datapath PORT MAP(
		SW(7 DOWNTO 0), CLOCK_50, BTN(1),
		r1, e1, e2, e3, e4, e5, e6,
		end_game, end_sequence, end_round,
		HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0, LEDR);
END rtl;