# Placeholder integration constraints for soc_atb_noc
create_clock -name clk_core -period 2.0 [get_ports clk_core]
set_false_path -from [get_ports rst_n]
