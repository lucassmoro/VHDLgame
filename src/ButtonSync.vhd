LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY ButtonSync IS PORT (
	KEY1, KEY0, CLK : IN STD_LOGIC;
	BTN1, BTN0 : OUT STD_LOGIC);
END ButtonSync;
ARCHITECTURE ButtonSyncImpl OF ButtonSync IS
	TYPE STATES IS (EsperaApertar, SaidaAtiva, EsperaSoltar);
	SIGNAL BTN1_state, BTN0_state : STATES := EsperaApertar;
	SIGNAL BTN1_next, BTN0_next : STATES := EsperaApertar;

BEGIN
	PROCESS (clk)
	BEGIN
		IF clk'event AND clk = '1' THEN
			BTN1_state <= BTN1_next;
			BTN0_state <= BTN0_next;
		END IF;
	END PROCESS;
	PROCESS (key0, BTN0_state)
	BEGIN
		CASE BTN0_state IS
			WHEN EsperaApertar =>
				IF key0 = '0' THEN
					BTN0_next <= SaidaAtiva;
				ELSE
					BTN0_next <= EsperaApertar;
				END IF;
				BTN0 <= '0';
			WHEN SaidaAtiva =>
				IF key0 = '0' THEN
					BTN0_next <= EsperaSoltar;
				ELSE
					BTN0_next <= EsperaApertar;
				END IF;
				BTN0 <= '1';
			WHEN EsperaSoltar =>
				IF key0 = '0' THEN
					BTN0_next <= EsperaSoltar;
				ELSE
					BTN0_next <= EsperaApertar;
				END IF;
				BTN0 <= '0';
		END CASE;
	END PROCESS;
	PROCESS (key1, BTN1_state)
	BEGIN
		CASE BTN1_state IS
			WHEN EsperaApertar =>
				IF key1 = '0' THEN
					BTN1_next <= SaidaAtiva;
				ELSE
					BTN1_next <= EsperaApertar;
				END IF;
				BTN1 <= '0';
			WHEN SaidaAtiva =>
				IF key1 = '0' THEN
					BTN1_next <= EsperaSoltar;
				ELSE
					BTN1_next <= EsperaApertar;
				END IF;
				BTN1 <= '1';
			WHEN EsperaSoltar =>
				IF key1 = '0' THEN
					BTN1_next <= EsperaSoltar;
				ELSE
					BTN1_next <= EsperaApertar;
				END IF;
				BTN1 <= '0';
		END CASE;
	END PROCESS;
END ButtonSyncImpl;