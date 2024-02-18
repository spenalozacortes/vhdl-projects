-- 1-bit Comparator

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparator1 is
    Port ( in1 : in STD_LOGIC;
           in2 : in STD_LOGIC;
           eq_o : out STD_LOGIC;
           gr_o : out STD_LOGIC;
           ls_o : out STD_LOGIC);
end comparator1;

architecture Behavioral of comparator1 is

begin

    eq_o <= (not in1 and not in2) or (in1 and in2); 
    gr_o <= in1 and not in2;
    ls_o <= not in1 and in2;

end Behavioral;
