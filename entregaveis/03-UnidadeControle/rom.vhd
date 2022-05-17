library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rom is
    port
    (
        clk : in std_logic;
        endereco : in unsigned (6 downto 0);
        dado : out unsigned (17 downto 0)
    );
end entity;

architecture a_rom of rom is
    type mem is array (0 to 127) of unsigned(17 downto 0);
    constant conteudo_rom : mem := (
        0   => "000000000000000000",
        1   => "000000000000000001",
        2   => "000000000000000010",
        3   => "000000000000000011",
        4   => "000000000000000100",
        5   => "000000000000000101",
        6   => "000000000000000110",
        7   => "000000000000000111",
        8   => "000000000000001000",
        9   => "000000000000001001",
        10   => "000000000000001010",
        others => (others => '0')
    );
    
begin
    process(clk) begin
        if(rising_edge(clk)) then
            dado <= conteudo_rom(to_integer(endereco));
        end if;
    end process;

end architecture a_rom;
