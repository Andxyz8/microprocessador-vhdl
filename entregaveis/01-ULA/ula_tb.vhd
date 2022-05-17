library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity ula_tb is
    
end;

architecture a_ula_tb of ula_tb is
    component ula
    port
    (
        inA     : IN signed (15 downto 0);
        inB     : IN signed (15 downto 0);
        seletor : IN unsigned (1 downto 0);
        saida_num   : OUT signed (15 downto 0);
        saida_bool : OUT std_logic
    );
end component;

signal inA, inB, saida_num : signed (15 downto 0);
signal seletor : unsigned(1 downto 0);
signal saida_bool : std_logic;

begin
    uut: ula port map
    (
        inA     => inA,
        inB     => inB,
        seletor => seletor,
        saida_num   => saida_num,
        saida_bool   => saida_bool
    );
    
    process
    begin

-- Seletor de operações:
--                   00 - soma
--                   01 - subtração
--                   10 - maior
--                   11 - diferente
        
  -- Testes com soma    -> seletor = "01"
--soma numero positivo + numero positivo
        seletor <= "00";
        inA <= "0000000000000011"; -- 3
        inB <= "0000000000000011"; -- 3
        wait for 50 ns;
        
--soma numero positivo + numero negativo
        seletor <= "00";
        inA <= "0000000000000011"; -- 3
        inB <= "1111111111111000"; --(-8)
        wait for 50 ns;
        
--soma numero negativo + numero positivo
        seletor <= "00";
        inA <= "1111111111111000"; --(-8)
        inB <= "0000000000000011"; -- 3
        wait for 50 ns;
        
--soma numero negativo + numero negativo
        seletor <= "00";
        inA <= "1111111111111000"; --(-8)
        inB <= "1111111111111000"; --(-8)
        wait for 50 ns;
        
        
        
        
  -- Testes com subtracao    -> seletor = "01"
--subtracao de dois numeros iguais
        seletor <= "01";
        inA <= "0000000000000011"; -- 3
        inB <= "0000000000000011"; -- 3
        wait for 50 ns;
        
--subtracao numero positivo - numero negativo
        seletor <= "01";
        inA <= "0000000000000011"; -- 3
        inB <= "1111111111111000"; --(-8)
        wait for 50 ns;
        
--subtracao numero negativo - numero positivo
        seletor <= "01";
        inA <= "1111111111111000"; --(-8)
        inB <= "0000000000000011"; -- 3
        wait for 50 ns;
        
--subtracao numero negativo - numero negativo
        seletor <= "01";
        inA <= "1111111111111000"; --(-8)
        inB <= "1111111111111101"; --(-5)
        wait for 50 ns;
        
        
        
        
    -- Testes com operacao maior    -> seletor = "10"
--dois numeros iguais
        seletor <= "10";
        inA <= "0000000000000011"; -- 3
        inB <= "0000000000000011"; -- 3
        wait for 50 ns;
        
--numero maior e numero menor
        seletor <= "10";
        inA <= "0000000000000011"; -- 3
        inB <= "0000000000000010"; -- 2
        wait for 50 ns;
        
--numero menor - numero maior
        seletor <= "10";
        inA <= "0000000000000011"; -- 3
        inB <= "0000000000000111"; -- 7
        wait for 50 ns;
        

        
    -- Testes com operacao diferente    -> seletor = "11"
--dois numeros iguais
        seletor <= "11";
        inA <= "0000000000000011"; -- 3
        inB <= "0000000000000011"; -- 3
        wait for 50 ns;
        
--dois numeros diferentes
        seletor <= "11";
        inA <= "0000000000000011"; -- 3
        inB <= "0000000000000010"; -- 2
        wait for 50 ns;
        
        wait;
        
    end process;

end architecture;