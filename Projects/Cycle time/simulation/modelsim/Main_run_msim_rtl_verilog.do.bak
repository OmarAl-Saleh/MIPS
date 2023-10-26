transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS\ Processor/Modules {E:/Omar/CPU Design/MIPS Processor/Modules/sign_extend.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS\ Processor/Modules {E:/Omar/CPU Design/MIPS Processor/Modules/RegisterFile.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS\ Processor/Modules {E:/Omar/CPU Design/MIPS Processor/Modules/RAM.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS\ Processor/Modules {E:/Omar/CPU Design/MIPS Processor/Modules/PC.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS\ Processor/Modules {E:/Omar/CPU Design/MIPS Processor/Modules/MUX5bit.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS\ Processor/Modules {E:/Omar/CPU Design/MIPS Processor/Modules/MUX2_1.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS\ Processor/Modules {E:/Omar/CPU Design/MIPS Processor/Modules/Main.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS\ Processor/Modules {E:/Omar/CPU Design/MIPS Processor/Modules/INST_MEM.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS\ Processor/Modules {E:/Omar/CPU Design/MIPS Processor/Modules/ControlUnit.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS\ Processor/Modules {E:/Omar/CPU Design/MIPS Processor/Modules/alu_control.v}
vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/MIPS\ Processor/Modules {E:/Omar/CPU Design/MIPS Processor/Modules/ALU.v}

vlog -vlog01compat -work work +incdir+E:/Omar/CPU\ Design/Report\ Project/Cycle\ time/../../MIPS\ Processor/Test\ Benches {E:/Omar/CPU Design/Report Project/Cycle time/../../MIPS Processor/Test Benches/Main_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  Main_tb

add wave *
view structure
view signals
run -all
