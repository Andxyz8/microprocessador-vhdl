LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;


ENTITY unidade_controle IS
    PORT
    (
        clk             : IN STD_LOGIC;
        rst             : IN STD_LOGIC;
        read_rom        : OUT STD_LOGIC;
        wren_ram        : OUT STD_LOGIC;
        wren_pc         : OUT STD_LOGIC;
        di_pc           : OUT UNSIGNED(6 DOWNTO 0);
        do_pc           : IN UNSIGNED(6 DOWNTO 0);
        state           : IN UNSIGNED(1 DOWNTO 0);
        slt_op_ula      : OUT UNSIGNED(1 DOWNTO 0);
        out_bool_ula    : IN STD_LOGIC;
        srcA_ula        : OUT UNSIGNED(1 DOWNTO 0) ;
        srcB_ula        : OUT UNSIGNED(1 DOWNTO 0);
        wr_reg          : OUT STD_LOGIC;
        slt_reg1        : OUT UNSIGNED(2 DOWNTO 0);
        slt_reg2        : OUT UNSIGNED(2 DOWNTO 0);
        slt_wr_reg      : OUT UNSIGNED(2 DOWNTO 0);
        instr           : IN UNSIGNED(14 DOWNTO 0)
    );
END ENTITY unidade_controle;

ARCHITECTURE a_unidade_controle OF unidade_controle IS
    
    COMPONENT flag IS
        PORT
        (
            clk      : IN STD_LOGIC ;
            rst      : IN STD_LOGIC ;
            wr_en    : IN STD_LOGIC ;
            data_in  : IN STD_LOGIC ;
            data_out : OUT STD_LOGIC
        );
    END COMPONENT flag;
    
    SIGNAL opcode       : UNSIGNED(4 DOWNTO 0);
    SIGNAL jump_en      : UNSIGNED(1 DOWNTO 0);
    SIGNAL flag_carry_s : STD_LOGIC;
    SIGNAL wren_fc      : STD_LOGIC;
    
BEGIN
    flag_carry : flag
    PORT MAP
    (
        clk      => clk,
        rst      => rst,
        wr_en    => wren_fc,
        data_in  => out_bool_ula,
        data_out => flag_carry_s
    );
    
    opcode      <= instr(14 DOWNTO 10);
    
    jump_en     <=  "10" WHEN opcode = "11110" ELSE -- JP
                    "11" WHEN opcode = "11111" AND flag_carry_s = '1' ELSE -- JR
                    "00";

    read_rom    <= '1' WHEN state = "01" ELSE '0';
    
    wren_pc     <= '1' WHEN state = "00" ELSE '0';
    
    wren_ram    <= '1' WHEN state = "10" AND (opcode = "00011" OR opcode = "01101") ELSE '0';
    
    wr_reg      <= '1' WHEN state = "10" AND (opcode = "00001" OR           -- LD reg, cte
                                              opcode = "00010" OR           -- LD regA, regB
                                              opcode = "00100" OR           -- LD reg, (ram_address)
                                              opcode = "00101" OR           -- ADD reg, cte
                                              opcode = "00110" OR           -- ADD regA, regB
                                              opcode = "01001" OR           -- SUB reg, cte
                                              opcode = "01010" OR           -- SUB regA, regB
                                              opcode = "01110")  ELSE '0';  -- LD regA, (regB)
        
    wren_fc <=  '1' WHEN (opcode = "00111" OR           -- ADC reg, cte
                          opcode = "01000" OR           -- ADC regA, regB
                          opcode = "01011" OR           -- SBC reg, cte
                          opcode = "01100") ELSE '0';   -- SBC regA, regB
        
    di_pc       <=  instr(6 DOWNTO 0) WHEN jump_en = "10" ELSE
                    do_pc + 1 + instr(6 DOWNTO 0) WHEN jump_en = "11" ELSE
                    do_pc + 1;
        
    slt_op_ula  <= "01" WHEN (opcode = "01001" OR           -- SUB reg, cte
                              opcode = "01010" OR           -- SUB regA, regB
                              opcode = "01011" OR           -- SBC reg, cte
                              opcode = "01100") ELSE "00";  -- SBC regA, regB
        
    slt_reg1    <= "000" WHEN (opcode = "00001" OR                          -- LD reg, cte
                               opcode = "00010" OR                          -- LD regA, regB
                               opcode = "00100" OR                          -- LD reg, (ram_address)
                               opcode = "01110" OR                          -- LD regA, (regB)
                               opcode = "11110" OR                          -- JP abs_address
                               opcode = "11111") ELSE instr(9 DOWNTO 7);    -- JR rel_address

    slt_reg2    <= instr(6 DOWNTO 4) WHEN (opcode = "00010" OR              -- LD regA, regB
                                           opcode = "01101" OR              -- LD (regA), regB
                                           opcode = "01110" OR              -- LD regA, (regB)
                                           opcode = "00110" OR              -- ADD regA, regB
                                           opcode = "01000" OR              -- ADC regA, regB
                                           opcode = "01010" OR              -- SUB regA, regB
                                           opcode = "01100") ELSE "000";    -- SBC regA, regB

    slt_wr_reg  <= instr(9 DOWNTO 7);

    -- 00 registrador1 | 01 e 10 "000000000000000"
    srcA_ula    <= "01" WHEN(opcode = "01101") ELSE "00";   -- LD (regA), regB

    -- 00 registrador2 | 01 cte | 10 ram
    srcB_ula    <= "00" WHEN (opcode = "00010" OR       -- LD regA, regB
                              opcode = "01101" OR       -- LD (regA), regB
                              opcode = "00110" OR       -- ADD regA, regB
                              opcode = "01000" OR       -- ADC regA, regB
                              opcode = "01010" OR       -- SUB regA, regB
                              opcode = "01100" OR       -- SBC regA, regB
                              opcode = "00011") ELSE    -- LD (ram_address), reg
                   "10" WHEN (opcode = "00100" OR       -- LD reg, (ram_address)
                              opcode = "01110") ELSE    -- LD regA, (regB)
                   "01";
    
    END ARCHITECTURE a_unidade_controle;