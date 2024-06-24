LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.std_logic_signed.all;

ENTITY count_time IS PORT (
	CLOCK, R1, E5, E4, CLK_1Hz : IN STD_LOGIC;
	Penalty : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	Control : IN STD_LOGIC;
	HEX6, HEX7 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	end_game : OUT STD_LOGIC := '0'
);
END count_time;

ARCHITECTURE count_time OF count_time IS
	SIGNAL penalidade : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL tempo_decremento : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL count : STD_LOGIC_VECTOR(7 DOWNTO 0) := "01100011";
	SIGNAL coutBcd : STD_LOGIC_VECTOR(7 DOWNTO 0);
	SIGNAL enable : STD_LOGIC;

	COMPONENT multiplexador_2_8 IS PORT (
		A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		selector : IN STD_LOGIC;
		S : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;

	COMPONENT DecBCD IS PORT (
		input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		output : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	END COMPONENT;

	COMPONENT bcd7seg IS PORT (
		bcd_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		out_7seg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
	END COMPONENT;

BEGIN
	MUX0 : multiplexador_2_8 PORT MAP(
		A => Penalty,
		B => "00000000",
		selector => Control,
		S => penalidade

	);

	MUX1 : multiplexador_2_8 PORT MAP(
		A => "11110000",
		B => penalidade,
		selector => E5,
		S => tempo_decremento
	);

	DUT : DecBCD PORT MAP(
		input => count,
		output => coutBcd
	);

	BCD : bcd7seg PORT MAP(
		bcd_in => coutBcd(7 DOWNTO 4),
		out_7seg => Hex7
	);

	BCC : bcd7seg PORT MAP(
		bcd_in => coutBcd(3 DOWNTO 0),
		out_7seg => Hex6
	);

	enable <= (CLK_1Hz AND E4) OR E5;
	PROCESS (CLOCK, R1)
	BEGIN
		IF (R1 = '1') THEN
			count <= "01100011";
			end_game <= '0';
		ELSIF (CLOCK'event AND CLOCK = '1'AND count > "00000000" AND enable = '1') THEN
			count <= count + tempo_decremento;
			IF (count + tempo_decremento) <= "00000000" THEN
				count <= "00000000";
				end_game <= '1';
			END IF;
		END IF;
	END PROCESS;
END count_time;