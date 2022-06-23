# Implementação de um Microprocessador (Rabbit 2000) em VHDL
## Opcodes, codificação binária e assembly.

| OpCode    | Operação  | Operando1     | Operando2     | Formato               | Descrição | Exemplo (binário)   | Exemplo (assembly)  |
|-----------|-----------|---------------|---------------|-----------------------|-----------|-----------|-----------|
| 00001     | LD        |reg            | cte           | LD reg, cte           |Carrega a constante cte para o registrador reg | 00001_001_000001 | LD A, 1 |
| 00010     | LD        |regA           | regB          | LD regA, regB         |Carrega o registrador regB para o registrador regA | 00010_010_001_0000 | LD B, A |
| 00011     | LD        |(ram_address)  | reg           | LD (ram_address), reg |Carrega o valor do registrador reg para o endereço ram_add da RAM | 00011_001_0000111 | LD (0x7), A |
| 00100     | LD        |reg            | (ram_address) | LD reg, (ram_address) |Carrega o valor do endereço da RAM para o registrador reg | 00100_001_0000111 | LD B, (0x7) |
| 00101     | ADD       |reg            | cte           | ADD reg, cte          |Soma o valor da constante cte no registrador reg e guarda em reg | 00101_010_0001000 | ADD B, 8 |
| 00110     | ADD       |regA           | regB          | ADD regA, regB        |Soma o valor do registrador regB com o registrador regA e guarda em regA | 00110_010_001_0000 | ADD B, A |
| 00111     | ADC       |reg            | cte           | ADC reg, cte          |Soma o valor da constante cte no registrador reg e escreve a flag carry_sum | 00111_001_0000111 | ADC A, 7 |
| 01000     | ADC       |regA           | regB          | ADC regA, regB        |Soma o valor do registrador regB com o registrador regA e escreve a flag carry_sum | 01000_001_010_0000 | ADC A, B |
| 01001     | SUB       |reg            | cte           | SUB reg, cte          |Subtrai o valor da constante cte no registrador reg e guarda em reg | 01001_001_0000111 | SUB A, 7 |
| 01010     | SUB       |regA           | regB          | SUB regA, regB        |Subtrai o valor do registrador regB do valor do registrador regA e guarda em regA | 01010_001_010_0000 | SUB A, B |
| 01011     | SBC       |reg            | cte           | SBC reg, cte          |Subtrai o valor da constante cte no registrador reg e escreve a flag carry_sub | 01011_001_0000001 | SBC A, 7 |
| 01100     | SBC       |regA           | regB          | SBC regA, regB        |Subtrai o valor do registrador regB do valor do registrador regA e escreve a flag carry_sub | 01100_001_010_0000 | SBC A, B |
| 01101     | LD        |(regA)         | regB          | LD (regA), regB       |Carrega o valor de regB para o endereço apontado por regA na RAM. | 01101_001_010_0000 | LD (A), B |
| 01110     | LD        |regA           | (regB)        | LD regA, (regB)       |Carrega o valor do endereço da RAM apontado por regB para o registrador regA | 01110_001_010_0000 | LD A, (B) |
| 11110     | JP        |mn             | -             | JP mn                 |Realiza um jump absoluto para o endereço mn de 7 bits especificado. | 11110_000_0000001 | JP 1 |
| 11111     | JR        |M              | e             | JR M, e               |Realiza um jump relativo ao endereço atual para frente ou para trás | 11111_000_1111011 | JR M, 5 |
