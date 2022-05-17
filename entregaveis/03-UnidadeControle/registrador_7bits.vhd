library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity registrador_7bits is
    port(
        clk        : in std_logic;
        rst        : in std_logic;
        wr_en      : in std_logic;
        data_i     : in unsigned(6 downto 0);
        data_o     : out unsigned(6 downto 0)
    );
end entity registrador_7bits;

architecture a_registrador_7bits of registrador_7bits is
    signal info : unsigned(6 downto 0);
    
begin
    process(clk, rst, wr_en)
    begin
        if rst = '1' then
            info <= "0000000";
        elsif wr_en = '1' then
            if rising_edge(clk) then
                info <= data_i;
            end if;
        end if;
    end process;
    
    data_o <= info;

end architecture a_registrador_7bits;