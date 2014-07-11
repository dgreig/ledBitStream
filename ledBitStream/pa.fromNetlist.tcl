
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name ledBitStream -dir "C:/Engineering/FPGA/VHDL/ledBitStream/planAhead_run_3" -part xc3s200ft256-4
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Engineering/FPGA/VHDL/ledBitStream/ledBitStream.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Engineering/FPGA/VHDL/ledBitStream} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "ledBitStream.ucf" [current_fileset -constrset]
add_files [list {ledBitStream.ucf}] -fileset [get_property constrset [current_run]]
link_design
