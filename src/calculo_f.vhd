LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

ENTITY calculo_f IS
	PORT (
		Alpha : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		Beta : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		X : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		seq_bcd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END calculo_f;

ARCHITECTURE calculo_f OF calculo_f IS
	SIGNAL B0, B1, B2, B3, S0, S1, S2, S3, SOMA1, SOMA2, SOMA3, SOMA4 : STD_LOGIC_VECTOR(7 DOWNTO 0);

	COMPONENT multiplexador_2_8 IS
		PORT (
			A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			selector : IN STD_LOGIC;
			S : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;
	COMPONENT DecBCD IS PORT (
		input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		output : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;
BEGIN
	B3 <= "00" & X & "000";
	B2 <= "000" & X & "00";
	B1 <= "0000" & X & "0";
	B0 <= "00000" & X;
	MUXA : multiplexador_2_8 PORT MAP(
		A => "00000000",
		B => B0,
		selector => Alpha(0),
		S => S0
	);

	MUXB : multiplexador_2_8 PORT MAP(
		A => "00000000",
		B => B1,
		selector => Alpha(1),
		S => S1
	);

	MUXC : multiplexador_2_8 PORT MAP(
		A => "00000000",
		B => B2,
		selector => Alpha(2),
		S => S2
	);

	MUXD : multiplexador_2_8 PORT MAP(
		A => "00000000",
		B => B3,
		selector => Alpha(3),
		S => S3
	);

	SOMA1 <= S0 + S1;
	SOMA2 <= S2 + S3;
	SOMA3 <= SOMA1 + SOMA2;
	SOMA4 <= SOMA3 + Beta;

	BCD : DecBCD PORT MAP(
		input => SOMA4,
		output => seq_bcd
	);
END calculo_f;