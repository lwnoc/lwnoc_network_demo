##############################################################################
# Interrupt ring NoC 4x2 top-level SDC constraints
# Target wrapper: intr_ring_noc_4i2t
# Assumed top-level parameterization for this constraint set:
#   4 x INIU nodes, 2 x TNIU nodes
#   INTERRUPT_NUM = 4096 per NIU instance
#
# Clock plan:
#   all *_clk_sys_porting_clk_sys_clk : INIU/TNIU sys side @ 800 MHz  (1.250 ns)
#   all *_clk_noc_porting             : NOC/ring side     @ 2.000 GHz (0.500 ns)
#
# Assumption:
#   All sys clocks are synchronous to each other.
#   All noc clocks are synchronous to each other.
#   The sys domain and noc domain are fully asynchronous and only cross through:
#     - AFIFO gray-pointer / payload marker paths
#     - async_master_hub / niu_lp_hub low-power bridge paths
##############################################################################

###############################################################################
# 0. Timing budget constants
###############################################################################

set TOP_WRAPPER       intr_ring_noc_4i2t
set INIU_NUM_CFG      4
set TNIU_NUM_CFG      2
set INTERRUPT_NUM_CFG 4096

current_design $TOP_WRAPPER

set SYS_CLK_PERIOD_NS 1.250
set SYS_CLK_HALF_NS   0.625
set NOC_CLK_PERIOD_NS 0.500
set NOC_CLK_HALF_NS   0.250

# IO budget requirement from integration: use 60% of the receiving clock period.
set SYS_IO_DELAY_NS   [expr {$SYS_CLK_PERIOD_NS * 0.60}]
set NOC_IO_DELAY_NS   [expr {$NOC_CLK_PERIOD_NS * 0.60}]

# Constrain CDC datapath-only crossings to one noc clock period.
set CDC_MAX_DELAY_NS  $NOC_CLK_PERIOD_NS

###############################################################################
# 1. Clock definition
###############################################################################

create_clock -name sys_clk \
    -period $SYS_CLK_PERIOD_NS \
    -waveform [list 0.000 $SYS_CLK_HALF_NS] \
    [get_ports {iniu*_clk_sys_porting_clk_sys_clk tniu*_clk_sys_porting_clk_sys_clk}]

create_clock -name noc_clk \
    -period $NOC_CLK_PERIOD_NS \
    -waveform [list 0.000 $NOC_CLK_HALF_NS] \
    [get_ports {iniu*_clk_noc_porting tniu*_clk_noc_porting}]

###############################################################################
# 2. Clock relationship
###############################################################################

set_clock_groups -asynchronous \
    -group [get_clocks sys_clk] \
    -group [get_clocks noc_clk]

###############################################################################
# 3. Async FIFO CDC constraints
#    Note: instance/module names use the original RTL spelling "aync".
#    The generated hierarchy is: intr_ring_noc_4i2t/<node>/<iniu_sys|iniu_top|tniu_sys|tniu_top>/u_intr_async_fifo/...
###############################################################################

# INIU AFIFO: sys_clk write pointer -> noc_clk synchronizer
# set_max_delay -datapath_only $CDC_MAX_DELAY_NS \
#     -from [get_pins -hierarchical -filter "name =~ *iniu_sys*u_intr_async_fifo*async_wptr_async_marker*/Z"] \
#     -to   [get_pins -hierarchical -filter "name =~ *iniu_top*u_intr_async_fifo*rptr_sync_cell*/D"]

# INIU AFIFO: noc_clk read pointer -> sys_clk synchronizer
# set_max_delay -datapath_only $CDC_MAX_DELAY_NS \
#     -from [get_pins -hierarchical -filter "name =~ *iniu_top*u_intr_async_fifo*rd_rptr_async_primary_marker*/Z"] \
#     -to   [get_pins -hierarchical -filter "name =~ *iniu_sys*u_intr_async_fifo*rptr_sync_cell*/D"]

# TNIU AFIFO: noc_clk write pointer -> sys_clk synchronizer
# set_max_delay -datapath_only $CDC_MAX_DELAY_NS \
#     -from [get_pins -hierarchical -filter "name =~ *tniu_top*u_intr_async_fifo*async_wptr_async_marker*/Z"] \
#     -to   [get_pins -hierarchical -filter "name =~ *tniu_sys*u_intr_async_fifo*rptr_sync_cell*/D"]

