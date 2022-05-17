library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity maq_estados_tb is
    
end entity maq_estados_tb;

architecture a_maq_estados_tb of maq_estados_tb is
    component maq_estados is
        port
        (
            clk    : IN std_logic ;
            rst  : IN std_logic ;
            estado : OUT std_logic
        );
    end component;
    
    constant period_time        : time := 100 ns;   -- escolha do período para o clock
    signal finished             : std_logic := '0';
    signal clk, rst, estado   : std_logic;
    
begin
    uut: maq_estados port map
    (
        clk     => clk,
        rst   => rst,
        estado  => estado
    );
    
    reset_global: process
    begin
        rst <= '1';
        wait for period_time*2; -- espera 2 clocks, pra garantir
        rst <= '0';
        wait;
    end process;
    
    sim_time_proc: process
    begin
        wait for 1000 ns;       -- TEMPO TOTAL DA SIMULACAO
        finished <= '1';
        wait;
    end process sim_time_proc;

    clk_proc: process
    begin                       -- gera clock ate que sim_time_proc termine
        while finished /= '1' loop
            clk <= '0';
            wait for period_time/2;
            clk <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;
    
    process begin
        
        wait;
    end process;
    

end architecture a_maq_estados_tb;