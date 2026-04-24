##############################################################################
# STS NoC NIU 模块 SDC 约束
# 覆盖模块：sts_iniu_top (sts_iniu_sys + sts_iniu_noc)
#           sts_tniu_top (sts_tniu_sys)
#
# 时钟域说明：
#   clk_src       — 源端（AXI slave 侧），驱动 INIU clk_src 和 TNIU clk_src
#   clk_dst       — 目标端（NOC/APB 侧），驱动 INIU clk_dst 和 TNIU clk_dst
#   clk_dbg_timer — 调试时间戳同步时钟（通常绑定 clk_dst；若独立则需另行约束）
#
#   INIU: clk_src（AXI）↔ clk_dst（NOC Switch）完全异步，async FIFO 桥接
#   TNIU: clk_src（NOC Switch）↔ clk_dst（APB）完全异步，async FIFO 桥接
#
# TODO: 根据实际 SoC 时序预算填写时钟周期值（<FILL_IN> 为占位符）
##############################################################################

###############################################################################
# 1. 时钟定义
###############################################################################

create_clock -name clk_src \
    -period <FILL_IN_NS> \
    -waveform {0 <FILL_IN_HALF_NS>} \
    [get_ports clk_src]

create_clock -name clk_dst \
    -period <FILL_IN_NS> \
    -waveform {0 <FILL_IN_HALF_NS>} \
    [get_ports clk_dst]

# 若 clk_dbg_timer 独立于 clk_dst，则解注释以下行：
# create_clock -name clk_dbg_timer \
#     -period <FILL_IN_NS> \
#     [get_ports clk_dbg_timer]

###############################################################################
# 2. 时钟关系
###############################################################################

set_clock_groups -asynchronous \
    -group [get_clocks clk_src] \
    -group [get_clocks clk_dst]

# 若 clk_dbg_timer 独立，解注释以下（与 clk_src 和 clk_dst 均异步）：
# set_clock_groups -asynchronous \
#     -group [get_clocks clk_src] \
#     -group [get_clocks clk_dst] \
#     -group [get_clocks clk_dbg_timer]

###############################################################################
# 3. 异步 FIFO 跨域约束
#
#    INIU 请求方向：clk_src 写 → clk_dst 读（req_wptr 灰码同步）
#    INIU 响应方向：clk_dst 写 → clk_src 读（rsp_wptr 灰码同步）
#    TNIU 请求方向：clk_src 写 → clk_dst 读（req_wptr 灰码同步）
#    TNIU 响应方向：clk_dst 写 → clk_src 读（rsp_wptr 灰码同步）
###############################################################################

# INIU REQ — 写指针（clk_src → clk_dst 同步器）
set_max_delay -datapath_only <FILL_IN_MAX_DELAY_NS> \
    -from [get_pins -hierarchical -filter "name =~ *iniu_sys*/req_wptr_async*reg*/Q"] \
    -to   [get_pins -hierarchical -filter "name =~ *iniu_noc*/req_wptr*sync*reg*/D"]

# INIU REQ — 读指针（clk_dst → clk_src 同步器）
set_max_delay -datapath_only <FILL_IN_MAX_DELAY_NS> \
    -from [get_pins -hierarchical -filter "name =~ *iniu_noc*/req_rptr_async*reg*/Q"] \
    -to   [get_pins -hierarchical -filter "name =~ *iniu_sys*/req_rptr*sync*reg*/D"]

# INIU RSP — 写指针（clk_dst → clk_src 同步器）
set_max_delay -datapath_only <FILL_IN_MAX_DELAY_NS> \
    -from [get_pins -hierarchical -filter "name =~ *iniu_noc*/rsp_wptr_async*reg*/Q"] \
    -to   [get_pins -hierarchical -filter "name =~ *iniu_sys*/rsp_wptr*sync*reg*/D"]

# INIU RSP — 读指针（clk_src → clk_dst 同步器）
set_max_delay -datapath_only <FILL_IN_MAX_DELAY_NS> \
    -from [get_pins -hierarchical -filter "name =~ *iniu_sys*/rsp_rptr_async*reg*/Q"] \
    -to   [get_pins -hierarchical -filter "name =~ *iniu_noc*/rsp_rptr*sync*reg*/D"]

# TNIU REQ — 写指针（clk_src → clk_dst 同步器）
set_max_delay -datapath_only <FILL_IN_MAX_DELAY_NS> \
    -from [get_pins -hierarchical -filter "name =~ *tniu*/req_wptr_async*reg*/Q"] \
    -to   [get_pins -hierarchical -filter "name =~ *tniu*/req_wptr*sync*reg*/D"]

