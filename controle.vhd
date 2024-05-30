LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY controle IS PORT (
	clock, enter, reset : IN STD_LOGIC;
	end_game, end_sequence, end_round : IN STD_LOGIC;

	R1, E1, E2, E3, E4, E5, E6 : OUT STD_LOGIC);
END controle;
ARCHITECTURE arc_controle OF controle IS
	TYPE STATES IS (INIT, SETUP, SECRET, SEQUENCE, PLAY, CHECK, RESULT);
	SIGNAL estado_atual, proximo_estado : STATES;
BEGIN
	PROCESS (clock, reset) BEGIN
		IF (reset = '1') THEN
			estado_atual <= INIT;
		ELSIF (clock'event AND clock = '1') THEN
			estado_atual <= proximo_estado;
		END IF;
	END PROCESS;

	PROCESS (estado_atual, clock) BEGIN
		CASE estado_atual IS
			WHEN INIT =>
				R1 <= '1';
				E1 <= '0';
				E2 <= '0';
				E3 <= '0';
				E4 <= '0';
				E5 <= '0';
				E6 <= '0';
				proximo_estado <= SETUP;
			WHEN SETUP =>
				R1 <= '0';
				E1 <= '1';
				E2 <= '0';
				E3 <= '0';
				E4 <= '0';
				E5 <= '0';
				E6 <= '0';
				IF (enter = '1') THEN
					proximo_estado <= SECRET;
				ELSE
					proximo_estado <= SETUP;
				END IF;
			WHEN SECRET =>
				R1 <= '0';
				E1 <= '0';
				E2 <= '1';
				E3 <= '0';
				E4 <= '0';
				E5 <= '0';
				E6 <= '0';
				IF (enter = '1') THEN
					proximo_estado <= SEQUENCE;
				ELSE
					proximo_estado <= SECRET;
				END IF;
			WHEN SEQUENCE =>
				R1 <= '0';
				E1 <= '0';
				E2 <= '0';
				E3 <= '1';
				E4 <= '0';
				E5 <= '0';
				E6 <= '0';
				IF (end_sequence = '1') THEN
					proximo_estado <= PLAY;
				ELSE
					proximo_estado <= SEQUENCE;
				END IF;
			WHEN PLAY =>
				R1 <= '0';
				E1 <= '0';
				E2 <= '0';
				E3 <= '0';
				E4 <= '1';
				E5 <= '0';
				E6 <= '0';
				IF (end_game = '1' OR end_round = '1') THEN
					proximo_estado <= RESULT;
				ELSIF (enter = '1') THEN
					proximo_estado <= CHECK;
				ELSE
					proximo_estado <= PLAY;
				END IF;
			WHEN CHECK =>
				R1 <= '0';
				E1 <= '0';
				E2 <= '0';
				E3 <= '0';
				E4 <= '0';
				E5 <= '1';
				E6 <= '0';

				IF (end_game = '1') THEN
					proximo_estado <= RESULT;
				ELSE
					proximo_estado <= SECRET;
				END IF;
			WHEN RESULT =>
				R1 <= '0';
				E1 <= '0';
				E2 <= '0';
				E3 <= '0';
				E4 <= '0';
				E5 <= '0';
				E6 <= '1';
				IF (enter = '1') THEN
					proximo_estado <= INIT;
				ELSE
					proximo_estado <= RESULT;
				END IF;
		END CASE;
	END PROCESS;
END arc_controle;