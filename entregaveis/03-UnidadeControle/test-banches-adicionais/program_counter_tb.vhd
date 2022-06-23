library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity registrador_7bits_tb is
    
end entity registrador_7bits_tb;

architecture a_registrador_7bits_tb of registrador_7bits_tb is
    
    component registrador_7bits is
        port
        (
            clk      : IN std_logic ;
            rst      : IN std_logic ;
            wr_en    : IN std_logic ;
            data_i   : IN unsigned (6 downto 0);
            data_o   : OUT unsigned (6 downto 0)
        );
    end component;
    
    signal data_i           : unsigned (6 downto 0);
    signal data_o           : unsigned (6 downto 0);
    constant period_time    : time := 100 ns;   --escolha do período para o clock
    signal finished         : std_logic := '0';
    signal wr_en, clk, rst  : std_logic;
    
begin

    uut: registrador_7bits port map
    (
        clk => clk,
        rst => rst,
        wr_en => wr_en,
        data_i => data_i,
        data_o => data_o
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
        wait for 100 ns;
        wr_en <= '1';
        data_i <= "0000001";
        
        wait for 100 ns;
        wr_en <= '1';
        data_i <= "0011111";
        
        wait;
    end process;
    
    
end architecture a_registrador_7bits_tb;