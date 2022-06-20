# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct D:\CR\Projeto\MB_LSFR_RandomNumber\VitisProject\design_1_wrapper\platform.tcl
# 
# OR launch xsct and run below command.
# source D:\CR\Projeto\MB_LSFR_RandomNumber\VitisProject\design_1_wrapper\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {design_1_wrapper}\
-hw {D:\CR\Projeto\MB_LSFR_RandomNumber\design_1_wrapper.xsa}\
-fsbl-target {psu_cortexa53_0} -out {D:/CR/Projeto/MB_LSFR_RandomNumber/VitisProject}

platform write
domain create -name {standalone_microblaze_0} -display-name {standalone_microblaze_0} -os {standalone} -proc {microblaze_0} -runtime {cpp} -arch {32-bit} -support-app {hello_world}
platform generate -domains 
platform active {design_1_wrapper}
platform generate -quick
platform generate
platform clean
platform generate
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform clean
platform generate
platform clean
platform generate
platform active {design_1_wrapper}
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform clean
platform generate
platform clean
platform generate
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform active {design_1_wrapper}
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform active {design_1_wrapper}
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform active {design_1_wrapper}
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform clean
platform generate
platform clean
platform generate
platform active {design_1_wrapper}
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains standalone_microblaze_0 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform active {design_1_wrapper}
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform clean
platform generate
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform active {design_1_wrapper}
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform config -updatehw {D:/CR/Projeto/MB_LSFR_RandomNumber/design_1_wrapper.xsa}
platform generate -domains 
platform clean
platform generate
platform clean
platform generate
