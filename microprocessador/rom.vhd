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
        1       => B"00001_001_0000001",    -- LD A, 1
        2       => B"00001_010_0000000",    -- LD B, 0
        3       => B"00010_010_001_0000",   -- LD B, A
        4       => B"01101_001_010_0000",   -- LD (A), B
        5       => B"00101_001_0000001",    -- ADD A, 1
        6       => B"01011_001_0100001",    -- SBC A, 33
        7       => B"11111_000_1111011",    -- JR M, 5
        8       => B"00001_011_0000010",    -- LD C, 2
        9       => B"00101_011_0000010",    -- ADD C, 2
        10      => B"01101_011_000_0000",   -- LD (C), L
        11      => B"01100_011_0100001",    -- SBC C, 33
        12      => B"11111_000_1111100",    -- JR M, 4
        13      => B"00001_100_0000011",    -- LD D, 3
        14      => B"00101_100_0000011",    -- ADD D, 3
        15      => B"01101_100_000_0000",   -- LD (D), L
        16      => B"01100_100_0100001",    -- SBC D, 33
        17      => B"11111_000_1111100",    -- JR M, 4
        18      => B"00001_101_0000101",    -- LD E, 5
        19      => B"00101_101_0000101",    -- ADD E, 5
        20      => B"01101_101_000_0000",   -- LD (E), L
        21      => B"01100_101_0100001",    -- SBC E, 33
        22      => B"11111_000_1111100",    -- JR M, 4
        23      => B"00001_110_0000010",    -- LD F, 2
        24      => B"01110_111_110_0000",   -- LD H, (F)
        25      => B"00101_110_0000001",    -- ADD F, 1
        26      => B"01100_110_0100001",    -- SBC F, 33
        27      => B"11111_000_1111100",    -- JR M, 3
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
