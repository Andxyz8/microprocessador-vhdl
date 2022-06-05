LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY flag IS
    PORT(
        clk     : IN STD_LOGIC;
        rst     : IN STD_LOGIC;
        wr_en   : IN STD_LOGIC;
        din     : IN STD_LOGIC;
        dout    : OUT STD_LOGIC
    );
END ENTITY flag;

ARCHITECTURE a_flag OF flag IS
    
    SIGNAL info : STD_LOGIC;
    
BEGIN
    PROCESS(clk, rst, wr_en)
    BEGIN
        IF rst = '1' THEN
            info <= '0';
        ELSIF wr_en = '1' THEN
            IF rising_edge(clk) THEN
                info <= din;
            END IF;
        END IF;
    END PROCESS;
    
    dout <= info;
    
END ARCHITECTURE a_flag;