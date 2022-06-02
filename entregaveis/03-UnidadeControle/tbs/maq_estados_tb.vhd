LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

entity maq_estados_tb is
    
end entity maq_estados_tb;

architecture a_maq_estados_tb of maq_estados_tb is
    component maq_estados is
        port
        (
            clk     : IN STD_LOGIC ;
            rst     : IN STD_LOGIC ;
            estado  : OUT STD_LOGIC
        );
    end component;
    
    constant period_time        : TIME := 100 ns;   -- escolha do período para o clock
    signal finished             : STD_LOGIC := '0';
    signal clk, rst, estado     : STD_LOGIC;
    
begin
    uut: maq_estados port map
    (
        clk     => clk,
        rst     => rst,
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