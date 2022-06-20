LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY mux2x1 IS
    PORT
    (
        slt     : IN STD_LOGIC;
        inA     : IN SIGNED(15 DOWNTO 0);   -- data_reg1
        inB     : IN SIGNED(15 DOWNTO 0);   -- zero
        out_mux : OUT SIGNED(15 DOWNTO 0)
    );
    
END ENTITY mux2x1;

ARCHITECTURE a_mux2x1 OF mux2x1 IS
BEGIN
    
    out_mux <=  inA WHEN slt = '0' ELSE
                inB WHEN slt = '1' ELSE
                "0000000000000000";

END ARCHITECTURE a_mux2x1;