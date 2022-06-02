LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

entity processador IS
    PORT
    (
        clk                 : IN STD_LOGIC;
        rst                 : IN STD_LOGIC;
        
        state_tl            : OUT UNSIGNED(1 DOWNTO 0);
        pc_tl               : OUT UNSIGNED(6 DOWNTO 0);
        
        reg1_out_tl         : OUT UNSIGNED(15 DOWNTO 0);
        reg2_out_tl         : OUT UNSIGNED(15 DOWNTO 0);
        ula_saida_num_tl    : OUT UNSIGNED(15 DOWNTO 0);
        instr_tl            : OUT UNSIGNED(14 DOWNTO 0)
    );
end entity processador;

architecture a_processador of processador IS
    component banco_registradores IS
        PORT
        (
            select_read1    : IN UNSIGNED(2 DOWNTO 0);
            select_read2    : IN UNSIGNED(2 DOWNTO 0);
            select_write    : IN UNSIGNED(2 DOWNTO 0);
            
            data_read1      : OUT UNSIGNED(15 DOWNTO 0);
            data_read2      : OUT UNSIGNED(15 DOWNTO 0);
            data_write      : IN UNSIGNED(15 DOWNTO 0);
            
            wr_en           : IN STD_LOGIC;
            clk             : IN STD_LOGIC;
            rst             : IN STD_LOGIC
        );
    end component;
    
    component ula IS
        PORT
        (
            inA         : IN UNSIGNED(15 DOWNTO 0);
            inB         : IN UNSIGNED(15 DOWNTO 0);
            seletor     : IN UNSIGNED(1 DOWNTO 0);
            saida_num   : OUT UNSIGNED(15 DOWNTO 0);
            saida_bool  : OUT STD_LOGIC
        );
    end component;
    
    component mux IS
        PORT
        (
            seletor   : IN STD_LOGIC;
            entrada_A : IN UNSIGNED (15 DOWNTO 0);
            entrada_B : IN UNSIGNED (15 DOWNTO 0);
            saida     : OUT UNSIGNED (15 DOWNTO 0)
        );
    end component;
    
    component maquina_estados is
        PORT
        (
            clk   : IN STD_LOGIC ;
            rst   : IN STD_LOGIC ;
            state : OUT UNSIGNED (1 DOWNTO 0)
        );
    end component;
    
    component program_counter is
        PORT
        (
            clk    : IN STD_LOGIC ;
            rst    : IN STD_LOGIC ;
            wr_en  : IN STD_LOGIC ;
            data_i : IN UNSIGNED (6 DOWNTO 0);
            data_o : OUT UNSIGNED (6 DOWNTO 0)
        );
    end component;
    
    component rom is
        PORT
        (
            clk     : IN STD_LOGIC ;
            read    : IN STD_LOGIC ;
            address : IN UNSIGNED (6 DOWNTO 0);
            data    : OUT UNSIGNED (14 DOWNTO 0)
        );
    end component;
    
    component unidade_controle is
        PORT
        (
            clk        : IN STD_LOGIC ;
            rst        : IN STD_LOGIC ;
            read_rom   : OUT STD_LOGIC ;
            wren_pc    : OUT STD_LOGIC ;
            di_pc      : OUT UNSIGNED (6 DOWNTO 0);
            do_pc      : IN UNSIGNED (6 DOWNTO 0);
            state      : IN UNSIGNED (1 DOWNTO 0);
            slt_ula    : OUT UNSIGNED (1 DOWNTO 0);
            srcB_ula   : OUT STD_LOGIC ;
            wr_reg     : OUT STD_LOGIC ;
            slt_reg1   : OUT UNSIGNED (2 DOWNTO 0);
            slt_reg2   : OUT UNSIGNED (2 DOWNTO 0);
            slt_wr_reg : OUT UNSIGNED (2 DOWNTO 0);
            instr      : IN UNSIGNED (14 DOWNTO 0)
        );
    end component;

    SIGNAL state_s, slt_ula_s                                           : UNSIGNED(1 DOWNTO 0);
    SIGNAL wren_pc_s, read_rom_s, wr_reg_s, ula_saida_bool_s, ula_srcB_s  : STD_LOGIC;
    SIGNAL pc_data_i_s, pc_data_o_s                                     : UNSIGNED(6 DOWNTO 0);
    SIGNAL select_read1_s, select_read2_s, select_write_s               : UNSIGNED(2 DOWNTO 0);
    SIGNAL data_read1_s, data_read2_s, ula_saida_num_s, mux_saida_s     : UNSIGNED(15 DOWNTO 0);
    SIGNAL instr_s                                                      : UNSIGNED(14 DOWNTO 0);
    SIGNAL const                                                        : UNSIGNED(15 DOWNTO 0);
    
BEGIN
    
    proc_banco_registradores: banco_registradores
    PORT MAP
    (
        select_read1 => select_read1_s,
        select_read2 => select_read2_s,
        select_write => select_write_s,
        
        data_read1 => data_read1_s,
        data_read2 => data_read2_s,
        data_write => ula_saida_num_s,
        
        wr_en => wr_reg_s,
        clk => clk,
        rst => rst
    );
    

    proc_ula: ula
    PORT MAP
    (
        inA => data_read1_s,
        inB => mux_saida_s,
        
        seletor => slt_ula_s,

        saida_num => ula_saida_num_s,
        saida_bool => ula_saida_bool_s
    );

    proc_mux: mux
    PORT MAP
    (
        seletor   => ula_srcB_s,
        entrada_A => data_read2_s,
        entrada_B => const,
        saida     => mux_saida_s
    );
    
    proc_maq_est: maquina_estados
    PORT MAP
    (
        clk   => clk,
        rst   => rst,
        state => state_s
    );
    
    proc_prog_count: program_counter
    PORT MAP
    (
        clk    => clk,
        rst    => rst,
        wr_en  => wren_pc_s,
        data_i => pc_data_i_s,
        data_o => pc_data_o_s
    );
    
    proc_rom: rom
    PORT MAP
    (
        clk     => clk,
        read    => read_rom_s,
        address => pc_data_o_s,
        data    => instr_s
    );
    
    proc_uc: unidade_controle
    PORT MAP
    (
        clk        => clk,
        rst        => rst,
        read_rom   => read_rom_s,
        wren_pc    => wren_pc_s,
        di_pc      => pc_data_i_s,
        do_pc      => pc_data_o_s,
        state      => state_s,
        slt_ula    => slt_ula_s,
        srcB_ula   => ula_srcB_s,
        wr_reg     => wr_reg_s,
        slt_reg1   => select_read1_s,
        slt_reg2   => select_read2_s,
        slt_wr_reg => select_write_s,
        instr      => instr_s
    );
    
    const <= "0000000000" & instr_s(5 DOWNTO 0);
    
    state_tl            <= state_s;
    pc_tl               <= pc_data_o_s;
    reg1_out_tl         <= data_read1_s;
    reg2_out_tl         <= data_read2_s;
    ula_saida_num_tl    <= ula_saida_num_s;
    instr_tl            <= instr_s;
    
end architecture a_processador;



