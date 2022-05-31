LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY proto_uc_tb IS
    
END ENTITY proto_uc_tb;

ARCHITECTURE a_proto_uc_tb OF proto_uc_tb IS
    COMPONENT proto_uc IS
        PORT
        (
            clk         : IN STD_LOGIC;
            rst         : IN STD_LOGIC;
            wr_en       : IN STD_LOGIC;
            data_tl     : OUT UNSIGNED (14 DOWNTO 0)
        );
    END COMPONENT;
    
    SIGNAL data_i, data_o   : UNSIGNED(6 DOWNTO 0);
    SIGNAL data_tl          : UNSIGNED(14 DOWNTO 0);
    CONSTANT period_time    : TIME := 100 ns;
    SIGNAL finished         : STD_LOGIC := '0';
    SIGNAL clk, rst, wr_en  : STD_LOGIC;
    
BEGIN
    uut: proto_uc PORT MAP
    (
        clk         => clk,
        rst         => rst,
        wr_en       => wr_en,
        data_tl     => data_tl
    );
    
    reset_global: PROCESS
    BEGIN
        rst <= '1';
        WAIT FOR period_time*2;         -- espera 2 clocks, pra garantir
        rst <= '0';
        WAIT;
    END PROCESS;
    
    sim_time_proc: PROCESS
    BEGIN
        WAIT FOR 2000 ns;               -- <== TEMPO TOTAL DA SIMULACAO!!!
        finished <= '1';
        WAIT;
    END PROCESS sim_time_proc;

    clk_proc: PROCESS
    BEGIN                               -- gera clock até que sim_time_proc termine
        WHILE finished /= '1' LOOP
            clk <= '0';
            WAIT FOR period_time/2;
            clk <= '1';
            WAIT FOR period_time/2;
        END LOOP;
        WAIT;
    END PROCESS clk_proc;
    
    PROCESS
    BEGIN
        WAIT FOR 200 ns;
        wr_en <= '1';
        
        wait;
    END PROCESS;
END ARCHITECTURE a_proto_uc_tb ;