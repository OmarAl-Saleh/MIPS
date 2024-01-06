transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS/Modules {E:/Omar/CPU Design/MIPS/Modules/ForwardingUnit.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS/Modules {E:/Omar/CPU Design/MIPS/Modules/JUMP.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS/Modules {E:/Omar/CPU Design/MIPS/Modules/Branch.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS/Modules {E:/Omar/CPU Design/MIPS/Modules/sign_extend.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS/Modules {E:/Omar/CPU Design/MIPS/Modules/RegisterFile.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS/Modules {E:/Omar/CPU Design/MIPS/Modules/RAM.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS/Modules {E:/Omar/CPU Design/MIPS/Modules/PC.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS/Modules {E:/Omar/CPU Design/MIPS/Modules/MUX5bit.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS/Modules {E:/Omar/CPU Design/MIPS/Modules/MUX4_1.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS/Modules {E:/Omar/CPU Design/MIPS/Modules/MUX2_1.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS/Modules {E:/Omar/CPU Design/MIPS/Modules/MEM_WB_Register.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS/Modules {E:/Omar/CPU Design/MIPS/Modules/INST_MEM.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS/Modules {E:/Omar/CPU Design/MIPS/Modules/IF_ID_Register.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS/Modules {E:/Omar/CPU Design/MIPS/Modules/ID_EX_Register.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS/Modules {E:/Omar/CPU Design/MIPS/Modules/Hazard_Unit.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS/Modules {E:/Omar/CPU Design/MIPS/Modules/EX_MEM_Register.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS/Modules {E:/Omar/CPU Design/MIPS/Modules/ControlUnit.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS/Modules {E:/Omar/CPU Design/MIPS/Modules/alu_control.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS/Modules {E:/Omar/CPU Design/MIPS/Modules/ALU.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS/Modules {E:/Omar/CPU Design/MIPS/Modules/adder.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/Pipeline_building_testing {E:/Omar/CPU Design/Pipeline_building_testing/Main.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/Pipeline_building_testing {E:/Omar/CPU Design/Pipeline_building_testing/Main_tb.v}

vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/Pipeline_building_testing {E:/Omar/CPU Design/Pipeline_building_testing/Main_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  Main_tb

add wave *
view structure
view signals
run -all
