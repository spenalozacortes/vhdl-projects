-- 1-bit Comparator
-- TESTBENCH

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tbcomparator1 is

end tbcomparator1;

architecture Behavioral of tbcomparator1 is

    component comparator1 is
    Port ( in1 : in STD_LOGIC;
           in2 : in STD_LOGIC;
           eq_o : out STD_LOGIC;
           gr_o : out STD_LOGIC;
           ls_o : out STD_LOGIC);
    end component comparator1;
    
    signal in1, in2 : std_logic := '0';
    signal eq_o, gr_o, ls_o : std_logic;

begin

    UUT: comparator1
    Port map (  in1 => in1,
                in2 => in2,
                eq_o => eq_o,
                gr_o => gr_o,
                ls_o => ls_o);
                
    stimuli: process
    begin
        in1 <= '0'; in2 <= '0';
        wait for 20 ns;
        assert(eq_o = '1') and (gr_o = '0') and (ls_o = '0') report "test failed for 00" severity error;
        
        in1 <= '0'; in2 <= '1';
        wait for 20 ns;
        assert(eq_o = '0') and (gr_o = '0') and (ls_o = '1') report "test failed for 00" severity error;
         
        in1 <= '1'; in2 <= '0';
        wait for 20 ns;
        assert(eq_o = '0') and (gr_o = '1') and (ls_o = '0') report "test failed for 00" severity error;
          
        in1 <= '1'; in2 <= '1';
        wait for 20 ns;
        assert(eq_o = '1') and (gr_o = '0') and (ls_o = '0') report "test failed for 00" severity error;
       
    wait;
    end process;

end Behavioral;