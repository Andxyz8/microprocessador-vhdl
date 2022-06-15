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
        0       => B"00001_001_0000000",    -- LD A, 0
        1       => B"00011_001_0000000",    -- LD (0x0), A
        10      => B"00001_011_0001010",    -- LD C, 10
        15      => B"00011_011_0001010",    -- LD (0xA), C
        25      => B"00001_010_0011001",    -- LD B, 25
        30      => B"00011_010_0011001",    -- LD (0x19), B
        45      => B"00001_111_0100101",    -- LD H, 37
        77      => B"00011_111_0100101",    -- LD (0x25), H
        100     => B"00100_100_0001010",    -- LD D, (0xA)
        101     => B"00100_101_0100101",    -- LD E, (0x25)
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
