#Set-Alias -Name ghdl -Value "C:\Users\User\AppData\Roaming\VHDPlus\packages\ghdl\GHDL\0.37-mingw32-mcode\bin\ghdl.exe"

#Set-Alias -Name gtkwave -Value "C:\Users\User\AppData\Roaming\VHDPlus\packages\gtkwave\gtkwave\bin\gtkwave.exe"

ghdl -a flag.vhd
ghdl -a registrador_16bits.vhd
ghdl -a banco_registradores.vhd
ghdl -a mux.vhd
ghdl -a rom.vhd
ghdl -a ula.vhd
ghdl -a program_counter.vhd
ghdl -a maquina_estados.vhd
ghdl -a unidade_controle.vhd
ghdl -a processador.vhd

ghdl -a processador_tb.vhd
ghdl -r processador_tb --wave=ondas.ghw

gtkwave ondas.ghw