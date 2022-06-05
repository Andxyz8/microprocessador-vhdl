LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY ula IS
    PORT(
        inA, inB        : IN SIGNED(15 DOWNTO 0);
        slt_op          : IN UNSIGNED(1 DOWNTO 0);
        out_num         : OUT SIGNED(15 DOWNTO 0);
        out_bool        : OUT STD_LOGIC;
        flag_carry_sum  : OUT STD_LOGIC;
        flag_carry_sub  : OUT STD_LOGIC 
    );
END ENTITY ula;

-- slt_op:
-- 00 - soma
-- 01 - subtração
-- 10 - maior
-- 11 - diferente

ARCHITECTURE a_ula OF ula IS

    SIGNAL inA_17bit, inB_17bit, sum_17bit : SIGNED(16 DOWNTO 0);
    
BEGIN
    inA_17bit   <= '0' & inA;
    inB_17bit   <= '0' & inB;
    sum_17bit   <= inA_17bit + inA_17bit;
    
    out_num <=  inA + inB WHEN slt_op = "00" ELSE
                inA - inB WHEN slt_op = "01" ELSE
                "0000000000000000";

    out_bool <= '1' WHEN (inA > inB) AND slt_op = "10"     ELSE
                '1' WHEN (inA /= inB) AND slt_op = "11"    ELSE
                '0';

    flag_carry_sum <= sum_17bit(16) WHEN slt_op = "00" ELSE
                      '0';
    
    flag_carry_sub <= '1' WHEN slt_op = "01" AND inB > inA ELSE
                      '0';
    
END ARCHITECTURE a_ula;







