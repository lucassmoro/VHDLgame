LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;

--para uso com o clock de 500Hz do FPGAEmu (CLK_500Hz)

ENTITY Div_Freq IS
	PORT (
		clk : IN STD_LOGIC;
		reset : IN STD_LOGIC;
		CLK_1Hz, sim_2hz : OUT STD_LOGIC
	);
END Div_Freq;

ARCHITECTURE divisor OF Div_Freq IS
	SIGNAL cont : STD_LOGIC_VECTOR(11 DOWNTO 0); -- Registra valor da contagem

BEGIN
	P1 : PROCESS (clk, reset, cont) --clock 500Hz
	BEGIN
		IF reset = '1' THEN
			cont <= x"000";
			CLK_1Hz <= '0';
			sim_2hz <= '0';

		ELSIF clk'event AND clk = '1' THEN
			--1Hz = 1s = 500Hzx1 = 500
			IF cont < x"0F9" THEN --se contador < 249 (0F9 em hexadecimal)
				sim_2hz <= '0';
				clk_1Hz <= '0';
				cont <= cont + 1;
			ELSIF cont < x"1F3" THEN --se contador < 499 (1F3 em hexadecimal)
				CLK_1Hz <= '0';
				sim_2hz <= '1';
				cont <= cont + 1;

			ELSE
				cont <= x"000";
				CLK_1Hz <= '1';
				sim_2hz <= '1';
			END IF;
		END IF;
	END PROCESS;

END ARCHITECTURE;