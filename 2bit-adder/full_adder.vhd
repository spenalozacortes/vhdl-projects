library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           c_i : in STD_LOGIC;
           sum : out STD_LOGIC;
           c_o : out STD_LOGIC);
end full_adder;

architecture Behavioral of full_adder is

    component half_adder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           sum : out STD_LOGIC;
           carry : out STD_LOGIC);
    end component;
    
    signal ha1_sum, ha1_carry, ha2_carry: std_logic;

begin
    
    ha1: half_adder
    port map(   a => A,
                b => B,
                sum => ha1_sum,
                carry => ha1_carry);

    ha2: half_adder
    port map(   a => ha1_sum,
                b => c_i,
                sum => sum,
                carry => ha2_carry);
                
    ha3: half_adder
    port map(   a => ha1_carry,
                b => ha2_carry,
                sum => c_o,
                carry => open);
                
end Behavioral;