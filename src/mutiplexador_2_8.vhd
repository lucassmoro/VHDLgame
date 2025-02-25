LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY multiplexador_2_8 IS
	PORT (
		A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		selector : IN STD_LOGIC;
		S : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END multiplexador_2_8;

ARCHITECTURE multiplexador_2_8 OF multiplexador_2_8 IS
BEGIN
	S <=
		A WHEN selector = '0' ELSE
		B;
END multiplexador_2_8;