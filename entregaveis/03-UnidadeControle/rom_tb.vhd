library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity rom_tb is

end entity rom_tb;

architecture a_rom_tb of rom_tb is
    
    component rom is
        port
        (
            clk      : IN std_logic ;
            endereco : IN unsigned (6 downto 0);
            dado     : OUT unsigned (17 downto 0)
        );
    end component;
    
    signal endereco : unsigned(6 downto 0);
    signal dado     : unsigned (17 downto 0);
    constant period_time    : time := 100 ns;   --escolha do período para o clock
    signal finished         : std_logic := '0';
    signal clk, rst       : std_logic;
    
begin
    uut: rom port map
    (
        clk => clk,
        endereco => endereco,
        dado => dado
    );
    
    reset_global: process
    begin
        rst <= '1';
        wait for period_time*2;         -- espera 2 clocks, pra garantir
        rst <= '0';
        wait;
    end process;
    
    sim_time_proc: process
    begin
        wait for 1000 ns;               -- <== TEMPO TOTAL DA SIMULACAO!!!
        finished <= '1';
        wait;
    end process sim_time_proc;

    clk_proc: process
    begin                               -- gera clock até que sim_time_proc termine
        while finished /= '1' loop
            clk <= '0';
            wait for period_time/2;
            clk <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;
    
    
    process begin
        wait for 200 ns;
        
        endereco <= "0000000";
        wait for 100 ns;
        
        endereco <= "0000001";
        wait for 100 ns;
        
        endereco <= "0000010";
        wait for 100 ns;
        
        endereco <= "0000011";
        wait for 100 ns;
        
        endereco <= "0000111";
        wait for 100 ns;
        
        endereco <= "1000111";
        wait;
    end process;
end architecture a_rom_tb;