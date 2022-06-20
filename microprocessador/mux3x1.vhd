LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY mux3x1 IS
    PORT
    (
        slt     : IN UNSIGNED(1 DOWNTO 0);
        inA     : IN SIGNED(15 DOWNTO 0);   -- data_reg2
        inB     : IN SIGNED(15 DOWNTO 0);   -- cte
        inC     : IN SIGNED(15 DOWNTO 0);   -- out_ram
        out_mux : OUT SIGNED(15 DOWNTO 0)
    );
    
END ENTITY mux3x1;

ARCHITECTURE a_mux3x1 OF mux3x1 IS
BEGIN
    
    out_mux <=  inA WHEN slt = "00" ELSE
                inB WHEN slt = "01" ELSE
                inC WHEN slt = "10" ELSE
                "0000000000000000";

END ARCHITECTURE a_mux3x1;