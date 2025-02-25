LIBRARY IEEE;
USE IEEE.Std_Logic_1164.ALL;

ENTITY bcd7seg IS
	PORT (
		bcd_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		out_7seg : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
	);
END bcd7seg;

ARCHITECTURE mydecod OF bcd7seg IS
BEGIN
	out_7seg <= "1000000" WHEN bcd_in = "0000" ELSE
		"1111001" WHEN bcd_in = "0001" ELSE
		"0100100" WHEN bcd_in = "0010" ELSE
		"0110000" WHEN bcd_in = "0011" ELSE
		"0011001" WHEN bcd_in = "0100" ELSE
		"0010010" WHEN bcd_in = "0101" ELSE
		"0000010" WHEN bcd_in = "0110" ELSE
		"1111000" WHEN bcd_in = "0111" ELSE
		"0000000" WHEN bcd_in = "1000" ELSE
		"0011000" WHEN bcd_in = "1001" ELSE
		"1111111";
END mydecod;