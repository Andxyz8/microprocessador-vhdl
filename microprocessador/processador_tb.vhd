LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY processador_tb IS
    
END ENTITY processador_tb;

ARCHITECTURE a_processador_tb OF processador_tb IS
    COMPONENT processador IS
        PORT
        (
            clk              : IN STD_LOGIC ;
            rst              : IN STD_LOGIC ;
            state_tl         : OUT UNSIGNED (1 DOWNTO 0);
            pc_tl            : OUT UNSIGNED (6 DOWNTO 0);
            reg1_out_tl      : OUT SIGNED (15 DOWNTO 0);
            reg2_out_tl      : OUT SIGNED (15 DOWNTO 0);
            ula_out_num_tl   : OUT SIGNED (15 DOWNTO 0);
            ula_out_bool_tl  : OUT STD_LOGIC;
            primos_tl        : OUT SIGNED(15 DOWNTO 0);
            instr_tl         : OUT UNSIGNED (14 DOWNTO 0)
        );
    END COMPONENT processador;
    
    CONSTANT period_time    : TIME := 100 ns;
    SIGNAL finished         : STD_LOGIC := '0';
    SIGNAL clk, rst         : STD_LOGIC;
    SIGNAL ula_out_bool_tl  : STD_LOGIC;
    SIGNAL state_tl         : UNSIGNED (1 DOWNTO 0);
    SIGNAL pc_tl            : UNSIGNED (6 DOWNTO 0);
    SIGNAL reg1_out_tl      : SIGNED (15 DOWNTO 0);
    SIGNAL reg2_out_tl      : SIGNED (15 DOWNTO 0);
    SIGNAL ula_out_num_tl   : SIGNED (15 DOWNTO 0);
    SIGNAL primos_tl        : SIGNED(15 DOWNTO 0);
    SIGNAL instr_tl         : UNSIGNED (14 DOWNTO 0);

    
BEGIN
    uut: processador
    PORT MAP
    (
        clk              => clk,
        rst              => rst,
        state_tl         => state_tl,
        pc_tl            => pc_tl,
        reg1_out_tl      => reg1_out_tl,
        reg2_out_tl      => reg2_out_tl,
        ula_out_num_tl   => ula_out_num_tl,
        ula_out_bool_tl  => ula_out_bool_tl,
        primos_tl        => primos_tl,
        instr_tl         => instr_tl
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
        WAIT FOR 150 us;               -- <== TEMPO TOTAL DA SIMULACAO!!!
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
    
    
END ARCHITECTURE a_processador_tb;