library ieee;
use ieee.std_logic_1164.all;

entity comparador is
port(
    A: in std_logic_vector(7 downto 0);
    B: in std_logic_vector(7 downto 0);
    control: out std_logic
    );
end comparador;
architecture comp of comparador is
begin
    control <= '1' when A = B else '0';
end comp;