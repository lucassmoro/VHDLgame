LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
ENTITY count_seq IS
	PORT (
		CLOCK, R1, E5, E3 : IN STD_LOGIC;
		X : OUT STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
		end_sequence : OUT STD_LOGIC := '0'
	);
END count_seq;

ARCHITECTURE count_seq OF count_seq IS
	SIGNAL count : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";
BEGIN
	PROCESS (CLOCK, R1, E5)
	BEGIN
		IF (R1 = '1' OR E5 = '1') THEN
			count <= "000";
			end_sequence <= '0';
		ELSIF (CLOCK'event AND CLOCK = '1' AND E3 = '1' AND count < "100") THEN
			count <= count + '1';
			IF (count >= "011") THEN 
				end_sequence <= '1';
			ELSE
				end_sequence <= '0';
			END IF;
		END IF;
	END PROCESS;

	X <= count;
END count_seq;