# TNIU REQ — 读指针（clk_dst → clk_src 同步器）
set_max_delay -datapath_only <FILL_IN_MAX_DELAY_NS> \
    -from [get_pins -hierarchical -filter "name =~ *tniu*/req_rptr_async*reg*/Q"] \
    -to   [get_pins -hierarchical -filter "name =~ *tniu*/req_rptr*sync*reg*/D"]

###############################################################################
# 4. CTI 跨域握手路径
#    CTI 事件/通道信号采用 req/ack 握手协议跨时钟域传输
###############################################################################

set_max_delay -datapath_only <FILL_IN_MAX_DELAY_NS> \
    -from [get_clocks clk_src] \
    -through [get_pins -hierarchical -filter "name =~ *cti*"] \
    -to   [get_clocks clk_dst]

set_max_delay -datapath_only <FILL_IN_MAX_DELAY_NS> \
    -from [get_clocks clk_dst] \
    -through [get_pins -hierarchical -filter "name =~ *cti*"] \
    -to   [get_clocks clk_src]

###############################################################################
# 5. 调试时间戳同步路径
###############################################################################

# dbg_timestamp 从 clk_src 经 clk_dbg_timer 域传递至 clk_dst
set_max_delay -datapath_only <FILL_IN_MAX_DELAY_NS> \
    -from [get_clocks clk_src] \
    -through [get_pins -hierarchical -filter "name =~ *dbg_timestamp*"] \
    -to   [get_clocks clk_dst]

###############################################################################
# 6. 复位约束
###############################################################################

set_false_path -from [get_ports rstn_src]
set_false_path -from [get_ports rstn_dst]
set_false_path -from [get_ports rstn_dbg_timer]

###############################################################################
# 7. 输入/输出延迟（占位值）
###############################################################################

# --- clk_src 侧：AXI4 Slave 接口 ---
set_input_delay  -max <FILL_IN_NS> -clock clk_src [get_ports sts_iniu_s_awvalid]
set_input_delay  -max <FILL_IN_NS> -clock clk_src [get_ports sts_iniu_s_awaddr*]
set_input_delay  -max <FILL_IN_NS> -clock clk_src [get_ports sts_iniu_s_awid*]
set_input_delay  -max <FILL_IN_NS> -clock clk_src [get_ports sts_iniu_s_awlen*]
set_input_delay  -max <FILL_IN_NS> -clock clk_src [get_ports sts_iniu_s_wvalid]
set_input_delay  -max <FILL_IN_NS> -clock clk_src [get_ports sts_iniu_s_wdata*]
set_input_delay  -max <FILL_IN_NS> -clock clk_src [get_ports sts_iniu_s_arvalid]
set_input_delay  -max <FILL_IN_NS> -clock clk_src [get_ports sts_iniu_s_araddr*]
set_output_delay -max <FILL_IN_NS> -clock clk_src [get_ports sts_iniu_s_awready]
set_output_delay -max <FILL_IN_NS> -clock clk_src [get_ports sts_iniu_s_wready]
set_output_delay -max <FILL_IN_NS> -clock clk_src [get_ports sts_iniu_s_bvalid]
set_output_delay -max <FILL_IN_NS> -clock clk_src [get_ports sts_iniu_s_rvalid]
set_output_delay -max <FILL_IN_NS> -clock clk_src [get_ports sts_iniu_s_rdata*]

# --- clk_dst 侧：NOC Switch 接口 ---
set_output_delay -max <FILL_IN_NS> -clock clk_dst [get_ports out_req_vld]
set_output_delay -max <FILL_IN_NS> -clock clk_dst [get_ports out_req_pld*]
set_input_delay  -max <FILL_IN_NS> -clock clk_dst [get_ports out_req_rdy]
set_input_delay  -max <FILL_IN_NS> -clock clk_dst [get_ports in_rsp_vld]
set_input_delay  -max <FILL_IN_NS> -clock clk_dst [get_ports in_rsp_pld*]
set_output_delay -max <FILL_IN_NS> -clock clk_dst [get_ports in_rsp_rdy]

# --- clk_dst 侧：APB Master 接口（TNIU）---
set_output_delay -max <FILL_IN_NS> -clock clk_dst [get_ports pmc_psel]
set_output_delay -max <FILL_IN_NS> -clock clk_dst [get_ports pmc_paddr*]
set_output_delay -max <FILL_IN_NS> -clock clk_dst [get_ports pmc_pwdata*]
set_input_delay  -max <FILL_IN_NS> -clock clk_dst [get_ports pmc_prdata*]
set_input_delay  -max <FILL_IN_NS> -clock clk_dst [get_ports pmc_pready]

# --- 静态配置 ---
set_false_path -from [get_ports node_id*]
set_false_path -from [get_ports dbg_timestamp_in*]
set_false_path -from [get_ports dbg_data_in*]

##############################################################################
# END OF FILE
##############################################################################
