LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY ram IS
    PORT
    (
        clk         : IN STD_LOGIC;
        wr_en       : IN STD_LOGIC;
        address     : IN UNSIGNED (6 DOWNTO 0);
        data_in     : IN SIGNED (15 DOWNTO 0);
        data_out    : OUT SIGNED (15 DOWNTO 0)
    );
END ENTITY ram;

ARCHITECTURE a_ram of ram is
    TYPE mem IS ARRAY (0 TO 127) OF SIGNED(15 DOWNTO 0);
    SIGNAL ram_info : mem;

BEGIN
    
    PROCESS(clk, wr_en)
    BEGIN
        IF (RISING_EDGE(clk)) THEN
            IF wr_en = '1' THEN
                ram_info(TO_INTEGER(address)) <= data_in;
            END IF;
        END IF;
END PROCESS;

data_out <= ram_info(TO_INTEGER(address));

END ARCHITECTURE a_ram;
