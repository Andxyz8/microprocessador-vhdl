library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux is
    port
    (
        seletor     : IN STD_LOGIC;
        entrada_A   : IN UNSIGNED(15 DOWNTO 0);
        entrada_B   : IN UNSIGNED(15 DOWNTO 0);
        saida       : OUT UNSIGNED(15 DOWNTO 0)
    );
    
end entity mux;

architecture a_mux of mux is
begin
    
    saida <= entrada_A when seletor = '0' else
             entrada_B when seletor = '1' else
             "0000000000000000";
    

end architecture a_mux;