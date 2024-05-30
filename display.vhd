LIBRARY IEEE;
USE IEEE.Std_Logic_1164.ALL;

ENTITY display IS
	PORT (
		Seq_BCD, SW_BCD : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		nivel_penalidade : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		E1, E3, E4 : IN STD_LOGIC;
		HEX0, HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END display;

ARCHITECTURE display OF display IS
	SIGNAL L : STD_LOGIC_VECTOR(6 DOWNTO 0) := "1000111";
	SIGNAL bc0, bc1, bc2, bc3, bc4, bc5, bc6, bc7 : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL bcd_penalidade : STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL m0, m1, m2, m3 : STD_LOGIC_VECTOR(6 DOWNTO 0);
	SIGNAL selec : STD_LOGIC;
	COMPONENT DecBCD IS
		PORT (
			input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			output : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
	END COMPONENT;

	COMPONENT bcd7seg IS
		PORT (
			bcd_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			out_7seg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
	END COMPONENT;

	COMPONENT multiplexador_2_7 IS PORT (
		A : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		B : IN STD_LOGIC_VECTOR(6 DOWNTO 0);
		selector : IN STD_LOGIC;
		S : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
		);
	END COMPONENT;

BEGIN
	bcd_penalidade <= "00" & nivel_penalidade;
	selec <= (E4 OR E3);

	BCD0 : bcd7seg PORT MAP(
		bcd_in => "1111",
		out_7seg => bc0
	);

	BCD1 : bcd7seg PORT MAP(
		bcd_in => Seq_BCD(7 DOWNTO 4),
		out_7seg => bc1
	);


	BCD2 :
	bcd7seg PORT MAP(
		bcd_in => SW_BCD(7 DOWNTO 4),
		out_7seg => bc2

	);

	BCD3 : bcd7seg PORT MAP(
		bcd_in => "1111",
		out_7seg => bc3

	);

	BCD4 : bcd7seg PORT MAP(
		bcd_in => bcd_penalidade,
		out_7seg => bc4

	);

	BCD5 : bcd7seg PORT MAP(
		bcd_in => Seq_BCD(3 DOWNTO 0),
		out_7seg => bc5

	);

	BCD6 : bcd7seg PORT MAP(
		bcd_in => SW_BCD(3 DOWNTO 0),
		out_7seg => bc6
	);
	MUX0 : multiplexador_2_7 PORT MAP(
		A => bc0,
		B => L,
		selector => E1,
		S => m0
	);

	MUX1 : multiplexador_2_7 PORT MAP(
		A => bc1,
		B => bc2,
		selector => E4,
		S => m1
	);

	MUX2 : multiplexador_2_7 PORT MAP(
		A => bc3,
		B => bc4,
		selector => E1,
		S => m2
	);

	MUX3 : multiplexador_2_7 PORT MAP(
		A => bc5,
		B => bc6,
		selector => E4,
		S => m3
	);

	MUX4 : multiplexador_2_7 PORT MAP(
		A => m0(6 DOWNTO 0),
		B => m1(6 DOWNTO 0),
		selector => selec,
		S => HEX1
	);

	MUX5 : multiplexador_2_7 PORT MAP(
		A => m2(6 DOWNTO 0),
		B => m3(6 DOWNTO 0),
		selector => selec,
		S => HEX0
	);
END display;