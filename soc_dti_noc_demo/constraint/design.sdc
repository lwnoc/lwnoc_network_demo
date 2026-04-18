##############################################################################
# DTI Logic NoC top-level SDC constraints
# Target wrapper: dti_logic_topo
#
# Integrated nodes:
#   - pcie_eth_iniu_node   (pcie/ethernet input NIU, DTI + PCHANNEL)
#   - vpu_iniu_node        (VPU input NIU, DTI + PCHANNEL)
#   - dsp2_iniu_node       (DSP2 input NIU, DTI + PCHANNEL)
#   - dsp1_iniu_node       (DSP1 input NIU, DTI + PCHANNEL)
#   - dsp0_iniu_node       (DSP0 input NIU, DTI + PCHANNEL)
#   - noc_tbu1_iniu_node   (NOC TBU1 input NIU, DTI + PCHANNEL)
#   - usb_ufs_iniu_node    (USB/UFS input NIU, DTI + PCHANNEL)
#   - mipi0_iniu_node      (MIPI0 input NIU, DTI + PCHANNEL)
#   - (Note: more nodes may be present in full topology; extend pattern as needed)
#
# Clock domains:
#   - NOC clock: clk_noc @ ~2.0 GHz (0.5 ns period) — global synchronous domain
#   - SYS clock: <node>_iniu_node_clk_sys_porting_clk_sys_clk @ ~800 MHz (1.25 ns) — per-node async to NOC
#
# Async CDC:
#   - Each INIU node has internal async FIFO bridges between its sys and noc clock domains
#   - SYS <-> NOC crossing via AFIFO + PCHANNEL control paths
#
##############################################################################

###############################################################################
# Section 0: Design configuration
###############################################################################

set TOP_WRAPPER       dti_logic_topo
set NOC_CLK_NAME      clk_noc
set NOC_RST_NAME      rst_noc_n

current_design $TOP_WRAPPER

# Clock periods (nanoseconds)
set SYS_CLK_PERIOD_NS 1.250
set SYS_CLK_HALF_NS   0.625
set NOC_CLK_PERIOD_NS 0.500
set NOC_CLK_HALF_NS   0.250

# I/O timing budget: 60% of receiving clock period
set SYS_IO_DELAY_NS   [expr {$SYS_CLK_PERIOD_NS * 0.60}]
set NOC_IO_DELAY_NS   [expr {$NOC_CLK_PERIOD_NS * 0.60}]

# CDC datapath max delay: one NOC clock period
set CDC_MAX_DELAY_NS  $NOC_CLK_PERIOD_NS

###############################################################################
# Section 1: Global NOC clock (synchronous domain)
###############################################################################

create_clock -name noc_clk \
    -period $NOC_CLK_PERIOD_NS \
    -waveform [list 0.000 $NOC_CLK_HALF_NS] \
    [get_ports $NOC_CLK_NAME]

###############################################################################
# Section 2: Per-node SYS clocks (each asynchronous to NOC, but sync within node)
###############################################################################

# Pattern: <node>_iniu_node_clk_sys_porting_clk_sys_clk
# Extract unique node list from port names and create clocks

set node_list {pcie_eth vpu dsp2 dsp1 dsp0 noc_tbu1 usb_ufs mipi0}

foreach node $node_list {
    set sys_clk_port "${node}_iniu_node_clk_sys_porting_clk_sys_clk"
    set sys_clk_name "${node}_sys_clk"
    
    # Only create clock if port exists in the design
    set port_obj [get_ports -quiet $sys_clk_port]
    if {[llength $port_obj] > 0} {
        create_clock -name $sys_clk_name \
            -period $SYS_CLK_PERIOD_NS \
            -waveform [list 0.000 $SYS_CLK_HALF_NS] \
            [get_ports $sys_clk_port]
    }
}

###############################################################################
# Section 3: Clock domain isolation
###############################################################################

# Each node's SYS clock is asynchronous to the NOC clock
set_clock_groups -async \
    -group [get_clocks noc_clk] \
    -group [get_clocks *_sys_clk]

# All SYS clocks within the same node are synchronous; across nodes they are independent
# (If multi-node coherency is required, additional set_clock_groups would be added here)

###############################################################################
# Section 4: Reset handling
###############################################################################

set_false_path -from [get_ports $NOC_RST_NAME]

foreach node $node_list {
    set rst_port "${node}_iniu_node_rst_sys_n_porting_rst_sys_n_rst_n"
    set rst_obj [get_ports -quiet $rst_port]
    if {[llength $rst_obj] > 0} {
        set_false_path -from [get_ports $rst_port]
    }
}

###############################################################################
# Section 5: CDC Constraints - NOC side (synchronous)
###############################################################################

# DTI request path: tvalid, tdata, tkeep, tlast, ttid converge on NOC side
# These are captured in NOC clock domain; no cross-domain timing required within NOC
set_false_path -through [get_ports {*_dti_req_porting_dti_req_req_*}] -through [get_clocks noc_clk]

