-- 2-bit Comparator (selected signal)
-- TESTBENCH

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tbcomparator3 is
--  Port ( );
end tbcomparator3;

architecture Behavioral of tbcomparator3 is

    component comparator3 is
    Port (     in1 : in STD_LOGIC_VECTOR (1 downto 0);
               in2 : in STD_LOGIC_VECTOR (1 downto 0);
               eq_o : out STD_LOGIC;
               gr_o : out STD_LOGIC;
               ls_o : out STD_LOGIC);
    end component comparator3;
    
    signal in1, in2 : std_logic_vector(1 downto 0) := "00";
    signal eq_o, gr_o, ls_o : std_logic;

begin

    UUT: comparator3
    Port map (  in1 => in1,
                in2 => in2,
                eq_o => eq_o,
                gr_o => gr_o,
                ls_o => ls_o);
                
    stimuli: process
    begin
        in1 <= "00"; in2 <= "00";
        wait for 20 ns;
        assert(eq_o = '1') and (gr_o = '0') and (ls_o = '0') report "test failed for 0000" severity error;
        
        in1 <= "00"; in2 <= "01";
        wait for 20 ns;
        assert(eq_o = '0') and (gr_o = '0') and (ls_o = '1') report "test failed for 0001" severity error;
        
        in1 <= "00"; in2 <= "10";
        wait for 20 ns;
        assert(eq_o = '0') and (gr_o = '0') and (ls_o = '1') report "test failed for 0010" severity error;
                
        in1 <= "00"; in2 <= "11";
        wait for 20 ns;
        assert(eq_o = '0') and (gr_o = '0') and (ls_o = '1') report "test failed for 0011" severity error;

        in1 <= "01"; in2 <= "00";
        wait for 20 ns;
        assert(eq_o = '0') and (gr_o = '1') and (ls_o = '0') report "test failed for 0100" severity error;
        
        in1 <= "01"; in2 <= "01";
        wait for 20 ns;
        assert(eq_o = '1') and (gr_o = '0') and (ls_o = '0') report "test failed for 0101" severity error;
        
        in1 <= "01"; in2 <= "10";
        wait for 20 ns;
        assert(eq_o = '0') and (gr_o = '0') and (ls_o = '1') report "test failed for 0110" severity error;
                
        in1 <= "01"; in2 <= "11";
        wait for 20 ns;
        assert(eq_o = '0') and (gr_o = '0') and (ls_o = '1') report "test failed for 0111" severity error;
        
        in1 <= "10"; in2 <= "00";
        wait for 20 ns;
        assert(eq_o = '0') and (gr_o = '1') and (ls_o = '0') report "test failed for 1000" severity error;
        
        in1 <= "10"; in2 <= "01";
        wait for 20 ns;
        assert(eq_o = '0') and (gr_o = '1') and (ls_o = '0') report "test failed for 1001" severity error;
        
        in1 <= "10"; in2 <= "10";
        wait for 20 ns;
        assert(eq_o = '1') and (gr_o = '0') and (ls_o = '0') report "test failed for 1010" severity error;
                
        in1 <= "10"; in2 <= "11";
        wait for 20 ns;
        assert(eq_o = '0') and (gr_o = '0') and (ls_o = '1') report "test failed for 1011" severity error;
        
        in1 <= "11"; in2 <= "00";
        wait for 20 ns;
        assert(eq_o = '0') and (gr_o = '1') and (ls_o = '0') report "test failed for 1100" severity error;
        
        in1 <= "11"; in2 <= "01";
        wait for 20 ns;
        assert(eq_o = '0') and (gr_o = '1') and (ls_o = '0') report "test failed for 1101" severity error;
        
        in1 <= "11"; in2 <= "10";
        wait for 20 ns;
        assert(eq_o = '0') and (gr_o = '1') and (ls_o = '0') report "test failed for 1110" severity error;
                
        in1 <= "11"; in2 <= "11";
        wait for 20 ns;
        assert(eq_o = '1') and (gr_o = '0') and (ls_o = '0') report "test failed for 1111" severity error;
       
    wait;
    end process;

end Behavioral;
