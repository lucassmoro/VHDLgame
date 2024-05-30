LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY multiplexador_4_8 IS
	PORT (
		A : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		B : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		C : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		D : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		selector : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		S : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
	);
END multiplexador_4_8;

ARCHITECTURE multiplexador_4_8 OF multiplexador_4_8 IS
BEGIN
	S <=
		A WHEN selector = "00" ELSE
		B WHEN selector = "01" ELSE
		C WHEN selector = "10" ELSE
		D;
END multiplexador_4_8;