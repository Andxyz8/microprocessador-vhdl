#Set-Alias -Name ghdl -Value "C:\Users\User\AppData\Roaming\VHDPlus\packages\ghdl\GHDL\0.37-mingw32-mcode\bin\ghdl.exe"

#Set-Alias -Name gtkwave -Value "C:\Users\User\AppData\Roaming\VHDPlus\packages\gtkwave\gtkwave\bin\gtkwave.exe"

ghdl -a mux.vhd
ghdl -a registrador_16bits.vhd
ghdl -a banco_registradores.vhd
ghdl -a ula.vhd
ghdl -a main.vhd

ghdl -a main_tb.vhd
ghdl -r main_tb --wave=ondas.ghw

gtkwave ondas.ghw