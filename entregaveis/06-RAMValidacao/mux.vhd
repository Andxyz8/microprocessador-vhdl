LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY mux IS
    PORT
    (
        slt     : IN STD_LOGIC;
        inA     : IN SIGNED(15 DOWNTO 0);
        inB     : IN SIGNED(15 DOWNTO 0);
        out_mux : OUT SIGNED(15 DOWNTO 0)
    );
    
END ENTITY mux;

ARCHITECTURE a_mux OF mux IS
BEGIN
    
    out_mux <=  inA WHEN slt = '0' ELSE
                inB WHEN slt = '1' ELSE
                "0000000000000000";

END ARCHITECTURE a_mux;