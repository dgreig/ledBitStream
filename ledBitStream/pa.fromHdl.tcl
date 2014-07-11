
# PlanAhead Launch Script for Pre-Synthesis Floorplanning, created by Project Navigator

create_project -name ledBitStream -dir "C:/Engineering/FPGA/VHDL/ledBitStream/planAhead_run_1" -part xc3s200ft256-4
set_param project.pinAheadLayout yes
set srcset [get_property srcset [current_run -impl]]
set_property target_constrs_file "ledBitStream.ucf" [current_fileset -constrset]
set hdlfile [add_files [list {ledBitStream_pkg.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set hdlfile [add_files [list {LEDS.vhd}]]
set_property file_type VHDL $hdlfile
set_property library work $hdlfile
set_property top ledBitStream $srcset
add_files [list {ledBitStream.ucf}] -fileset [get_property constrset [current_run]]
open_rtl_design -part xc3s200ft256-4
