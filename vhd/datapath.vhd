LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY datapath IS PORT (
	SW : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	CLK : IN STD_LOGIC;
	Enter : IN STD_LOGIC;
	R1, E1, E2, E3, E4, E5, E6 : IN STD_LOGIC;

	end_game, end_sequence, end_round : OUT STD_LOGIC;
	HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	LEDR : OUT STD_LOGIC_VECTOR(17 DOWNTO 0));
END datapath;

ARCHITECTURE arc_data OF datapath IS

	SIGNAL Play, Pisca, Termo : STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";
	SIGNAL Seq_BCD, T_BCD, Penalty : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
	SIGNAL Alpha, Beta : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
	SIGNAL X : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
	SIGNAL nivel_penalidade : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
	SIGNAL CLK_1Hz, Sim_2Hz, Control : STD_LOGIC := '0';

	COMPONENT saida_leds IS
		PORT (
			E6 : IN STD_LOGIC;
			Termo : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			Pisca : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			LEDR : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT registrador_secreto IS
		PORT (
			SW : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			R1, E2, clock : IN STD_LOGIC;
			Alpha, Beta : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT registrador_penalidade IS
		PORT (
			SW : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			R1, E1, clock : IN STD_LOGIC;
			penalty : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
			nivel_penalidade: OUT STD_LOGIC_VECTOR(1 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT registrador_adivinhado IS
		PORT (
			SW_BCD : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			Seq_BCD : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			R1, E4, clock : IN STD_LOGIC;
			Play : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT divisor_frequencia IS
		PORT (
			E1, E2 : IN STD_LOGIC;
			CLOCK : IN STD_LOGIC;
			CLK_1Hz : OUT STD_LOGIC;
			Sim_2Hz : OUT STD_LOGIC;
			Pisca : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT count_time IS PORT (
		CLOCK, R1, E5, E4, CLK_1Hz : IN STD_LOGIC;
		Penalty : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		Control : IN STD_LOGIC;
		HEX6, HEX7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		end_game : OUT STD_LOGIC);
	END COMPONENT;

	COMPONENT count_seq IS
		PORT (
			CLOCK, R1, E5, E3 : IN STD_LOGIC;
			X : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
			end_sequence : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT count_round IS
		PORT (
			CLOCK, R1, E5 : IN STD_LOGIC;
			termo : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			end_round : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT calculo_f IS
		PORT (
			Alpha : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			Beta : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			X : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			seq_bcd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT comparador IS
		PORT (
			A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			control : OUT STD_LOGIC
		);
	END COMPONENT;

	COMPONENT display is
	port (Seq_BCD, SW_BCD:  in std_logic_vector(7 downto 0);
		nivel_penalidade: in std_logic_vector(1 downto 0);
		E1, E3, E4: in std_logic;
		HEX0, HEX1:  out std_logic_vector(6 downto 0)
		);
	end COMPONENT;
BEGIN
	HEX2 <= "1111111";
	HEX3 <= "1111111";
	HEX4 <= "1111111";
	HEX5 <= "1111111";

	COM : comparador PORT MAP(
		A => Play(15 DOWNTO 8),
		B => Play(7 DOWNTO 0),
		control => Control
	);

	DIV : divisor_frequencia PORT MAP(
		E1 => E1,
		E2 => E2,
		CLOCK => CLK,
		CLK_1Hz => CLK_1Hz,
		Sim_2Hz => Sim_2Hz,
		Pisca => Pisca
	);

	CNTime : count_time PORT MAP(
		CLOCK => CLK,
		R1 => R1,
		E5 => E5,
		E4 => E4,
		CLK_1Hz => CLK_1Hz,
		Penalty => Penalty,
		Control => Control,
		HEX6 => HEX6,
		HEX7 => HEX7,
		end_game => end_game
	);

	CntSeq : count_seq PORT MAP(
		CLOCK => CLK_1Hz,
		R1 => R1,
		E5 => E5,
		E3 => E3,
		X => X,
		end_sequence => end_sequence
	);

	CntRnd : count_round PORT MAP(
		CLOCK => CLK,
		R1 => R1,
		E5 => E5,
		termo => Termo,
		end_round => end_round
	);

	CalcF : calculo_f PORT MAP(
		Alpha => Alpha,
		Beta => Beta,
		X => X,
		seq_bcd => Seq_BCD
	);


	RegLvJ1 : registrador_penalidade PORT MAP(
		SW => SW(1 DOWNTO 0),
		nivel_penalidade => nivel_penalidade,
		R1 => R1,
		E1 => E1,
		clock => CLK,
		penalty => Penalty
	);

	RegNumJ1 : registrador_secreto PORT MAP(
		SW => SW,
		R1 => R1,
		E2 => E2,
		clock => CLK,
		Alpha => Alpha,
		Beta => Beta
	);

	RegNumJ2 : registrador_adivinhado PORT MAP(
		SW_BCD => SW,
		Seq_BCD => Seq_BCD,
		R1 => R1,
		E4 => E4,
		clock => CLK,
		Play => Play
	);

	LEDS : saida_leds PORT MAP(
		E6 => E6,
		Termo => Termo,
		Pisca => Pisca,
		LEDR => LEDR(15 DOWNTO 0)
	);

	DISP: display PORT MAP(
		SW_BCD => SW,
		Seq_BCD => Seq_BCD,
		nivel_penalidade => nivel_penalidade,
		E1 => E1, 
		E3 => E3, 
		E4 => E4,
		HEX0 => HEX0, 
		HEX1 => HEX1
	);
END arc_data;