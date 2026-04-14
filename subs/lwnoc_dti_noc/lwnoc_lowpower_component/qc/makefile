comp:
	cd ${LWNOC_LOWPOWER_COMPONENT}/work; verilator --lint-only --language 1800-2017 -f ${LWNOC_LOWPOWER_COMPONENT}/src/vc/lwnoc_lp_core.f -Wall +define+ASIC_SIM
lint:
	fde -file $(LWNOC_LOWPOWER_COMPONENT)/qc/lint.tcl -flow lint
comp_dut:
	cd ${LWNOC_LOWPOWER_COMPONENT}/work; verilator --lint-only --language 1800-2017 -f ${LWNOC_LOWPOWER_COMPONENT}/src/vc/dut.f --top-module dut -Wall +define+ASIC_SIM
comp_tb:
	cd ${LWNOC_LOWPOWER_COMPONENT}/work; verilator --binary --language 1800-2017 --timing --trace -f ${LWNOC_LOWPOWER_COMPONENT}/src/vc/tb.f --top-module tb_dut -Wall +define+ASIC_SIM -Mdir ${LWNOC_LOWPOWER_COMPONENT}/work/obj_dir -o ${LWNOC_LOWPOWER_COMPONENT}/work/simv
clean:
	cd ${LWNOC_LOWPOWER_COMPONENT}/work; rm -rf simv* dump* obj_dir