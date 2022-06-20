# Usage with Vitis IDE:
# In Vitis IDE create a Single Application Debug launch configuration,
# change the debug type to 'Attach to running target' and provide this 
# tcl script in 'Execute Script' option.
# Path of this script: D:\CR\Projeto\MB_LSFR_RandomNumber\VitisProject\LSFR_RandomSW_system\_ide\scripts\systemdebugger_lsfr_randomsw_system_standalone.tcl
# 
# 
# Usage with xsct:
# To debug using xsct, launch xsct and run below command
# source D:\CR\Projeto\MB_LSFR_RandomNumber\VitisProject\LSFR_RandomSW_system\_ide\scripts\systemdebugger_lsfr_randomsw_system_standalone.tcl
# 
connect -url tcp:127.0.0.1:3121
targets -set -filter {jtag_cable_name =~ "Digilent Nexys4 210274505234A" && level==0 && jtag_device_ctx=="jsn-Nexys4-210274505234A-13631093-0"}
fpga -file D:/CR/Projeto/MB_LSFR_RandomNumber/VitisProject/LSFR_RandomSW/_ide/bitstream/download.bit
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
loadhw -hw D:/CR/Projeto/MB_LSFR_RandomNumber/VitisProject/design_1_wrapper/export/design_1_wrapper/hw/design_1_wrapper.xsa -regs
configparams mdm-detect-bscan-mask 2
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
rst -system
after 3000
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
dow D:/CR/Projeto/MB_LSFR_RandomNumber/VitisProject/LSFR_RandomSW/Debug/LSFR_RandomSW.elf
targets -set -nocase -filter {name =~ "*microblaze*#0" && bscan=="USER2" }
con