# TNIU AFIFO: sys_clk read pointer -> noc_clk synchronizer
# set_max_delay -datapath_only $CDC_MAX_DELAY_NS \
#     -from [get_pins -hierarchical -filter "name =~ *tniu_sys*u_intr_async_fifo*rd_rptr_async_primary_marker*/Z"] \
#     -to   [get_pins -hierarchical -filter "name =~ *tniu_top*u_intr_async_fifo*rptr_sync_cell*/D"]

###############################################################################
# 4. Low-power bridge CDC constraints
###############################################################################

# Async master hub handshake: sys_clk -> noc_clk
set_max_delay -datapath_only $CDC_MAX_DELAY_NS \
    -from [get_clocks sys_clk] \
    -through [get_pins -hierarchical -filter "name =~ *async_master_hub*"] \
    -to   [get_clocks noc_clk]

# Async master hub handshake: noc_clk -> sys_clk
set_max_delay -datapath_only $CDC_MAX_DELAY_NS \
    -from [get_clocks noc_clk] \
    -through [get_pins -hierarchical -filter "name =~ *async_master_hub*"] \
    -to   [get_clocks sys_clk]

# NIU LP hub handshake: sys_clk -> noc_clk
set_max_delay -datapath_only $CDC_MAX_DELAY_NS \
    -from [get_clocks sys_clk] \
    -through [get_pins -hierarchical -filter "name =~ *niu_lp_hub*"] \
    -to   [get_clocks noc_clk]

# NIU LP hub handshake: noc_clk -> sys_clk
set_max_delay -datapath_only $CDC_MAX_DELAY_NS \
    -from [get_clocks noc_clk] \
    -through [get_pins -hierarchical -filter "name =~ *niu_lp_hub*"] \
    -to   [get_clocks sys_clk]

###############################################################################
# 5. Reset constraints
###############################################################################

set_false_path -from [get_ports {iniu*_rst_sys_n_porting_rst_sys_n_rst_n tniu*_rst_sys_n_porting_rst_sys_n_rst_n}] -to [get_clocks sys_clk]
set_false_path -from [get_ports {iniu*_rst_noc_n_porting tniu*_rst_noc_n_porting}] -to [get_clocks noc_clk]

###############################################################################
# 6. Input / output delay budget (60% of receiving clock period)
###############################################################################

# --- sys_clk side: INIU interrupt source + APB slave + sys LP hub ---
set_input_delay  -max $SYS_IO_DELAY_NS -clock sys_clk [get_ports iniu*_sys_v_interrupt*]
set_input_delay  -max $SYS_IO_DELAY_NS -clock sys_clk [get_ports iniu*_sys_apb*_*p_addr]
set_input_delay  -max $SYS_IO_DELAY_NS -clock sys_clk [get_ports iniu*_sys_apb*_*p_sel]
set_input_delay  -max $SYS_IO_DELAY_NS -clock sys_clk [get_ports iniu*_sys_apb*_*p_enable]
set_input_delay  -max $SYS_IO_DELAY_NS -clock sys_clk [get_ports iniu*_sys_apb*_*p_write]
set_input_delay  -max $SYS_IO_DELAY_NS -clock sys_clk [get_ports iniu*_sys_apb*_*p_wdata]
set_input_delay  -max $SYS_IO_DELAY_NS -clock sys_clk [get_ports iniu*_sys_lp_hub_porting*lp_hub_rx_req]

set_output_delay -max $SYS_IO_DELAY_NS -clock sys_clk [get_ports iniu*_sys_apb*_*p_ready]
set_output_delay -max $SYS_IO_DELAY_NS -clock sys_clk [get_ports iniu*_sys_apb*_*p_rdata]
set_output_delay -max $SYS_IO_DELAY_NS -clock sys_clk [get_ports iniu*_sys_apb*_*p_slverr]
set_output_delay -max $SYS_IO_DELAY_NS -clock sys_clk [get_ports iniu*_sys_lp_hub_porting*lp_hub_tx_req]

