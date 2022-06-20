LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY processador IS
    PORT
    (
        clk                 : IN STD_LOGIC;
        rst                 : IN STD_LOGIC;
        state_tl            : OUT UNSIGNED(1 DOWNTO 0);
        pc_tl               : OUT UNSIGNED(6 DOWNTO 0);
        reg1_out_tl         : OUT SIGNED(15 DOWNTO 0);
        reg2_out_tl         : OUT SIGNED(15 DOWNTO 0);
        ula_out_num_tl      : OUT SIGNED(15 DOWNTO 0);
        ula_out_bool_tl     : OUT STD_LOGIC;
        primos_tl           : OUT SIGNED(15 DOWNTO 0) := "0000000000000000";
        instr_tl            : OUT UNSIGNED(14 DOWNTO 0)
    );
END ENTITY processador;

ARCHITECTURE a_processador of processador IS
    COMPONENT banco_registradores IS
        PORT
        (
            select_read1    : IN UNSIGNED(2 DOWNTO 0);
            select_read2    : IN UNSIGNED(2 DOWNTO 0);
            select_write    : IN UNSIGNED(2 DOWNTO 0);
            
            data_read1      : OUT SIGNED(15 DOWNTO 0);
            data_read2      : OUT SIGNED(15 DOWNTO 0);
            data_write      : IN SIGNED(15 DOWNTO 0);
            
            wr_en           : IN STD_LOGIC;
            clk             : IN STD_LOGIC;
            rst             : IN STD_LOGIC
        );
    END COMPONENT;
    
    COMPONENT ula IS
        PORT
        (
            inA            : IN SIGNED (15 DOWNTO 0);
            inB            : IN SIGNED (15 DOWNTO 0);
            slt_op         : IN UNSIGNED (1 DOWNTO 0);
            out_num        : OUT SIGNED (15 DOWNTO 0);
            out_bool       : OUT STD_LOGIC
        );
    END COMPONENT;

    COMPONENT mux2x1 IS
        PORT
        (
            slt     : IN STD_LOGIC;
            inA     : IN SIGNED (15 DOWNTO 0);
            inB     : IN SIGNED (15 DOWNTO 0);
            out_mux : OUT SIGNED (15 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT mux3x1 IS
        PORT
        (
            slt     : IN UNSIGNED(1 DOWNTO 0) ;
            inA     : IN SIGNED (15 DOWNTO 0);
            inB     : IN SIGNED (15 DOWNTO 0);
            inC     : IN SIGNED (15 DOWNTO 0);
            out_mux : OUT SIGNED (15 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT maquina_estados is
        PORT
        (
            clk   : IN STD_LOGIC ;
            rst   : IN STD_LOGIC ;
            state : OUT UNSIGNED (1 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT program_counter IS
        PORT
        (
            clk     : IN STD_LOGIC ;
            rst     : IN STD_LOGIC ;
            wr_en   : IN STD_LOGIC ;
            din     : IN UNSIGNED (6 DOWNTO 0);
            dout    : OUT UNSIGNED (6 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT rom IS
        PORT
        (
            clk     : IN STD_LOGIC ;
            read    : IN STD_LOGIC ;
            address : IN UNSIGNED (6 DOWNTO 0);
            data    : OUT UNSIGNED (14 DOWNTO 0)
        );
    END COMPONENT;
    
    COMPONENT ram IS
        PORT
        (
            clk      : IN STD_LOGIC ;
            wr_en    : IN STD_LOGIC ;
            address  : IN UNSIGNED (6 DOWNTO 0);
            data_in  : IN SIGNED (15 DOWNTO 0);
            data_out : OUT SIGNED (15 DOWNTO 0)
        );
    END COMPONENT ram;
    
    COMPONENT unidade_controle IS
        PORT
        (
            clk            : IN STD_LOGIC ;
            rst            : IN STD_LOGIC ;
            read_rom       : OUT STD_LOGIC ;
            wren_ram       : OUT STD_LOGIC ;
            wren_pc        : OUT STD_LOGIC ;
            di_pc          : OUT UNSIGNED (6 DOWNTO 0);
            do_pc          : IN UNSIGNED (6 DOWNTO 0);
            state          : IN UNSIGNED (1 DOWNTO 0);
            slt_op_ula     : OUT UNSIGNED (1 DOWNTO 0);
            out_bool_ula   : IN STD_LOGIC ;
            srcA_ula       : OUT STD_LOGIC ;
            srcB_ula       : OUT UNSIGNED (1 DOWNTO 0);
            wr_reg         : OUT STD_LOGIC ;
            slt_reg1       : OUT UNSIGNED (2 DOWNTO 0);
            slt_reg2       : OUT UNSIGNED (2 DOWNTO 0);
            slt_wr_reg     : OUT UNSIGNED (2 DOWNTO 0);
            instr          : IN UNSIGNED (14 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL pc_wren_s        : STD_LOGIC;
    SIGNAL read_rom_s       : STD_LOGIC;
    SIGNAL wr_reg_s         : STD_LOGIC;
    SIGNAL ula_out_bool_s   : STD_LOGIC;
    SIGNAL ula_srcA_s       : STD_LOGIC;
    SIGNAL ula_srcB_s       : UNSIGNED(1 DOWNTO 0);
    SIGNAL state_s          : UNSIGNED(1 DOWNTO 0);
    SIGNAL slt_op_ula_s     : UNSIGNED(1 DOWNTO 0);
    SIGNAL select_read1_s   : UNSIGNED(2 DOWNTO 0);
    SIGNAL select_read2_s   : UNSIGNED(2 DOWNTO 0);
    SIGNAL select_write_s   : UNSIGNED(2 DOWNTO 0);
    SIGNAL pc_din_s         : UNSIGNED(6 DOWNTO 0);
    SIGNAL pc_dout_s        : UNSIGNED(6 DOWNTO 0);
    SIGNAL instr_s          : UNSIGNED(14 DOWNTO 0);
    SIGNAL data_read1_s     : SIGNED(15 DOWNTO 0);
    SIGNAL data_read2_s     : SIGNED(15 DOWNTO 0);
    SIGNAL ula_out_num_s    : SIGNED(15 DOWNTO 0);
    SIGNAL const            : SIGNED(15 DOWNTO 0);
    SIGNAL muxA_out_s       : SIGNED(15 DOWNTO 0);
    SIGNAL muxB_out_s       : SIGNED(15 DOWNTO 0);
    SIGNAL ram_wren_s       : STD_LOGIC;
    SIGNAL ram_address_s    : UNSIGNED(6 DOWNTO 0);
    SIGNAL ram_dout_s       : SIGNED(15 DOWNTO 0);

BEGIN
    
    proc_banco_registradores: banco_registradores
    PORT MAP
    (
        select_read1 => select_read1_s,
        select_read2 => select_read2_s,
        select_write => select_write_s,
        
        data_read1  => data_read1_s,
        data_read2  => data_read2_s,
        data_write  => ula_out_num_s,
        
        wr_en       => wr_reg_s,
        clk         => clk,
        rst         => rst
    );
    

    proc_ula: ula
    PORT MAP
    (
        inA         => muxA_out_s,
        inB         => muxB_out_s,
        
        slt_op      => slt_op_ula_s,

        out_num     => ula_out_num_s,
        out_bool    => ula_out_bool_s
    );

    proc_muxA: mux2x1
    PORT MAP
    (
        slt     => ula_srcA_s,
        inA     => data_read1_s,
        inB     => "0000000000000000",
        out_mux => muxA_out_s
    );
    
    proc_muxB: mux3x1
    PORT MAP
    (
        slt     => ula_srcB_s,
        inA     => data_read2_s,
        inB     => const,
        inC     => ram_dout_s,
        out_mux => muxB_out_s
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
        clk     => clk,
        rst     => rst,
        wr_en   => pc_wren_s,
        din     => pc_din_s,
        dout    => pc_dout_s
    );
    
    proc_rom: rom
    PORT MAP
    (
        clk     => clk,
        read    => read_rom_s,
        address => pc_dout_s,
        data    => instr_s
    );
    
    proc_ram: ram
    PORT MAP
    (
        clk      => clk,
        wr_en    => ram_wren_s,
        address  => ram_address_s,
        data_in  => ula_out_num_s,
        data_out => ram_dout_s
    );

    proc_uc: unidade_controle
    PORT MAP
    (
        clk             => clk,
        rst             => rst,
        read_rom        => read_rom_s,
        wren_ram        => ram_wren_s,
        wren_pc         => pc_wren_s,
        di_pc           => pc_din_s,
        do_pc           => pc_dout_s,
        state           => state_s,
        slt_op_ula      => slt_op_ula_s,
        out_bool_ula    => ula_out_bool_s,
        srcA_ula        => ula_srcA_s,
        srcB_ula        => ula_srcB_s,
        wr_reg          => wr_reg_s,
        slt_reg1        => select_read1_s,
        slt_reg2        => select_read2_s,
        slt_wr_reg      => select_write_s,
        instr           => instr_s
    );

    const           <=  SIGNED("000000000" & instr_s(6 DOWNTO 0));
    ram_address_s   <=  instr_s(6 DOWNTO 0) WHEN instr_s(14 DOWNTO 10) = "00011" ELSE
                        UNSIGNED(data_read1_s(6 DOWNTO 0)) WHEN instr_s(14 DOWNTO 10) = "01101" ELSE
                        UNSIGNED(data_read2_s(6 DOWNTO 0)) WHEN instr_s(14 DOWNTO 10) = "01110";

    state_tl        <= state_s;
    pc_tl           <= pc_dout_s;
    reg1_out_tl     <= data_read1_s;
    reg2_out_tl     <= data_read2_s;
    ula_out_num_tl  <= ula_out_num_s;
    ula_out_bool_tl <= ula_out_bool_s;
    instr_tl        <= instr_s;
    primos_tl       <= ram_dout_s WHEN select_write_s = "111";
    
END ARCHITECTURE a_processador;



