library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pc_main_tb is

end entity pc_main_tb;

architecture a_pc_main_tb of pc_main_tb is
    component pc_main is
        port
        (
            clk       : IN std_logic ;
            rst       : IN std_logic ;
            wr_en     : IN std_logic ;
            data_i    : IN unsigned (6 downto 0);
            data_o    : OUT unsigned (6 downto 0);
            top_level : OUT unsigned (17 downto 0)
        );
    end component;
    
    signal data_i, data_o: unsigned(6 downto 0);
    constant period_time : time := 100 ns;
    signal finished : std_logic := '0';
    signal clk, rst, wr_en : std_logic;
    signal top_level: unsigned(17 downto 0);
begin

    uut: pc_main port map
    (
        clk         => clk,
        rst         => rst,
        wr_en       => wr_en,
        data_i      => data_i,
        data_o      => data_o,
        top_level   => top_level
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
        wait for 2000 ns;               -- <== TEMPO TOTAL DA SIMULACAO!!!
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

    process
    begin
        wait for 200 ns;
        wr_en <='1';
        data_i <="0000111";
        wait for 200 ns;
        wr_en <='0';
        wait for 200 ns;
        wr_en <='1';
        wait;
    end process;
    
end architecture a_pc_main_tb;