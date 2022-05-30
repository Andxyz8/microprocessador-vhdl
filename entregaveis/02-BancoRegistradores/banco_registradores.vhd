library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity banco_registradores is
    port(
        select_read1: in unsigned(2 downto 0);
        select_read2: in unsigned(2 downto 0);
        select_write: in unsigned(2 downto 0);
        
        wr_en: in STD_LOGIC;
        clk: in STD_LOGIC;
        rst: in STD_LOGIC;
        
        data_write: in unsigned(15 downto 0);

        data_read1: out unsigned(15 downto 0);
        data_read2: out unsigned(15 downto 0)
    );
end entity banco_registradores;

architecture a_banco_registradores of banco_registradores is
    component registrador_16bits is
        port(
            clk : in STD_LOGIC;
            rst : in STD_LOGIC;
            wr_en : in STD_LOGIC;
            data_in : in unsigned (15 downto 0);
            data_out : out unsigned (15 downto 0)
        );
    end component;
    
    signal wr_en1, wr_en2, wr_en3, wr_en4, wr_en5, wr_en6, wr_en7 : STD_LOGIC := '0';
    signal data_out0, data_out1, data_out2, data_out3, data_out4, data_out5, data_out6, data_out7: unsigned(15 downto 0);
    constant wr_en0 : STD_LOGIC:='0';
    
begin
    
    registrador0: registrador_16bits port map(clk => clk, rst => rst, wr_en => wr_en0, data_in => data_write, data_out => data_out0);
    registrador1: registrador_16bits port map(clk => clk, rst => rst, wr_en => wr_en1, data_in => data_write, data_out => data_out1);
    registrador2: registrador_16bits port map(clk => clk, rst => rst, wr_en => wr_en2, data_in => data_write, data_out => data_out2);
    registrador3: registrador_16bits port map(clk => clk, rst => rst, wr_en => wr_en3, data_in => data_write, data_out => data_out3);
    registrador4: registrador_16bits port map(clk => clk, rst => rst, wr_en => wr_en4, data_in => data_write, data_out => data_out4);
    registrador5: registrador_16bits port map(clk => clk, rst => rst, wr_en => wr_en5, data_in => data_write, data_out => data_out5);
    registrador6: registrador_16bits port map(clk => clk, rst => rst, wr_en => wr_en6, data_in => data_write, data_out => data_out6);
    registrador7: registrador_16bits port map(clk => clk, rst => rst, wr_en => wr_en7, data_in => data_write, data_out => data_out7);
    
    wr_en1 <='1' when select_write = "001" and wr_en='1' else '0';
    wr_en2 <='1' when select_write = "010" and wr_en='1' else '0';
    wr_en3 <='1' when select_write = "011" and wr_en='1' else '0';
    wr_en4 <='1' when select_write = "100" and wr_en='1' else '0';
    wr_en5 <='1' when select_write = "101" and wr_en='1' else '0';
    wr_en6 <='1' when select_write = "110" and wr_en='1' else '0';
    wr_en7 <='1' when select_write = "111" and wr_en='1' else '0';
    
    
    
    data_read1 <= data_out0 when select_read1 = "000" else
    data_out1 when select_read1 = "001" else
    data_out2 when select_read1 = "010" else
    data_out3 when select_read1 = "011" else
    data_out4 when select_read1 = "100" else
    data_out5 when select_read1 = "101" else
    data_out6 when select_read1 = "110" else
    data_out7 when select_read1 = "111" else
                    "0000000000000000";
    
    data_read2 <= data_out0 when select_read2 ="000" else
    data_out1 when select_read2 ="001" else
    data_out2 when select_read2 ="010" else
    data_out3 when select_read2 ="011" else
    data_out4 when select_read2 ="100" else
    data_out5 when select_read2 ="101" else
    data_out6 when select_read2 ="110" else
    data_out7 when select_read2 ="111" else
                    "0000000000000000";

end architecture a_banco_registradores;