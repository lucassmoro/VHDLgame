LIBRARY IEEE;
USE IEEE.Std_Logic_1164.ALL;

--decoder binario para bcd de 0 a 99

ENTITY DecBCD IS PORT (

	input : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
	output : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));

END DecBCD;

ARCHITECTURE arc_DecBCD OF DecBCD IS BEGIN

	output <= x"00" WHEN input = x"00" ELSE
		x"01" WHEN input = x"01" ELSE
		x"02" WHEN input = x"02" ELSE
		x"03" WHEN input = x"03" ELSE
		x"04" WHEN input = x"04" ELSE
		x"05" WHEN input = x"05" ELSE
		x"06" WHEN input = x"06" ELSE
		x"07" WHEN input = x"07" ELSE
		x"08" WHEN input = x"08" ELSE
		x"09" WHEN input = x"09" ELSE
		x"10" WHEN input = x"0A" ELSE
		x"11" WHEN input = x"0B" ELSE
		x"12" WHEN input = x"0C" ELSE
		x"13" WHEN input = x"0D" ELSE
		x"14" WHEN input = x"0E" ELSE
		x"15" WHEN input = x"0F" ELSE
		x"16" WHEN input = x"10" ELSE
		x"17" WHEN input = x"11" ELSE
		x"18" WHEN input = x"12" ELSE
		x"19" WHEN input = x"13" ELSE
		x"20" WHEN input = x"14" ELSE
		x"21" WHEN input = x"15" ELSE
		x"22" WHEN input = x"16" ELSE
		x"23" WHEN input = x"17" ELSE
		x"24" WHEN input = x"18" ELSE
		x"25" WHEN input = x"19" ELSE
		x"26" WHEN input = x"1A" ELSE
		x"27" WHEN input = x"1B" ELSE
		x"28" WHEN input = x"1C" ELSE
		x"29" WHEN input = x"1D" ELSE
		x"30" WHEN input = x"1E" ELSE
		x"31" WHEN input = x"1F" ELSE
		x"32" WHEN input = x"20" ELSE
		x"33" WHEN input = x"21" ELSE
		x"34" WHEN input = x"22" ELSE
		x"35" WHEN input = x"23" ELSE
		x"36" WHEN input = x"24" ELSE
		x"37" WHEN input = x"25" ELSE
		x"38" WHEN input = x"26" ELSE
		x"39" WHEN input = x"27" ELSE
		x"40" WHEN input = x"28" ELSE
		x"41" WHEN input = x"29" ELSE
		x"42" WHEN input = x"2A" ELSE
		x"43" WHEN input = x"2B" ELSE
		x"44" WHEN input = x"2C" ELSE
		x"45" WHEN input = x"2D" ELSE
		x"46" WHEN input = x"2E" ELSE
		x"47" WHEN input = x"2F" ELSE
		x"48" WHEN input = x"30" ELSE
		x"49" WHEN input = x"31" ELSE
		x"50" WHEN input = x"32" ELSE
		x"51" WHEN input = x"33" ELSE
		x"52" WHEN input = x"34" ELSE
		x"53" WHEN input = x"35" ELSE
		x"54" WHEN input = x"36" ELSE
		x"55" WHEN input = x"37" ELSE
		x"56" WHEN input = x"38" ELSE
		x"57" WHEN input = x"39" ELSE
		x"58" WHEN input = x"3A" ELSE
		x"59" WHEN input = x"3B" ELSE
		x"60" WHEN input = x"3C" ELSE
		x"61" WHEN input = x"3D" ELSE
		x"62" WHEN input = x"3E" ELSE
		x"63" WHEN input = x"3F" ELSE
		x"64" WHEN input = x"40" ELSE
		x"65" WHEN input = x"41" ELSE
		x"66" WHEN input = x"42" ELSE
		x"67" WHEN input = x"43" ELSE
		x"68" WHEN input = x"44" ELSE
		x"69" WHEN input = x"45" ELSE
		x"70" WHEN input = x"46" ELSE
		x"71" WHEN input = x"47" ELSE
		x"72" WHEN input = x"48" ELSE
		x"73" WHEN input = x"49" ELSE
		x"74" WHEN input = x"4A" ELSE
		x"75" WHEN input = x"4B" ELSE
		x"76" WHEN input = x"4C" ELSE
		x"77" WHEN input = x"4D" ELSE
		x"78" WHEN input = x"4E" ELSE
		x"79" WHEN input = x"4F" ELSE
		x"80" WHEN input = x"50" ELSE
		x"81" WHEN input = x"51" ELSE
		x"82" WHEN input = x"52" ELSE
		x"83" WHEN input = x"53" ELSE
		x"84" WHEN input = x"54" ELSE
		x"85" WHEN input = x"55" ELSE
		x"86" WHEN input = x"56" ELSE
		x"87" WHEN input = x"57" ELSE
		x"88" WHEN input = x"58" ELSE
		x"89" WHEN input = x"59" ELSE
		x"90" WHEN input = x"5A" ELSE
		x"91" WHEN input = x"5B" ELSE
		x"92" WHEN input = x"5C" ELSE
		x"93" WHEN input = x"5D" ELSE
		x"94" WHEN input = x"5E" ELSE
		x"95" WHEN input = x"5F" ELSE
		x"96" WHEN input = x"60" ELSE
		x"97" WHEN input = x"61" ELSE
		x"98" WHEN input = x"62" ELSE
		x"99" WHEN input = x"63" ELSE
		x"FF"; -- saida invalida para caso entrada invalida

END arc_DecBCD;