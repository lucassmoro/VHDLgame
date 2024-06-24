LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

--para uso com o clock de 50MHz da placa DE2 (CLOCK_50)

ENTITY Div_Freq_DE2 IS
	PORT (
		clk : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		CLK_1Hz, sim_2hz : OUT STD_LOGIC
	);
END Div_Freq_DE2;

ARCHITECTURE divisor OF Div_Freq_DE2 IS
	SIGNAL cont : STD_LOGIC_VECTOR(27 DOWNTO 0); -- Registra valor da contagem
BEGIN
	P1 : PROCESS (clk, reset, cont)
	BEGIN
		IF reset = '1' THEN
			cont <= x"0000000";
			CLK_1Hz <= '0';
			sim_2hz <= '0';

		ELSIF clk'event AND clk = '1' THEN
			--1Hz = 1s = 50.000.000Hz = 50.000.000
			IF cont < x"17D783F" THEN --se contador < 24.999.999 (17D783F em hexadecimal)
				--CLK_1Hz <= '1';
				cont <= cont + 1;
				sim_2hz <= '0';
				clk_1Hz <= '0';

			ELSIF cont < x"2FAF07F" THEN --se contador < 49.999.999 (2FAF07F em hexadecimal)
				CLK_1Hz <= '0';
				cont <= cont + 1;
				sim_2hz <= '1';

			ELSE
				cont <= x"0000000";
				CLK_1Hz <= '1';
				sim_2hz <= '1';

			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;