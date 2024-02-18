-- 2-bit Comparator (selected signal)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparator3 is
    Port ( in1 : in STD_LOGIC_VECTOR (1 downto 0);
           in2 : in STD_LOGIC_VECTOR (1 downto 0);
           eq_o : out STD_LOGIC;
           gr_o : out STD_LOGIC;
           ls_o : out STD_LOGIC);
end comparator3;

architecture Behavioral of comparator3 is

begin

    eq_o <= '1' when in1 = in2 else
            '0';
            
    gr_o <= '1' when in1 > in2 else
            '0';
            
    ls_o <= '1' when in1 < in2 else
            '0';

end Behavioral;