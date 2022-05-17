library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity main is
    port(
        wr_en               : in STD_LOGIC;
        clk                 : in STD_LOGIC;
        rst                 : in STD_LOGIC;
        ULAsrc              : in STD_LOGIC;
        
        top                 : in UNSIGNED(15 downto 0);
        debug               : out UNSIGNED(15 downto 0);
        select_reg_read1    : in unsigned(2 downto 0);
        select_reg_read2    : in unsigned(2 downto 0);
        select_reg_write    : in unsigned(2 downto 0);
        
        seletor             : in unsigned (1 downto 0)
    );
end entity;

architecture a_main of main is
    component banco_registradores is
        port(
            select_read1    : in unsigned(2 downto 0);
            select_read2    : in unsigned(2 downto 0);
            select_write    : in unsigned(2 downto 0);
            
            data_read1      : out unsigned(15 downto 0);
            data_read2      : out unsigned(15 downto 0);
            data_write      : in unsigned(15 downto 0);
            
            wr_en           : in STD_LOGIC;
            clk             : in STD_LOGIC;
            rst             : in STD_LOGIC
        );
    end component;
    
    component ula is
        port(
            inA         : in unsigned(15 downto 0);
            inB         : in unsigned(15 downto 0);
            seletor     : in unsigned(1 downto 0);
            saida_num   : out unsigned(15 downto 0);
            saida_bool  : out STD_LOGIC
        );
    end component;
    
    component mux is
        port
        (
            seletor   : IN STD_LOGIC;
            entrada_A : IN UNSIGNED (15 DOWNTO 0);
            entrada_B : IN UNSIGNED (15 DOWNTO 0);
            saida     : OUT UNSIGNED (15 DOWNTO 0)
        );
    end component;
    

    signal main_data_reg_read1  : unsigned (15 downto 0);
    signal main_data_reg_read2  : unsigned (15 downto 0);
    signal main_saida_ula_bool  : STD_LOGIC;
    signal main_saida_ula_num   : unsigned (15 downto 0);
    signal main_saida_mux       : unsigned (15 downto 0);
    
begin
    
    main_banco_registradores: banco_registradores
    port map
    (
        select_read1 => select_reg_read1,
        select_read2 => select_reg_read2,
        select_write => select_reg_write,
        
        data_read1 => main_data_reg_read1,
        data_read2 => main_data_reg_read2,
        data_write => main_saida_ula_num,
        
        wr_en => wr_en,
        clk => clk,
        rst => rst
    );
    

    main_ula: ula
    port map
    (
        inA => main_data_reg_read1,
        inB => main_saida_mux,
        
        seletor => seletor,

        saida_num => main_saida_ula_num,
        saida_bool => main_saida_ula_bool
    );

    main_mux: mux
    port map
    (
        seletor   => ULAsrc,
        entrada_A => main_data_reg_read2,
        entrada_B => top,
        saida     => main_saida_mux
    );
    
    debug <= main_saida_ula_num;
    
end architecture;



