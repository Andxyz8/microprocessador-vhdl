LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY rom IS
    PORT
    (
        clk     : IN STD_LOGIC;
        read    : IN STD_LOGIC;
        address : IN UNSIGNED (6 DOWNTO 0); -- Verificar a quantidade exata depois
        data    : OUT UNSIGNED (14 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_rom OF rom IS
    TYPE mem IS ARRAY (0 TO 127) OF UNSIGNED(14 DOWNTO 0);
    CONSTANT conteudo_rom : mem := (
        0       => B"110000_011_000000",    -- LD $R3, 0
        1       => B"110000_100_000000",    -- LD $R4, 0
        2       => B"010100_100_011_000",   -- ADD $R4, $R3
        3       => B"110100_011_000001",    -- ADD $R3, 1
        4       => B"100101_011_011110",    -- SBC $R3, 30
        5       => B"111111_00_1111101",    -- JR -3
        6       => B"010000_101_101_100",   -- LD $R5, $R4
        15      => B"110000_110_011111",    -- LD $R6, 31
        OTHERS  => (OTHERS => '0')
    );
    
BEGIN
    PROCESS(clk)
    BEGIN
        IF (read = '1') THEN
            IF(rising_edge(clk)) THEN
                data <= conteudo_rom(TO_INTEGER(address));
            END IF;
        END IF;
    END PROCESS;

END ARCHITECTURE a_rom;
