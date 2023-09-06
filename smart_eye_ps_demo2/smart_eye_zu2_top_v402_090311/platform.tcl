# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/fpga/u1_library/k0_smart_eye/smart_eye_ps_demo2/smart_eye_zu2_top_v402_090311/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/fpga/u1_library/k0_smart_eye/smart_eye_ps_demo2/smart_eye_zu2_top_v402_090311/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {smart_eye_zu2_top_v402_090311}\
-hw {/home/fpga/u1_library/k0_smart_eye/smart_eye_ps_demo2/smart_eye_zu2_top_v402_090311.xsa}\
-arch {64-bit} -fsbl-target {psu_cortexa53_0} -out {/home/fpga/u1_library/k0_smart_eye/smart_eye_ps_demo2}

platform write
domain create -name {standalone_psu_cortexa53_0} -display-name {standalone_psu_cortexa53_0} -os {standalone} -proc {psu_cortexa53_0} -runtime {cpp} -arch {64-bit} -support-app {lwip_udp_perf_server}
platform generate -domains 
platform active {smart_eye_zu2_top_v402_090311}
domain active {zynqmp_fsbl}
domain active {zynqmp_pmufw}
domain active {standalone_psu_cortexa53_0}
platform generate -quick
