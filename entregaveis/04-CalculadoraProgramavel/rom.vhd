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
        0       => B"000000000000000",
        1       => B"110000_011_000101",    -- LD 5, $R3
        2       => B"110000_100_001000",    -- LD 8, $R4
        3       => B"011100_100_011_000",   -- ADD $R4,$R3
        4       => B"010000_101_100_000",   -- LD $R5,$R4
        5       => B"111101_101_000001",    -- SBC $R5, 1
        6       => B"101111_00_0010100",    -- JP 20
        20      => B"010000_011_101_000",   -- LD $R3,$R5
        21      => B"101111_00_0000011",    -- JP 3
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
