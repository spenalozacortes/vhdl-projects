-- 2-bit Comparator
-- BOOLEAN EQUATIONS

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity comparator2 is
    Port ( in1 : in STD_LOGIC_VECTOR (1 downto 0);
           in2 : in STD_LOGIC_VECTOR (1 downto 0);
           eq_o : out STD_LOGIC;
           gr_o : out STD_LOGIC;
           ls_o : out STD_LOGIC);
end comparator2;

architecture Behavioral of comparator2 is

begin
    
    eq_o <= (not in1(1) and not in1(0) and not in2(1) and not in2(0)) or
            (not in1(1) and in1(0) and not in2(1) and in2(0)) or
            (in1(1) and not in1(0) and in2(1) and not in2(0)) or
            (in1(1) and in1(0) and in2(1) and in2(0));
            
    gr_o <= (not in1(1) and in1(0) and not in2(1) and not in2(0)) or
            (in1(1) and not in1(0) and not in2(1) and not in2(0)) or
            (in1(1) and not in1(0) and not in2(1) and in2(0)) or
            (in1(1) and in1(0) and not in2(1) and not in2(0)) or
            (in1(1) and in1(0) and not in2(1) and in2(0)) or
            (in1(1) and in1(0) and in2(1) and not in2(0));
            
    ls_o <= (not in1(1) and not in1(0) and not in2(1) and in2(0)) or
            (not in1(1) and not in1(0) and in2(1) and not in2(0)) or
            (not in1(1) and not in1(0) and in2(1) and in2(0)) or
            (not in1(1) and in1(0) and in2(1) and not in2(0)) or
            (not in1(1) and in1(0) and in2(1) and in2(0)) or
            (in1(1) and not in1(0) and in2(1) and in2(0));

end Behavioral;