# --- sys_clk side: TNIU interrupt output + APB slave ---
set_input_delay  -max $SYS_IO_DELAY_NS -clock sys_clk [get_ports tniu*_sys_apb*_*p_addr]
set_input_delay  -max $SYS_IO_DELAY_NS -clock sys_clk [get_ports tniu*_sys_apb*_*p_sel]
set_input_delay  -max $SYS_IO_DELAY_NS -clock sys_clk [get_ports tniu*_sys_apb*_*p_enable]
set_input_delay  -max $SYS_IO_DELAY_NS -clock sys_clk [get_ports tniu*_sys_apb*_*p_write]
set_input_delay  -max $SYS_IO_DELAY_NS -clock sys_clk [get_ports tniu*_sys_apb*_*p_wdata]

set_output_delay -max $SYS_IO_DELAY_NS -clock sys_clk [get_ports tniu*_sys_v_interrupt*]
set_output_delay -max $SYS_IO_DELAY_NS -clock sys_clk [get_ports tniu*_sys_v_merge_interrupt*]
set_output_delay -max $SYS_IO_DELAY_NS -clock sys_clk [get_ports tniu*_sys_apb*_*p_ready]
set_output_delay -max $SYS_IO_DELAY_NS -clock sys_clk [get_ports tniu*_sys_apb*_*p_rdata]
set_output_delay -max $SYS_IO_DELAY_NS -clock sys_clk [get_ports tniu*_sys_apb*_*p_slverr]

# --- noc_clk side: exposed INIU ring local_rx outputs ---
set_input_delay  -max $NOC_IO_DELAY_NS -clock noc_clk [get_ports iniu*_ring_local_rx_porting*local_rx_local_rx_ready]

set_output_delay -max $NOC_IO_DELAY_NS -clock noc_clk [get_ports iniu*_ring_local_rx_porting*local_rx_local_rx_valid]
set_output_delay -max $NOC_IO_DELAY_NS -clock noc_clk [get_ports iniu*_ring_local_rx_porting*local_rx_local_rx_payload]
set_output_delay -max $NOC_IO_DELAY_NS -clock noc_clk [get_ports iniu*_ring_local_rx_porting*local_rx_local_rx_srcid]
set_output_delay -max $NOC_IO_DELAY_NS -clock noc_clk [get_ports iniu*_ring_local_rx_porting*local_rx_local_rx_tgtid]
set_output_delay -max $NOC_IO_DELAY_NS -clock noc_clk [get_ports iniu*_ring_local_rx_porting*local_rx_local_rx_qos]
set_output_delay -max $NOC_IO_DELAY_NS -clock noc_clk [get_ports iniu*_ring_local_rx_porting*local_rx_local_rx_last]

# --- noc_clk side: TNIU top LP hub + exposed TNIU ring local_tx inputs ---
set_input_delay  -max $NOC_IO_DELAY_NS -clock noc_clk [get_ports tniu*_top_lp_hub_porting*lp_hub_rx_req]
set_input_delay  -max $NOC_IO_DELAY_NS -clock noc_clk [get_ports tniu*_ring_local_tx_porting*local_tx_local_tx_valid]
set_input_delay  -max $NOC_IO_DELAY_NS -clock noc_clk [get_ports tniu*_ring_local_tx_porting*local_tx_local_tx_payload]
set_input_delay  -max $NOC_IO_DELAY_NS -clock noc_clk [get_ports tniu*_ring_local_tx_porting*local_tx_local_tx_srcid]
set_input_delay  -max $NOC_IO_DELAY_NS -clock noc_clk [get_ports tniu*_ring_local_tx_porting*local_tx_local_tx_tgtid]
set_input_delay  -max $NOC_IO_DELAY_NS -clock noc_clk [get_ports tniu*_ring_local_tx_porting*local_tx_local_tx_qos]
set_input_delay  -max $NOC_IO_DELAY_NS -clock noc_clk [get_ports tniu*_ring_local_tx_porting*local_tx_local_tx_last]

set_output_delay -max $NOC_IO_DELAY_NS -clock noc_clk [get_ports tniu*_top_lp_hub_porting*lp_hub_tx_req]
set_output_delay -max $NOC_IO_DELAY_NS -clock noc_clk [get_ports tniu*_ring_local_tx_porting*local_tx_local_tx_ready]

# --- static configuration ---
set_false_path -from [get_ports {*timeout_val*}]
set_false_path -from [get_ports {*iniu_src_id*}]
set_false_path -from [get_ports {*tniu_tgt_id*}]

##############################################################################
# END OF FILE
##############################################################################