LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;


ENTITY proto_uc IS
    PORT
    (
        clk         : IN STD_LOGIC;
        rst         : IN STD_LOGIC;
        wr_en       : IN STD_LOGIC;
        data_tl     : OUT UNSIGNED (14 DOWNTO 0)
    );
END ENTITY proto_uc;

ARCHITECTURE a_proto_uc OF proto_uc IS
    COMPONENT program_counter IS
        PORT
        (
            clk    : IN STD_LOGIC;
            rst    : IN STD_LOGIC;
            wr_en  : IN STD_LOGIC;
            data_i : IN UNSIGNED (6 DOWNTO 0);
            data_o : OUT UNSIGNED (6 DOWNTO 0)
        );
    END COMPONENT program_counter;
    
    COMPONENT rom IS
        PORT
        (
            clk     : IN STD_LOGIC;
            address : IN UNSIGNED (6 DOWNTO 0);
            data    : OUT UNSIGNED (14 DOWNTO 0)
        );
    END COMPONENT rom;
    
    COMPONENT maq_estados IS
        PORT
        (
            clk     : IN STD_LOGIC;
            rst     : IN STD_LOGIC;
            state   : OUT STD_LOGIC
        );
    END COMPONENT maq_estados;
    
    SIGNAL pc_i, address    : UNSIGNED(6 DOWNTO 0);
    SIGNAL data             : UNSIGNED(14 DOWNTO 0);
    SIGNAL state            : STD_LOGIC;
    
BEGIN
    PC: program_counter PORT MAP
    (
        clk => clk,
        rst => rst,
        wr_en   => wr_en,
        data_i  => pc_i,
        data_o  => address
    );
    
    ROM1: rom PORT MAP
    (
        clk => clk,
        address => address,
        data => data_tl
    );
    
    MAQEST: maq_estados PORT MAP
    (
        clk => clk,
        rst => rst,
        state => state
    );
    
    
    pc_i <= address + 1 WHEN state = '1' AND wr_en = '1' AND RISING_EDGE(clk)
                        ELSE address + 1;
    
    
END ARCHITECTURE a_proto_uc;