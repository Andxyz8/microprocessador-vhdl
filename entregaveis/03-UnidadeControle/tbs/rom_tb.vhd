LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;


ENTITY rom_tb IS

END ENTITY rom_tb;

ARCHITECTURE a_rom_tb of rom_tb is
    
    COMPONENT rom IS
        PORT
        (
            clk      : IN STD_LOGIC ;
            endereco : IN UNSIGNED (6 DOWNTO 0);
            dado     : OUT UNSIGNED (14 DOWNTO 0)
        );
    END COMPONENT;
    
    SIGNAL endereco : UNSIGNED(6 DOWNTO 0);
    SIGNAL dado     : UNSIGNED (14 DOWNTO 0);
    CONSTANT period_time    : TIME := 100 ns;   --escolha do período para o clock
    SIGNAL finished         : STD_LOGIC := '0';
    SIGNAL clk, rst       : STD_LOGIC;
    
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
    
    
    PROCESS BEGIN
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
    END PROCESS;
END ARCHITECTURE a_rom_tb;