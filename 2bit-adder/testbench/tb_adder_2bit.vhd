library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_adder_2bit is

end tb_adder_2bit;

architecture Behavioral of tb_adder_2bit is

    component adder_2bit is
    Port (  a : in STD_LOGIC_VECTOR (1 downto 0);
            b : in STD_LOGIC_VECTOR (1 downto 0);
            sum : out STD_LOGIC_VECTOR (1 downto 0);
            carry : out STD_LOGIC);
    end component adder_2bit;
    
    signal a, b: std_logic_vector (1 downto 0) := "00";
    signal sum: std_logic_vector (1 downto 0);
    signal carry: std_logic;

begin

    UUT: adder_2bit
    Port map(   a => a,
                b => b,
                sum => sum,
                carry => carry);
                
     stimuli: process
     begin
        a <= "00"; b <= "00";
        wait for 20 ns;
        assert(sum = "00") and (carry = '0') report "test failed" severity error;
        
        a <= "00"; b <= "01";
        wait for 20 ns;
        assert(sum = "01") and (carry = '0') report "test failed" severity error;
        
        a <= "00"; b <= "10";
        wait for 20 ns;
        assert(sum = "10") and (carry = '0') report "test failed" severity error;
        
        a <= "00"; b <= "11";
        wait for 20 ns;
        assert(sum = "11") and (carry = '0') report "test failed" severity error;
        
        a <= "01"; b <= "00";
        wait for 20 ns;
        assert(sum = "01") and (carry = '0') report "test failed" severity error;
        
        a <= "01"; b <= "01";
        wait for 20 ns;
        assert(sum = "10") and (carry = '0') report "test failed" severity error;
        
        a <= "01"; b <= "10";
        wait for 20 ns;
        assert(sum = "11") and (carry = '0') report "test failed" severity error;
        
        a <= "01"; b <= "11";
        wait for 20 ns;
        assert(sum = "00") and (carry = '1') report "test failed" severity error;
        
        a <= "10"; b <= "00";
        wait for 20 ns;
        assert(sum = "10") and (carry = '0') report "test failed" severity error;
        
        a <= "10"; b <= "01";
        wait for 20 ns;
        assert(sum = "11") and (carry = '0') report "test failed" severity error;
        
        a <= "10"; b <= "10";
        wait for 20 ns;
        assert(sum = "00") and (carry = '1') report "test failed" severity error;
        
        a <= "10"; b <= "11";
        wait for 20 ns;
        assert(sum = "01") and (carry = '1') report "test failed" severity error;
        
        a <= "11"; b <= "00";
        wait for 20 ns;
        assert(sum = "11") and (carry = '0') report "test failed" severity error;
        
        a <= "11"; b <= "01";
        wait for 20 ns;
        assert(sum = "00") and (carry = '1') report "test failed" severity error;
        
        a <= "11"; b <= "10";
        wait for 20 ns;
        assert(sum = "01") and (carry = '1') report "test failed" severity error;
        
        a <= "11"; b <= "11";
        wait for 20 ns;
        assert(sum = "10") and (carry = '1') report "test failed" severity error;
        
     wait;
        
     end process;

end Behavioral;