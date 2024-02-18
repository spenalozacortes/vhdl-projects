library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity adder_2bit is
    Port ( a : in STD_LOGIC_VECTOR (1 downto 0);
           b : in STD_LOGIC_VECTOR (1 downto 0);
           sum : out STD_LOGIC_VECTOR (1 downto 0);
           carry : out STD_LOGIC);
end adder_2bit;

architecture Behavioral of adder_2bit is

    component half_adder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           sum : out STD_LOGIC;
           carry : out STD_LOGIC);
    end component;
    
    component full_adder is
        Port ( A : in STD_LOGIC;
               B : in STD_LOGIC;
               c_i : in STD_LOGIC;
               sum : out STD_LOGIC;
               c_o : out STD_LOGIC);
    end component;
    
    signal carry_s: std_logic; 

begin

    ha1: half_adder
    Port map(   a => a(0),
                b => b(0),
                sum => sum(0),
                carry => carry_s);

    fa1: full_adder
    Port map(   A => a(1),
                B => b(1),
                c_i => carry_s,
                sum => sum(1),
                c_o => carry);

end Behavioral;