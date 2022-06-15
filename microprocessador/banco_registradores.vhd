LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY banco_registradores is
    port(
        wr_en           : IN STD_LOGIC;
        clk             : IN STD_LOGIC;
        rst             : IN STD_LOGIC;
        
        select_read1    : IN UNSIGNED(2 DOWNTO 0);
        select_read2    : IN UNSIGNED(2 DOWNTO 0);
        select_write    : IN UNSIGNED(2 DOWNTO 0);
        
        data_write      : IN SIGNED(15 DOWNTO 0);
        data_read1      : OUT SIGNED(15 DOWNTO 0);
        data_read2      : OUT SIGNED(15 DOWNTO 0)
    );
END ENTITY banco_registradores;

ARCHITECTURE a_banco_registradores OF banco_registradores IS
    COMPONENT registrador_16bits IS
        PORT(
            clk         : IN STD_LOGIC;
            rst         : IN STD_LOGIC;
            wr_en       : IN STD_LOGIC;
            data_in     : IN SIGNED (15 DOWNTO 0);
            data_out    : OUT SIGNED (15 DOWNTO 0)
        );
    END COMPONENT;
    
    CONSTANT write_enable_L : STD_LOGIC:='0';
    SIGNAL write_enable_A   : STD_LOGIC := '0';
    SIGNAL write_enable_B   : STD_LOGIC := '0';
    SIGNAL write_enable_C   : STD_LOGIC := '0';
    SIGNAL write_enable_D   : STD_LOGIC := '0';
    SIGNAL write_enable_E   : STD_LOGIC := '0';
    SIGNAL write_enable_F   : STD_LOGIC := '0';
    SIGNAL write_enable_H   : STD_LOGIC := '0';
    SIGNAL data_out_A       : SIGNED(15 DOWNTO 0);
    SIGNAL data_out_B       : SIGNED(15 DOWNTO 0);
    SIGNAL data_out_C       : SIGNED(15 DOWNTO 0);
    SIGNAL data_out_D       : SIGNED(15 DOWNTO 0);
    SIGNAL data_out_E       : SIGNED(15 DOWNTO 0);
    SIGNAL data_out_F       : SIGNED(15 DOWNTO 0);
    SIGNAL data_out_H       : SIGNED(15 DOWNTO 0);
    SIGNAL data_out_L       : SIGNED(15 DOWNTO 0);
    
    
BEGIN
    
    L: registrador_16bits
    PORT MAP 
    (
        clk         => clk,
        rst         => rst,
        wr_en       => write_enable_L,
        data_in     => data_write,
        data_out    => data_out_L
    );

    A: registrador_16bits
    PORT MAP 
    (
        clk         => clk,
        rst         => rst,
        wr_en       => write_enable_A,
        data_in     => data_write,
        data_out    => data_out_A
    );

    B: registrador_16bits
    PORT MAP 
    (
        clk         => clk,
        rst         => rst,
        wr_en       => write_enable_B,
        data_in     => data_write,
        data_out    => data_out_B
    );

    C: registrador_16bits
    PORT MAP 
    (
        clk         => clk,
        rst         => rst,
        wr_en       => write_enable_C,
        data_in     => data_write,
        data_out    => data_out_C
    );

    D: registrador_16bits
    PORT MAP 
    (
        clk         => clk,
        rst         => rst,
        wr_en       => write_enable_D,
        data_in     => data_write,
        data_out    => data_out_D
    );

    E: registrador_16bits
    PORT MAP 
    (
        clk         => clk,
        rst         => rst,
        wr_en       => write_enable_E,
        data_in     => data_write,
        data_out    => data_out_E
    );

    F: registrador_16bits
    PORT MAP 
    (
        clk         => clk,
        rst         => rst,
        wr_en       => write_enable_F,
        data_in     => data_write,
        data_out    => data_out_F
    );

    H: registrador_16bits
    PORT MAP 
    (
        clk         => clk,
        rst         => rst,
        wr_en       => write_enable_H,
        data_in     => data_write,
        data_out    => data_out_H
    );

    
    write_enable_A <='1' WHEN select_write = "001" and wr_en = '1' ELSE '0';
    write_enable_B <='1' WHEN select_write = "010" and wr_en = '1' ELSE '0';
    write_enable_C <='1' WHEN select_write = "011" and wr_en = '1' ELSE '0';
    write_enable_D <='1' WHEN select_write = "100" and wr_en = '1' ELSE '0';
    write_enable_E <='1' WHEN select_write = "101" and wr_en = '1' ELSE '0';
    write_enable_F <='1' WHEN select_write = "110" and wr_en = '1' ELSE '0';
    write_enable_H <='1' WHEN select_write = "111" and wr_en = '1' ELSE '0';
    
    
    
    data_read1 <=   data_out_L WHEN select_read1 = "000" else
                    data_out_A WHEN select_read1 = "001" else
                    data_out_B WHEN select_read1 = "010" else
                    data_out_C WHEN select_read1 = "011" else
                    data_out_D WHEN select_read1 = "100" else
                    data_out_E WHEN select_read1 = "101" else
                    data_out_F WHEN select_read1 = "110" else
                    data_out_H WHEN select_read1 = "111" else
                    "0000000000000000";
    
    data_read2 <=   data_out_L WHEN select_read2 ="000" else
                    data_out_A WHEN select_read2 ="001" else
                    data_out_B WHEN select_read2 ="010" else
                    data_out_C WHEN select_read2 ="011" else
                    data_out_D WHEN select_read2 ="100" else
                    data_out_E WHEN select_read2 ="101" else
                    data_out_F WHEN select_read2 ="110" else
                    data_out_H WHEN select_read2 ="111" else
                    "0000000000000000";

END ARCHITECTURE a_banco_registradores;