LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;


ENTITY unidade_controle IS
    PORT
    (
        clk         : IN STD_LOGIC;
        rst         : IN STD_LOGIC;
        read_rom    : OUT STD_LOGIC;
        wren_pc     : OUT STD_LOGIC;
        di_pc       : OUT UNSIGNED(6 DOWNTO 0);
        do_pc       : IN UNSIGNED(6 DOWNTO 0);
        state       : IN UNSIGNED(1 DOWNTO 0);
        slt_ula     : OUT UNSIGNED(1 DOWNTO 0);
        srcB_ula    : OUT STD_LOGIC;
        wr_reg      : OUT STD_LOGIC;
        slt_reg1    : OUT UNSIGNED(2 DOWNTO 0);
        slt_reg2    : OUT UNSIGNED(2 DOWNTO 0);
        slt_wr_reg  : OUT UNSIGNED(2 DOWNTO 0);
        instr       : IN UNSIGNED(14 DOWNTO 0)
    );
END ENTITY unidade_controle;

ARCHITECTURE a_unidade_controle OF unidade_controle IS
    
    SIGNAL opcode   : UNSIGNED(5 DOWNTO 0);
    SIGNAL jump_en  : STD_LOGIC;
    
BEGIN
    opcode <= instr(14 DOWNTO 9);
    
    jump_en     <= '1' WHEN opcode = "101111" ELSE '0';

    read_rom    <= '1' WHEN state = "01" ELSE '0';

    wren_pc     <= '1' WHEN state = "00" ELSE '0';
    
    di_pc       <= instr(6 DOWNTO 0) WHEN jump_en = '1' ELSE do_pc + 1;
    
    slt_ula     <= opcode(1 DOWNTO 0);
    
    slt_reg1    <= "000" WHEN opcode(3 DOWNTO 2) = "00" ELSE instr(8 DOWNTO 6);
    
    slt_reg2    <= instr(5 DOWNTO 3);
    
    slt_wr_reg  <= instr(8 DOWNTO 6);
    
    wr_reg      <= opcode(4) WHEN state = "10" ELSE '0';
    
    srcB_ula    <= opcode(5); --0 registrador --1 TL
    
END ARCHITECTURE a_unidade_controle;