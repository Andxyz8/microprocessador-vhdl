LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY registrador_16bits IS
    port(
        clk      : IN std_logic;
        rst      : IN std_logic;
        wr_en    : IN std_logic;
        data_in  : IN UNSIGNED(15 DOWNTO 0);
        data_out : out UNSIGNED(15 DOWNTO 0)
    );
END ENTITY registrador_16bits;

ARCHITECTURE a_registrador_16bits OF registrador_16bits IS
    SIGNAL registro: UNSIGNED(15 DOWNTO 0);
    
BEGIN
    PROCESS(clk, rst, wr_en)
    BEGIN
        IF rst = '1' THEN
            registro <= "0000000000000000";
        ELSIF wr_en = '1' THEN
            IF rising_edge(clk) THEN
                registro <= data_in;
            END IF;
        END IF;
    END PROCESS;
    
    data_out <= registro;
    
END ARCHITECTURE a_registrador_16bits;