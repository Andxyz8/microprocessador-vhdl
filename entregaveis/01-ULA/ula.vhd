LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity ula is
    port(
        inA, inB : in unsigned(15 downto 0);
        seletor : in unsigned(1 downto 0);
        saida_num : out unsigned(15 downto 0);
        saida_bool : out std_logic
    );
end entity;

-- Seletor de operações:
--                   00 - soma
--                   01 - subtração
--                   10 - maior
--                   11 - diferente

architecture a_ula of ula is

begin
    
    saida_num <= inA + inB when seletor="00" else
                 inA - inB when seletor="01" else
                 "0000000000000000";

    saida_bool <= '1' when (inA > inB) and seletor = "10" else
                  '1' when (inA /= inB) and seletor = "11" else
                  '0';
    
end architecture;







