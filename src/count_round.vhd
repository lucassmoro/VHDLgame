LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;
ENTITY count_round IS
	PORT (
		CLOCK, R1, E5 : IN STD_LOGIC;
		termo : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) := "0000000000000000";
		end_round : OUT STD_LOGIC := '0'
	);
END count_round;

ARCHITECTURE count_round OF count_round IS
	SIGNAL count : STD_LOGIC_VECTOR(3 DOWNTO 0) := "1111";
	COMPONENT decoder_termometrico IS PORT (
		X : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		S : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
	END COMPONENT;
BEGIN
	DUT : decoder_termometrico PORT MAP(
		X => count,
		S => termo
	);

	PROCESS (CLOCK, R1)
	BEGIN
		IF (R1 = '1') THEN
			count <= "1111";
			end_round <= '0';
		ELSIF (CLOCK'event AND CLOCK = '1' AND E5 = '1' AND count > "0000") THEN
			count <= count - '1';
			IF (count = "0001") THEN
				end_round <= '1';
			ELSE
				end_round <= '0';
			END IF;
		END IF;
	END PROCESS;
END count_round;