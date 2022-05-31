LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY rom IS
    PORT
    (
        clk     : IN STD_LOGIC;
        address : IN UNSIGNED (6 DOWNTO 0); -- Verificar a quantidade exata depois
        data    : OUT UNSIGNED (14 DOWNTO 0)
    );
END ENTITY;

ARCHITECTURE a_rom OF rom IS
    TYPE mem IS ARRAY (0 TO 127) OF UNSIGNED(14 DOWNTO 0);
    CONSTANT conteudo_rom : mem := (
        0       => "000000000000000",
        1       => "000000011000001",
        2       => "001000000001010",
        3       => "000000001100011",
        4       => "000000000000100",
        5       => "000000000100101",
        6       => "000000000000110",
        7       => "000000011000111",
        8       => "000111111101000",
        9       => "001100000001001",
        10      => "001111000001010",
        71      => "000111001000111",
        OTHERS  => (OTHERS => '0')
    );
    
BEGIN
    PROCESS(clk) BEGIN
        IF(rising_edge(clk)) THEN
            data <= conteudo_rom(TO_INTEGER(address));
        END IF;
    END PROCESS;

END ARCHITECTURE a_rom;
