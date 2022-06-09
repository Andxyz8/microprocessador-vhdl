LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY maquina_estados IS
    PORT(
        clk     : IN STD_LOGIC;
        rst     : IN STD_LOGIC;
        state   : OUT UNSIGNED(1 DOWNTO 0)
    );
END ENTITY maquina_estados;

ARCHITECTURE a_maquina_estados OF maquina_estados IS
    SIGNAL state_s : UNSIGNED(1 DOWNTO 0);

BEGIN
    PROCESS(clk, rst)
    BEGIN
        IF rst = '1' THEN
            state_s <= "00";
        ELSIF rising_edge(clk) THEN
            IF state_s = "10" THEN
                state_s <= "00";
            ELSE
                state_s <= state_s+1;
            END IF;
        END IF;
    END PROCESS;
    
    state <= state_s;
    
END ARCHITECTURE a_maquina_estados ;