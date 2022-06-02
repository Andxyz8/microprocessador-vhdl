LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY maq_estados IS
    PORT(
        clk     : IN STD_LOGIC;
        rst     : IN STD_LOGIC;
        state   : OUT STD_LOGIC
    );
END ENTITY maq_estados;

ARCHITECTURE a_maq_estados OF maq_estados IS
    SIGNAL state_s : STD_LOGIC; --> _s significa sinal interno
    
    
BEGIN
    PROCESS(clk, rst) BEGIN
        IF rst = '1' THEN
            state_s <= '0';
        ELSIF rising_edge(clk) THEN
            state_s <= NOT state_s;
        END IF;
    END PROCESS;
    
    state <= state_s;
    
END ARCHITECTURE a_maq_estados ;