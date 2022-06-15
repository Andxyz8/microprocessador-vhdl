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
        0       => B"00001_011_0000000",    -- LD C, 0
        1       => B"00001_100_0000000",    -- LD D, 0
        2       => B"00110_100_011_0000",   -- ADD D, C
        3       => B"00101_011_0000001",    -- ADD C, 1
        4       => B"01011_011_0011110",    -- SBC C, 30
        5       => B"11111_000_1111100",    -- JR -4
        6       => B"00010_101_100_0000",   -- LD E, D
        15      => B"00001_110_0011111",    -- LD F, 31
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
