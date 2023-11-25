transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/Hazard\ Detection\ Unit {E:/Omar/CPU Design/Hazard Detection Unit/Hazard_Unit.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/Hazard\ Detection\ Unit {E:/Omar/CPU Design/Hazard Detection Unit/Hazard_Unit_tb.v}

vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/Hazard\ Detection\ Unit {E:/Omar/CPU Design/Hazard Detection Unit/Hazard_Unit.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L rtl_work -L work -voptargs="+acc"  Hazard_Unit_tb

add wave *
view structure
view signals
run -all
