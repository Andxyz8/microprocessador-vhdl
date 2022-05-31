library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity pc_main is
    
    port(
        clk             : in std_logic;
        rst             : in std_logic;
        wr_en           : in std_logic;
        data_i          : in unsigned (6 downto 0);
        data_o          : out unsigned (6 downto 0);
        top_level       : out unsigned (17 downto 0)
    );

end entity pc_main;

architecture a_pc_main of pc_main is
    component rom is
        port
        (
            clk      : IN std_logic ;
            endereco : IN unsigned (6 downto 0);
            dado     : OUT unsigned (17 downto 0)
        );
    end component;
    
    component maq_estados is
        port
        (
            clk    : IN std_logic ;
            rst    : IN std_logic ;
            estado : OUT std_logic
        );
    end component;
    
    component registrador_7bits is
        port
        (
            clk     : IN std_logic ;
            rst     : IN std_logic ;
            wr_en   : IN std_logic ;
            data_i  : IN unsigned (6 downto 0);
            data_o  : OUT unsigned (6 downto 0)
        );
    end component;
    
    signal saida            : unsigned(6 downto 0);
    signal endereco         : unsigned (6 downto 0);
    signal dado             : unsigned (17 downto 0);
    signal operation_code   : unsigned (3 downto 0);
    signal estado_s         : std_logic;
    signal jump             : std_logic;
    
begin
    
    ROM1: rom port map
    (
        clk=>clk,
        endereco => endereco,
        dado => dado
    );

    MAQEST: maq_estados port map
    (
        clk     => clk,
        rst     => rst,
        estado  => estado_s
    );
    
    PC: registrador_7bits port map
    (
        clk     => clk,
        rst     => rst,
        wr_en   => wr_en,
        data_i  => data_i,
        data_o  => data_o
    );
    
    saida <=    dado(6 downto 0) when jump = '1' and wr_en = '1' and rising_edge(clk) and estado_s = '1'
                else
                    saida + 1 when wr_en = '1' and rising_edge(clk) and estado_s = '1'
                else
                    saida;

    top_level <=    dado
                    when
                        estado_s = '0'
                    else
                        "000000000000000000";
    
    operation_code <=   dado(17 downto 14)
                        when
                            estado_s = '1'
                        else
                            "0000";

    jump <= '1'
                when
                    operation_code = "1111"
                else
                    '0';
                    
end architecture a_pc_main;