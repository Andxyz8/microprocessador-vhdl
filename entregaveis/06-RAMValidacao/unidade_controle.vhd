LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;


ENTITY unidade_controle IS
    PORT
    (
        clk             : IN STD_LOGIC;
        rst             : IN STD_LOGIC;
        read_rom        : OUT STD_LOGIC;
        wren_pc         : OUT STD_LOGIC;
        di_pc           : OUT UNSIGNED(6 DOWNTO 0);
        do_pc           : IN UNSIGNED(6 DOWNTO 0);
        state           : IN UNSIGNED(1 DOWNTO 0);
        slt_op_ula      : OUT UNSIGNED(1 DOWNTO 0);
        out_bool_ula    : IN STD_LOGIC;
        srcA_ula        : OUT STD_LOGIC;
        srcB_ula        : OUT STD_LOGIC;
        wr_reg          : OUT STD_LOGIC;
        wr_ram          : OUT STD_LOGIC;
        flag_carry_sum  : IN STD_LOGIC;
        flag_carry_sub  : IN STD_LOGIC;
        slt_reg1        : OUT UNSIGNED(2 DOWNTO 0);
        slt_reg2        : OUT UNSIGNED(2 DOWNTO 0);
        slt_wr_reg      : OUT UNSIGNED(2 DOWNTO 0);
        instr           : IN UNSIGNED(14 DOWNTO 0)
    );
END ENTITY unidade_controle;

ARCHITECTURE a_unidade_controle OF unidade_controle IS
    
    SIGNAL opcode           : UNSIGNED(5 DOWNTO 0);
    SIGNAL jump_en          : UNSIGNED(1 DOWNTO 0);
    SIGNAL flag_carry_sub_s : STD_LOGIC;
    
BEGIN
    flag_carry_sub_s <= flag_carry_sub WHEN state = "01";
    
    opcode      <= instr(14 DOWNTO 9);
    
    jump_en     <=  "10" WHEN opcode = "101111" ELSE -- JP abs_adr 001000_001_000111
                    "11" WHEN opcode = "111111" AND flag_carry_sub_s = '1' ELSE -- JR rel_adr
                    "00";

    read_rom    <= '1' WHEN state = "01" ELSE '0';

    wren_pc     <= '1' WHEN state = "00" ELSE '0';
    
    wr_reg      <= opcode(4) WHEN state = "10" ELSE '0';
    
    wr_ram      <= '1' WHEN opcode = "001000" AND state = "10" ELSE '0';
    
    di_pc       <=  instr(6 DOWNTO 0) WHEN jump_en = "10" ELSE
                    do_pc + 1 + instr(6 DOWNTO 0) WHEN jump_en = "11" ELSE
                    do_pc + 1;
    
    slt_op_ula  <= opcode(1 DOWNTO 0);
    
    slt_reg1    <= "000" WHEN opcode(2) = '0' ELSE instr(8 DOWNTO 6);
    
    slt_reg2    <= "000" WHEN opcode(3) = '1' ELSE instr(5 DOWNTO 3);
    
    slt_wr_reg  <= instr(8 DOWNTO 6);
    
    srcA_ula    <= opcode(3);
    
    srcB_ula    <= opcode(5); --0 registrador --1 cte
    
END ARCHITECTURE a_unidade_controle;