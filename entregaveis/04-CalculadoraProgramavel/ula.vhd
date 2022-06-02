LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ula IS
    PORT(
        inA, inB    : IN UNSIGNED(15 DOWNTO 0);
        seletor     : IN UNSIGNED(1 DOWNTO 0);
        saida_num   : OUT UNSIGNED(15 DOWNTO 0);
        saida_bool  : OUT STD_LOGIC
    );
END ENTITY ula;

-- Seletor de operações:
--                   00 - soma
--                   01 - subtração
--                   10 - maior
--                   11 - diferente

ARCHITECTURE a_ula OF ula IS

BEGIN
    saida_num <=        inA + inB
                    WHEN
                        seletor="00"
                    ELSE
                        inA - inB
                    WHEN
                        seletor="01"
                    ELSE
                        "0000000000000000";

    saida_bool <=       '1' 
                    WHEN
                        (inA > inB) and seletor = "10"
                    ELSE
                        '1'
                    WHEN
                        (inA /= inB) and seletor = "11"
                    ELSE
                        '0';
    
END ARCHITECTURE a_ula;