# DTI response path: tvalid, tdata, tkeep, tlast, ttid sourced from NOC side
set_false_path -through [get_ports {*_dti_rsp_porting_dti_rsp_rsp_*}] -through [get_clocks noc_clk]

###############################################################################
# Section 6: CDC Constraints - SYS to NOC crossing (async FIFO)
###############################################################################

# Max delay for CDC pointer synchronizers: one NOC clock period
foreach node $node_list {
    set sys_clk_name "${node}_sys_clk"
    
    # Paths from SYS clock to NOC clock through async FIFO / PCHANNEL control
    set_max_delay -datapath_only $CDC_MAX_DELAY_NS \
        -from [get_clocks -quiet $sys_clk_name] \
        -through [get_pins -hierarchical -quiet -filter "name =~ *${node}*async*"] \
        -to [get_clocks noc_clk]
    
    # Paths from NOC clock to SYS clock through async FIFO / PCHANNEL status
    set_max_delay -datapath_only $CDC_MAX_DELAY_NS \
        -from [get_clocks noc_clk] \
        -through [get_pins -hierarchical -quiet -filter "name =~ *${node}*async*"] \
        -to [get_clocks -quiet $sys_clk_name]
}

###############################################################################
# Section 7: PCHANNEL control-path CDC
###############################################################################

# paccept, pactive, pdeny, preq, pstate cross async boundaries
# Constrain to one NOC clock period max delay

foreach node $node_list {
    set pchnl_ctrl_ports [get_ports -quiet "${node}_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_*"]
    if {[llength $pchnl_ctrl_ports] > 0} {
        set_max_delay -datapath_only $CDC_MAX_DELAY_NS \
            -through $pchnl_ctrl_ports
    }
}

###############################################################################
# Section 8: Input/Output delay constraints (SYS side)
###############################################################################

# For each INIU node, constrain its sys-side DTI and PCHANNEL interfaces
foreach node $node_list {
    # DTI request inputs (from requestor to INIU)
    set dti_req_inputs [get_ports -quiet "${node}_iniu_node_dti_req_porting_dti_req_req_*data* ${node}_iniu_node_dti_req_porting_dti_req_req_*keep* ${node}_iniu_node_dti_req_porting_dti_req_req_*tid* ${node}_iniu_node_dti_req_porting_dti_req_req_*last* ${node}_iniu_node_dti_req_porting_dti_req_req_*valid"]
    set_input_delay -max $SYS_IO_DELAY_NS -clock "${node}_sys_clk" $dti_req_inputs
    
    # DTI request ready output (from INIU to requestor)
    set dti_req_ready [get_ports -quiet "${node}_iniu_node_dti_req_porting_dti_req_req_*ready"]
    set_output_delay -max $SYS_IO_DELAY_NS -clock "${node}_sys_clk" $dti_req_ready
    
    # DTI response outputs (from INIU to requestor)
    set dti_rsp_outputs [get_ports -quiet "${node}_iniu_node_dti_rsp_porting_dti_rsp_rsp_*data* ${node}_iniu_node_dti_rsp_porting_dti_rsp_rsp_*keep* ${node}_iniu_node_dti_rsp_porting_dti_rsp_rsp_*tid* ${node}_iniu_node_dti_rsp_porting_dti_rsp_rsp_*last* ${node}_iniu_node_dti_rsp_porting_dti_rsp_rsp_*valid"]
    set_output_delay -max $SYS_IO_DELAY_NS -clock "${node}_sys_clk" $dti_rsp_outputs
    
    # DTI response ready input (from requestor to INIU)
    set dti_rsp_ready [get_ports -quiet "${node}_iniu_node_dti_rsp_porting_dti_rsp_rsp_*ready"]
    set_input_delay -max $SYS_IO_DELAY_NS -clock "${node}_sys_clk" $dti_rsp_ready
    
    # PCHANNEL control inputs
    set pchnl_in [get_ports -quiet "${node}_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_*req ${node}_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_*state"]
    set_input_delay -max $SYS_IO_DELAY_NS -clock "${node}_sys_clk" $pchnl_in
    
    # PCHANNEL control outputs
    set pchnl_out [get_ports -quiet "${node}_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_*accept ${node}_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_*active ${node}_iniu_node_pchnl_ctrl_porting_pchnl_ctrl_*deny"]
    set_output_delay -max $SYS_IO_DELAY_NS -clock "${node}_sys_clk" $pchnl_out
    
    # Timeout configuration (static, no timing)
    set timeout_port [get_ports -quiet "${node}_iniu_node_timeout_val_porting_timeout_val_timeout_val"]
    if {[llength $timeout_port] > 0} {
        set_false_path -from $timeout_port
    }
}

###############################################################################
# Section 9: Operating conditions
###############################################################################

# Derate for process, voltage, temperature variations
set_timing_derate -early 0.95
set_timing_derate -late 1.05

##############################################################################
# END OF FILE
##############################################################################
