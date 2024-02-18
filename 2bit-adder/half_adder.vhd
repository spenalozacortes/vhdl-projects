library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity half_adder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           sum : out STD_LOGIC;
           carry : out STD_LOGIC);
end half_adder;

architecture Behavioral of half_adder is

begin
    
    sum <= (not a and b) or (a and not b);
    carry <= a and b;

end Behavioral;