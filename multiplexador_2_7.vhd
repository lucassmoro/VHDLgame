library ieee;
use ieee.std_logic_1164.all;

entity multiplexador_2_7 is
port(
    A: in std_logic_vector(6 downto 0);
    B: in std_logic_vector(6 downto 0);
    selector: in std_logic;
    S: out std_logic_vector(6 downto 0)
    );
end multiplexador_2_7;

architecture multiplexador_2_7 of multiplexador_2_7 is
begin
    S <= A when selector = '0' else
         B;
end multiplexador_2_7; 