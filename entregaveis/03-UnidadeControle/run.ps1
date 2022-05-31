#Set-Alias -Name ghdl -Value "C:\Users\User\AppData\Roaming\VHDPlus\packages\ghdl\GHDL\0.37-mingw32-mcode\bin\ghdl.exe"

#Set-Alias -Name gtkwave -Value "C:\Users\User\AppData\Roaming\VHDPlus\packages\gtkwave\gtkwave\bin\gtkwave.exe"

ghdl -a rom.vhd
ghdl -a program_counter.vhd
ghdl -a maq_estados.vhd
ghdl -a proto_uc.vhd


ghdl -a proto_uc_tb.vhd
ghdl -r proto_uc_tb --wave=ondasproto.ghw

gtkwave ondasproto.ghw