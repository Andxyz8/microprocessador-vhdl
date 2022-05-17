library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity main_tb is
end entity main_tb;

architecture a_main_tb of main_tb is
    component main is
        port
        (
            wr_en            : IN STD_LOGIC ;
            clk              : IN STD_LOGIC ;
            rst              : IN STD_LOGIC ;
            ULAsrc           : IN STD_LOGIC ;
            top              : IN UNSIGNED (15 downto 0);
            debug            : OUT UNSIGNED (15 downto 0);
            select_reg_read1 : IN UNSIGNED (2 downto 0);
            select_reg_read2 : IN UNSIGNED (2 downto 0);
            select_reg_write : IN UNSIGNED (2 downto 0);
            seletor          : IN UNSIGNED (1 downto 0)
        );
    end component;
    
    constant period_time : TIME := 100 ns;
    signal finished : STD_LOGIC := '0';
    signal rst, clk : STD_LOGIC;
    signal ULAsrc, wr_en: STD_LOGIC:='0';
    signal top, debug: UNSIGNED(15 downto 0);
    signal select_reg_read1, select_reg_read2, select_reg_write: UNSIGNED(2 downto 0) := "000";
    signal seletor: UNSIGNED(1 downto 0) := "00";
begin
    
    uut: main
    port map
    (
        wr_en            => wr_en,
        clk              => clk,
        rst              => rst,
        ULAsrc           => ULAsrc,
        top              => top,
        debug            => debug,
        select_reg_read1 => select_reg_read1,
        select_reg_read2 => select_reg_read2,
        select_reg_write => select_reg_write,
        seletor          => seletor
    );

    reset_global: process
    begin
        rst <= '1';
        wait for period_time*2;
        rst <= '0';
        wait;
    end process;
    
    sim_time_proc: process
    begin
        wait for 2000 ns;
        finished <= '1';
        wait;
    end process sim_time_proc;

    clk_proc: process
    begin
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
        wr_en <= '1';
        ULAsrc <= '1';
        seletor <= "00";
        
        top <= "0000000000000101";
        select_reg_write <= "001";
        select_reg_read1 <= "000";
        
        wait for 100 ns;
        top <= "0000000000001101";
        select_reg_write <= "010";
        
        wait for 100 ns;
        ULAsrc <= '0';
        select_reg_read1 <= "001";
        select_reg_read2 <= "010";
        select_reg_write <= "011";
        
        wait for 100 ns;
        wr_en <= '0';
        wait;
    end process;
    

end architecture a_main_tb;