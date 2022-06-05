LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY program_counter IS
    PORT(
        clk     : IN STD_LOGIC;
        rst     : IN STD_LOGIC;
        wr_en   : IN STD_LOGIC;
        din     : IN UNSIGNED(6 DOWNTO 0);
        dout    : OUT UNSIGNED(6 DOWNTO 0)
    );
END ENTITY program_counter;

ARCHITECTURE a_program_counter OF program_counter IS
    
    SIGNAL info : UNSIGNED(6 DOWNTO 0);
    
BEGIN
    PROCESS(clk, rst, wr_en)
    BEGIN
        IF rst = '1' THEN
            info <= "0000000";
        ELSIF wr_en = '1' THEN
            IF rising_edge(clk) THEN
                info <= din;
            END IF;
        END IF;
    END PROCESS;
    
    dout <= info;

END ARCHITECTURE a_program_counter;