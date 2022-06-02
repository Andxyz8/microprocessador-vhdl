LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY mux IS
    PORT
    (
        seletor     : IN STD_LOGIC;
        entrada_A   : IN UNSIGNED(15 DOWNTO 0);
        entrada_B   : IN UNSIGNED(15 DOWNTO 0);
        saida       : OUT UNSIGNED(15 DOWNTO 0)
    );
    
END ENTITY mux;

ARCHITECTURE a_mux OF mux IS
BEGIN
    
    saida <= entrada_A WHEN seletor = '0' ELSE
             entrada_B WHEN seletor = '1' ELSE
             "0000000000000000";
    

END ARCHITECTURE a_mux;