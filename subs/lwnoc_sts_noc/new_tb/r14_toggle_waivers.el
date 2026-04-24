
// ========================================
// R14 Toggle Waivers — fullexclude-derived
// Auto-generated from R13 fullexclude_module.tgl
// Only for signals with ZERO toggle coverage (fully dead)
// ========================================

// --- Base_RegSpaceBase_cfg_reg_bank_table [clk_rst] ---
CHECKSUM: "1679471348 3804278089"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: Base_RegSpaceBase_cfg_reg_bank_table
Toggle clk "net clk"
Toggle rst_n "net rst_n"

// --- Base_cti_handle [clk_rst] ---
CHECKSUM: "1152322260 970643933"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: Base_cti_handle
Toggle clk_src "logic clk_src"
Toggle clk_dst "logic clk_dst"
Toggle rstn_src "logic rstn_src"
Toggle rstn_dst "logic rstn_dst"

// --- Base_cti_handle [cti_dead] ---
CHECKSUM: "1152322260 970643933"
ANNOTATION: "CTI event/channel ports: CTI subsystem tied-off in this topology"
MODULE: Base_cti_handle
Toggle cti_event_in "logic cti_event_in[7:0]"
Toggle cti_event_in_req "logic cti_event_in_req[7:0]"
Toggle cti_event_in_ack "logic cti_event_in_ack[7:0]"
Toggle cti_event_out "logic cti_event_out[7:0]"
Toggle cti_event_out_req "logic cti_event_out_req[7:0]"
Toggle cti_event_out_ack "logic cti_event_out_ack[7:0]"
Toggle cti_channel_in "logic cti_channel_in[7:0]"
Toggle cti_channel_in_req "logic cti_channel_in_req[7:0]"
Toggle cti_channel_in_ack "logic cti_channel_in_ack[7:0]"
Toggle cti_channel_out "logic cti_channel_out[7:0]"
Toggle cti_channel_out_req "logic cti_channel_out_req[7:0]"
Toggle cti_channel_out_ack "logic cti_channel_out_ack[7:0]"

// --- Base_lwnoc_flow_ctrl_chk [clk_rst] ---
CHECKSUM: "2312387679 947793373"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: Base_lwnoc_flow_ctrl_chk
Toggle in_pld.req.burst "logic in_pld.req.burst[1:0]"
Toggle out_pld.req.burst "logic out_pld.req.burst[1:0]"

// --- Base_lwnoc_flow_ctrl_chk [flow_ctrl_dead] ---
CHECKSUM: "2312387679 947793373"
ANNOTATION: "flow_ctrl_busy tied to 0 in DUT wrapper"
MODULE: Base_lwnoc_flow_ctrl_chk
Toggle flow_ctrl_busy "logic flow_ctrl_busy[1:0]"

// --- Base_lwnoc_flow_ctrl_chk [handshake_dead_path] ---
CHECKSUM: "2312387679 947793373"
ANNOTATION: "Handshake VLD/RDY: fully uncovered = on structurally dead path"
MODULE: Base_lwnoc_flow_ctrl_chk
Toggle in_vld "logic in_vld"
Toggle in_rdy "logic in_rdy"
Toggle out_vld "logic out_vld"
Toggle out_rdy "logic out_rdy"

// --- Base_sts_apb_stub_slave [clk_rst] ---
CHECKSUM: "3851199999 587280344"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: Base_sts_apb_stub_slave
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- Base_sts_iniu_axi_bundle [clk_rst] ---
CHECKSUM: "2905349387 332981546"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: Base_sts_iniu_axi_bundle
Toggle s_awburst "logic s_awburst[1:0]"
Toggle s_arburst "logic s_arburst[1:0]"
Toggle m_aw_pld.awburst "logic m_aw_pld.awburst[1:0]"
Toggle m_ar_pld.arburst "logic m_ar_pld.arburst[1:0]"

// --- Base_sts_iniu_axi_iniu [clk_rst] ---
CHECKSUM: "1437876289 1179372252"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: Base_sts_iniu_axi_iniu
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"
Toggle upstrm_aw_pld.awburst "logic upstrm_aw_pld.awburst[1:0]"
Toggle upstrm_ar_pld.arburst "logic upstrm_ar_pld.arburst[1:0]"
Toggle out_req_pld.req.burst "logic out_req_pld.req.burst[1:0]"
Toggle wr_req_pld.req.burst "logic wr_req_pld.req.burst[1:0]"
Toggle rd_req_pld.req.burst "logic rd_req_pld.req.burst[1:0]"
Toggle arb_pld.req.burst "logic arb_pld.req.burst[1:0]"

// --- Base_sts_iniu_axi_iniu [flow_ctrl_dead] ---
CHECKSUM: "1437876289 1179372252"
ANNOTATION: "flow_ctrl_busy tied to 0 in DUT wrapper"
MODULE: Base_sts_iniu_axi_iniu
Toggle flow_ctrl_busy "logic flow_ctrl_busy[1:0]"
Toggle flow_ctrl_update "logic flow_ctrl_update"

// --- Base_sts_iniu_axi_iniu [node_id_static] ---
CHECKSUM: "1437876289 1179372252"
ANNOTATION: "node_id is static configuration, fixed per instance"
MODULE: Base_sts_iniu_axi_iniu
Toggle node_id "logic node_id[7:0]"

// --- Base_sts_iniu_noc [clk_rst] ---
CHECKSUM: "3224443634 375832414"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: Base_sts_iniu_noc
Toggle clk_dst "logic clk_dst"
Toggle rst_n_dst "logic rst_n_dst"
Toggle clk_src "logic clk_src"
Toggle rst_n_src "logic rst_n_src"
Toggle req_s_pld.req.burst "logic req_s_pld.req.burst[1:0]"

// --- Base_sts_iniu_noc [cti_dead] ---
CHECKSUM: "3224443634 375832414"
ANNOTATION: "CTI event/channel ports: CTI subsystem tied-off in this topology"
MODULE: Base_sts_iniu_noc
Toggle cti_event_in "logic cti_event_in[7:0]"
Toggle cti_event_in_req "logic cti_event_in_req[7:0]"
Toggle cti_event_in_ack "logic cti_event_in_ack[7:0]"
Toggle cti_event_out "logic cti_event_out[7:0]"
Toggle cti_event_out_req "logic cti_event_out_req[7:0]"
Toggle cti_event_out_ack "logic cti_event_out_ack[7:0]"
Toggle cti_channel_in "logic cti_channel_in[7:0]"
Toggle cti_channel_in_req "logic cti_channel_in_req[7:0]"
Toggle cti_channel_in_ack "logic cti_channel_in_ack[7:0]"
Toggle cti_channel_out "logic cti_channel_out[7:0]"
Toggle cti_channel_out_req "logic cti_channel_out_req[7:0]"
Toggle cti_channel_out_ack "logic cti_channel_out_ack[7:0]"

// --- Base_sts_iniu_noc [debug_infra] ---
CHECKSUM: "3224443634 375832414"
ANNOTATION: "Debug timestamp/data infrastructure: tied-off or static in this config"
MODULE: Base_sts_iniu_noc
Toggle dbg_data_in "logic dbg_data_in[31:0]"
Toggle dbg_data_out "logic dbg_data_out[31:0]"
Toggle dbg_timestamp_in "logic dbg_timestamp_in[63:0]"
Toggle dbg_timestamp_out "logic dbg_timestamp_out[63:0]"

// --- Base_sts_iniu_noc [fifo_ptr_dead_path] ---
CHECKSUM: "3224443634 375832414"
ANNOTATION: "FIFO pointer: fully uncovered = FIFO on structurally dead path (CTI/debug)"
MODULE: Base_sts_iniu_noc
Toggle req_wptr_async "logic req_wptr_async[3:0]"
Toggle req_rptr_async "logic req_rptr_async[3:0]"
Toggle req_rptr_sync "logic req_rptr_sync[3:0]"
Toggle rsp_wptr_async "logic rsp_wptr_async[3:0]"
Toggle rsp_rptr_async "logic rsp_rptr_async[3:0]"
Toggle rsp_rptr_sync "logic rsp_rptr_sync[3:0]"

// --- Base_sts_iniu_noc [pld_sync_dead_path] ---
CHECKSUM: "3224443634 375832414"
ANNOTATION: "Packed payload sync register: fully uncovered = on structurally dead path (CTI/debug)"
MODULE: Base_sts_iniu_noc
Toggle req_pld_sync "logic req_pld_sync[120:0]"
Toggle rsp_pld_sync "logic rsp_pld_sync[66:0]"

// --- Base_sts_iniu_rd_channel [clk_rst] ---
CHECKSUM: "4115085934 3089047861"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: Base_sts_iniu_rd_channel
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"
Toggle upstrm_ar_pld.arburst "logic upstrm_ar_pld.arburst[1:0]"
Toggle out_req_pld.req.burst "logic out_req_pld.req.burst[1:0]"
Toggle ar_in_hold_pld.arburst "logic ar_in_hold_pld.arburst[1:0]"
Toggle ar_in_sel_pld.arburst "logic ar_in_sel_pld.arburst[1:0]"
Toggle fifo_in_ar_pld.req.burst "logic fifo_in_ar_pld.req.burst[1:0]"
Toggle fifo_out_ar_pld.req.burst "logic fifo_out_ar_pld.req.burst[1:0]"
Toggle ar_hold_pld.req.burst "logic ar_hold_pld.req.burst[1:0]"

// --- Base_sts_iniu_rd_channel [node_id_static] ---
CHECKSUM: "4115085934 3089047861"
ANNOTATION: "node_id is static configuration, fixed per instance"
MODULE: Base_sts_iniu_rd_channel
Toggle node_id "logic node_id[7:0]"

// --- Base_sts_iniu_sys [clk_rst] ---
CHECKSUM: "3047891155 2362043708"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: Base_sts_iniu_sys
Toggle clk_src "logic clk_src"
Toggle clk_dst "logic clk_dst"
Toggle rstn_src "logic rstn_src"
Toggle rstn_dst "logic rstn_dst"
Toggle s_awburst "logic s_awburst[1:0]"
Toggle s_arburst "logic s_arburst[1:0]"
Toggle bundle_aw_pld.awburst "logic bundle_aw_pld.awburst[1:0]"
Toggle bundle_ar_pld.arburst "logic bundle_ar_pld.arburst[1:0]"
Toggle req_pld_temp.req.burst "logic req_pld_temp.req.burst[1:0]"

// --- Base_sts_iniu_sys [cti_dead] ---
CHECKSUM: "3047891155 2362043708"
ANNOTATION: "CTI event/channel ports: CTI subsystem tied-off in this topology"
MODULE: Base_sts_iniu_sys
Toggle cti_event_in "logic cti_event_in[7:0]"
Toggle cti_event_in_req "logic cti_event_in_req[7:0]"
Toggle cti_event_in_ack "logic cti_event_in_ack[7:0]"
Toggle cti_event_out "logic cti_event_out[7:0]"
Toggle cti_event_out_req "logic cti_event_out_req[7:0]"
Toggle cti_event_out_ack "logic cti_event_out_ack[7:0]"
Toggle cti_channel_in "logic cti_channel_in[7:0]"
Toggle cti_channel_in_req "logic cti_channel_in_req[7:0]"
Toggle cti_channel_in_ack "logic cti_channel_in_ack[7:0]"
Toggle cti_channel_out "logic cti_channel_out[7:0]"
Toggle cti_channel_out_req "logic cti_channel_out_req[7:0]"
Toggle cti_channel_out_ack "logic cti_channel_out_ack[7:0]"

// --- Base_sts_iniu_sys [debug_infra] ---
CHECKSUM: "3047891155 2362043708"
ANNOTATION: "Debug timestamp/data infrastructure: tied-off or static in this config"
MODULE: Base_sts_iniu_sys
Toggle dbg_timestamp_in "logic dbg_timestamp_in[63:0]"
Toggle dbg_timestamp_out "logic dbg_timestamp_out[63:0]"
Toggle dbg_data_in "logic dbg_data_in[31:0]"
Toggle dbg_data_out "logic dbg_data_out[31:0]"

// --- Base_sts_iniu_sys [fifo_ptr_dead_path] ---
CHECKSUM: "3047891155 2362043708"
ANNOTATION: "FIFO pointer: fully uncovered = FIFO on structurally dead path (CTI/debug)"
MODULE: Base_sts_iniu_sys
Toggle req_wptr_async "logic req_wptr_async[3:0]"
Toggle req_rptr_async "logic req_rptr_async[3:0]"
Toggle req_rptr_sync "logic req_rptr_sync[3:0]"
Toggle rsp_wptr_async "logic rsp_wptr_async[3:0]"
Toggle rsp_rptr_async "logic rsp_rptr_async[3:0]"
Toggle rsp_rptr_sync "logic rsp_rptr_sync[3:0]"

// --- Base_sts_iniu_sys [flow_ctrl_dead] ---
CHECKSUM: "3047891155 2362043708"
ANNOTATION: "flow_ctrl_busy tied to 0 in DUT wrapper"
MODULE: Base_sts_iniu_sys
Toggle flow_ctrl_busy "logic flow_ctrl_busy[1:0]"
Toggle flow_ctrl_update "logic flow_ctrl_update"

// --- Base_sts_iniu_sys [node_id_static] ---
CHECKSUM: "3047891155 2362043708"
ANNOTATION: "node_id is static configuration, fixed per instance"
MODULE: Base_sts_iniu_sys
Toggle node_id "logic node_id[7:0]"

// --- Base_sts_iniu_sys [pld_sync_dead_path] ---
CHECKSUM: "3047891155 2362043708"
ANNOTATION: "Packed payload sync register: fully uncovered = on structurally dead path (CTI/debug)"
MODULE: Base_sts_iniu_sys
Toggle req_pld_sync "logic req_pld_sync[120:0]"
Toggle rsp_pld_sync "logic rsp_pld_sync[66:0]"

// --- Base_sts_iniu_top [clk_rst] ---
CHECKSUM: "172948656 3544573874"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: Base_sts_iniu_top
Toggle clk_src "logic clk_src"
Toggle clk_dst "logic clk_dst"
Toggle rstn_src "logic rstn_src"
Toggle rstn_dst "logic rstn_dst"
Toggle sts_iniu_s_awburst "logic sts_iniu_s_awburst[1:0]"
Toggle sts_iniu_s_arburst "logic sts_iniu_s_arburst[1:0]"
Toggle out_req_pld.req.burst "logic out_req_pld.req.burst[1:0]"

// --- Base_sts_iniu_top [cti_dead] ---
CHECKSUM: "172948656 3544573874"
ANNOTATION: "CTI event/channel ports: CTI subsystem tied-off in this topology"
MODULE: Base_sts_iniu_top
Toggle sys_cti_event_in "logic sys_cti_event_in[7:0]"
Toggle sys_cti_event_out "logic sys_cti_event_out[7:0]"
Toggle noc_cti_event_out "logic noc_cti_event_out[7:0]"
Toggle noc_cti_event_in "logic noc_cti_event_in[7:0]"
Toggle sys_cti_channel_in "logic sys_cti_channel_in[7:0]"
Toggle sys_cti_channel_out "logic sys_cti_channel_out[7:0]"
Toggle noc_cti_channel_out "logic noc_cti_channel_out[7:0]"
Toggle noc_cti_channel_in "logic noc_cti_channel_in[7:0]"

// --- Base_sts_iniu_top [debug_infra] ---
CHECKSUM: "172948656 3544573874"
ANNOTATION: "Debug timestamp/data infrastructure: tied-off or static in this config"
MODULE: Base_sts_iniu_top
Toggle dbg_timestamp_in "logic dbg_timestamp_in[63:0]"
Toggle dbg_timestamp_out "logic dbg_timestamp_out[63:0]"
Toggle dbg_data_in "logic dbg_data_in[31:0]"
Toggle dbg_data_out "logic dbg_data_out[31:0]"
Toggle dbg_timestamp_tmp "logic dbg_timestamp_tmp[63:0]"
Toggle dbg_data_tmp "logic dbg_data_tmp[31:0]"

// --- Base_sts_iniu_top [fifo_ptr_dead_path] ---
CHECKSUM: "172948656 3544573874"
ANNOTATION: "FIFO pointer: fully uncovered = FIFO on structurally dead path (CTI/debug)"
MODULE: Base_sts_iniu_top
Toggle tmp_req_wptr_async "logic tmp_req_wptr_async[3:0]"
Toggle tmp_req_rptr_async "logic tmp_req_rptr_async[3:0]"
Toggle tmp_req_rptr_sync "logic tmp_req_rptr_sync[3:0]"
Toggle tmp_rsp_wptr_async "logic tmp_rsp_wptr_async[3:0]"
Toggle tmp_rsp_rptr_async "logic tmp_rsp_rptr_async[3:0]"
Toggle tmp_rsp_rptr_sync "logic tmp_rsp_rptr_sync[3:0]"

// --- Base_sts_iniu_top [flow_ctrl_dead] ---
CHECKSUM: "172948656 3544573874"
ANNOTATION: "flow_ctrl_busy tied to 0 in DUT wrapper"
MODULE: Base_sts_iniu_top
Toggle flow_ctrl_busy "logic flow_ctrl_busy[1:0]"
Toggle flow_ctrl_update "logic flow_ctrl_update"

// --- Base_sts_iniu_top [node_id_static] ---
CHECKSUM: "172948656 3544573874"
ANNOTATION: "node_id is static configuration, fixed per instance"
MODULE: Base_sts_iniu_top
Toggle node_id "logic node_id[7:0]"

// --- Base_sts_iniu_top [pld_sync_dead_path] ---
CHECKSUM: "172948656 3544573874"
ANNOTATION: "Packed payload sync register: fully uncovered = on structurally dead path (CTI/debug)"
MODULE: Base_sts_iniu_top
Toggle tmp_req_pld_sync "logic tmp_req_pld_sync[120:0]"
Toggle tmp_rsp_pld_sync "logic tmp_rsp_pld_sync[66:0]"

// --- Base_sts_iniu_wr_channel [clk_rst] ---
CHECKSUM: "1611148050 3365547349"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: Base_sts_iniu_wr_channel
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"
Toggle upstrm_aw_pld.awburst "logic upstrm_aw_pld.awburst[1:0]"
Toggle out_req_pld.req.burst "logic out_req_pld.req.burst[1:0]"
Toggle aw_hold_pld.awburst "logic aw_hold_pld.awburst[1:0]"
Toggle fifo_out_aw_pld.awburst "logic fifo_out_aw_pld.awburst[1:0]"
Toggle merged_req_pld.req.burst "logic merged_req_pld.req.burst[1:0]"
Toggle rs_out_pld.req.burst "logic rs_out_pld.req.burst[1:0]"

// --- Base_sts_iniu_wr_channel [node_id_static] ---
CHECKSUM: "1611148050 3365547349"
ANNOTATION: "node_id is static configuration, fixed per instance"
MODULE: Base_sts_iniu_wr_channel
Toggle node_id "logic node_id[7:0]"

// --- Base_sts_noc_1iniu_3tniu_dut [clk_rst] ---
CHECKSUM: "2477951387 3040048395"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: Base_sts_noc_1iniu_3tniu_dut
Toggle clk_src "logic clk_src"
Toggle clk_dst "logic clk_dst"
Toggle clk_dbg_timer "logic clk_dbg_timer"
Toggle rstn_src "logic rstn_src"
Toggle rstn_dst "logic rstn_dst"
Toggle rstn_dbg_timer "logic rstn_dbg_timer"
Toggle s_awburst "logic s_awburst[1:0]"
Toggle s_arburst "logic s_arburst[1:0]"
Toggle iniu_req_pld.req.burst "logic iniu_req_pld.req.burst[1:0]"
Toggle tniu0_req_pld.req.burst "logic tniu0_req_pld.req.burst[1:0]"
Toggle tniu1_req_pld.req.burst "logic tniu1_req_pld.req.burst[1:0]"
Toggle tniu2_req_pld.req.burst "logic tniu2_req_pld.req.burst[1:0]"

// --- Base_sts_noc_1iniu_3tniu_dut [cti_dead] ---
CHECKSUM: "2477951387 3040048395"
ANNOTATION: "CTI event/channel ports: CTI subsystem tied-off in this topology"
MODULE: Base_sts_noc_1iniu_3tniu_dut
Toggle sys_cti_event_in "logic sys_cti_event_in[7:0]"
Toggle sys_cti_event_out "logic sys_cti_event_out[7:0]"
Toggle sys_cti_channel_in "logic sys_cti_channel_in[7:0]"
Toggle sys_cti_channel_out "logic sys_cti_channel_out[7:0]"
Toggle noc_cti_event_out_0 "logic noc_cti_event_out_0[7:0]"
Toggle noc_cti_event_out_1 "logic noc_cti_event_out_1[7:0]"
Toggle noc_cti_event_out_2 "logic noc_cti_event_out_2[7:0]"
Toggle noc_cti_channel_out_0 "logic noc_cti_channel_out_0[7:0]"
Toggle noc_cti_channel_out_1 "logic noc_cti_channel_out_1[7:0]"
Toggle noc_cti_channel_out_2 "logic noc_cti_channel_out_2[7:0]"
Toggle iniu_noc_cti_event_out "logic iniu_noc_cti_event_out[7:0]"
Toggle iniu_noc_cti_channel_out "logic iniu_noc_cti_channel_out[7:0]"

// --- Base_sts_noc_1iniu_3tniu_dut [debug_infra] ---
CHECKSUM: "2477951387 3040048395"
ANNOTATION: "Debug timestamp/data infrastructure: tied-off or static in this config"
MODULE: Base_sts_noc_1iniu_3tniu_dut
Toggle dbg_timestamp_in "logic dbg_timestamp_in[63:0]"
Toggle dbg_data_in "logic dbg_data_in[31:0]"
Toggle dbg_timestamp_out_0 "logic dbg_timestamp_out_0[63:0]"
Toggle dbg_timestamp_out_1 "logic dbg_timestamp_out_1[63:0]"
Toggle dbg_timestamp_out_2 "logic dbg_timestamp_out_2[63:0]"
Toggle dbg_data_out_0 "logic dbg_data_out_0[31:0]"
Toggle dbg_data_out_1 "logic dbg_data_out_1[31:0]"
Toggle dbg_data_out_2 "logic dbg_data_out_2[31:0]"

// --- Base_sts_noc_1iniu_3tniu_dut [flow_ctrl_dead] ---
CHECKSUM: "2477951387 3040048395"
ANNOTATION: "flow_ctrl_busy tied to 0 in DUT wrapper"
MODULE: Base_sts_noc_1iniu_3tniu_dut
Toggle flow_ctrl_busy "logic flow_ctrl_busy[1:0]"
Toggle flow_ctrl_update "logic flow_ctrl_update"

// --- Base_sts_noc_1iniu_3tniu_dut [node_id_static] ---
CHECKSUM: "2477951387 3040048395"
ANNOTATION: "node_id is static configuration, fixed per instance"
MODULE: Base_sts_noc_1iniu_3tniu_dut
Toggle node_id "logic node_id[7:0]"

// --- Base_sts_noc_1iniu_3tniu_dut [pprot_dead] ---
CHECKSUM: "2477951387 3040048395"
ANNOTATION: "APB protection field unused in STS (always 0)"
MODULE: Base_sts_noc_1iniu_3tniu_dut
Toggle pmc_pprot_0 "logic pmc_pprot_0[2:0]"
Toggle pprot_00 "logic pprot_00[2:0]"
Toggle pprot_01 "logic pprot_01[2:0]"
Toggle pmc_pprot_1 "logic pmc_pprot_1[2:0]"
Toggle pprot_10 "logic pprot_10[2:0]"
Toggle pprot_11 "logic pprot_11[2:0]"
Toggle pmc_pprot_2 "logic pmc_pprot_2[2:0]"
Toggle pprot_20 "logic pprot_20[2:0]"
Toggle pprot_21 "logic pprot_21[2:0]"

// --- Base_sts_noc_req_router_1to3 [clk_rst] ---
CHECKSUM: "3111419975 3722419792"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: Base_sts_noc_req_router_1to3
Toggle in_req_pld.req.burst "logic in_req_pld.req.burst[1:0]"
Toggle tniu0_req_pld.req.burst "logic tniu0_req_pld.req.burst[1:0]"
Toggle tniu1_req_pld.req.burst "logic tniu1_req_pld.req.burst[1:0]"
Toggle tniu2_req_pld.req.burst "logic tniu2_req_pld.req.burst[1:0]"

// --- Base_sts_noc_req_router_1to3 [handshake_dead_path] ---
CHECKSUM: "3111419975 3722419792"
ANNOTATION: "Request/response handshake: fully uncovered = on structurally dead path"
MODULE: Base_sts_noc_req_router_1to3
Toggle in_req_vld "logic in_req_vld"
Toggle in_req_rdy "logic in_req_rdy"

// --- Base_sts_noc_rsp_mux_3to1 [handshake_dead_path] ---
CHECKSUM: "617881430 2706392466"
ANNOTATION: "Request/response handshake: fully uncovered = on structurally dead path"
MODULE: Base_sts_noc_rsp_mux_3to1
Toggle out_rsp_vld "logic out_rsp_vld"
Toggle out_rsp_rdy "logic out_rsp_rdy"

// --- Base_sts_tniu_apb [clk_rst] ---
CHECKSUM: "1228083994 896648132"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: Base_sts_tniu_apb
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"
Toggle in_req_pld.req.burst "logic in_req_pld.req.burst[1:0]"
Toggle fifo_out_req_pld.req.burst "logic fifo_out_req_pld.req.burst[1:0]"
Toggle req_active_pld.req.burst "logic req_active_pld.req.burst[1:0]"

// --- Base_sts_tniu_apb [handshake_dead_path] ---
CHECKSUM: "1228083994 896648132"
ANNOTATION: "Request/response handshake: fully uncovered = on structurally dead path"
MODULE: Base_sts_tniu_apb
Toggle in_req_vld "logic in_req_vld"
Toggle in_req_rdy "logic in_req_rdy"
Toggle out_rsp_vld "logic out_rsp_vld"
Toggle out_rsp_rdy "logic out_rsp_rdy"

// --- Base_sts_tniu_apb [pprot_dead] ---
CHECKSUM: "1228083994 896648132"
ANNOTATION: "APB protection field unused in STS (always 0)"
MODULE: Base_sts_tniu_apb
Toggle pprot "logic pprot[2:0]"

// --- Base_sts_tniu_apb_dec [clk_rst] ---
CHECKSUM: "3191209264 219563717"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: Base_sts_tniu_apb_dec
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- Base_sts_tniu_apb_dec [pprot_dead] ---
CHECKSUM: "3191209264 219563717"
ANNOTATION: "APB protection field unused in STS (always 0)"
MODULE: Base_sts_tniu_apb_dec
Toggle s_pprot "logic s_pprot[2:0]"
Toggle m_pprot "logic m_pprot[2:0]"

// --- Base_sts_tniu_noc [clk_rst] ---
CHECKSUM: "911015456 3619931088"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: Base_sts_tniu_noc
Toggle clk_src "logic clk_src"
Toggle clk_dst "logic clk_dst"
Toggle rstn_src "logic rstn_src"
Toggle rstn_dst "logic rstn_dst"
Toggle in_req_pld.req.burst "logic in_req_pld.req.burst[1:0]"
Toggle req_apb_tniu_pld.req.burst "logic req_apb_tniu_pld.req.burst[1:0]"
Toggle req_tniu_sys_pld.req.burst "logic req_tniu_sys_pld.req.burst[1:0]"
Toggle req_async_fifo_pld.req.burst "logic req_async_fifo_pld.req.burst[1:0]"
Toggle req_async_fifo_pld_tmp.req.burst "logic req_async_fifo_pld_tmp.req.burst[1:0]"
Toggle req_afifo_pld.req.burst "logic req_afifo_pld.req.burst[1:0]"

// --- Base_sts_tniu_noc [cti_dead] ---
CHECKSUM: "911015456 3619931088"
ANNOTATION: "CTI event/channel ports: CTI subsystem tied-off in this topology"
MODULE: Base_sts_tniu_noc
Toggle cti_event_in "logic cti_event_in[7:0]"
Toggle cti_event_in_req "logic cti_event_in_req[7:0]"
Toggle cti_event_in_ack "logic cti_event_in_ack[7:0]"
Toggle cti_event_out "logic cti_event_out[7:0]"
Toggle cti_event_out_req "logic cti_event_out_req[7:0]"
Toggle cti_event_out_ack "logic cti_event_out_ack[7:0]"
Toggle cti_channel_in "logic cti_channel_in[7:0]"
Toggle cti_channel_in_req "logic cti_channel_in_req[7:0]"
Toggle cti_channel_in_ack "logic cti_channel_in_ack[7:0]"
Toggle cti_channel_out "logic cti_channel_out[7:0]"
Toggle cti_channel_out_req "logic cti_channel_out_req[7:0]"
Toggle cti_channel_out_ack "logic cti_channel_out_ack[7:0]"

// --- Base_sts_tniu_noc [debug_infra] ---
CHECKSUM: "911015456 3619931088"
ANNOTATION: "Debug timestamp/data infrastructure: tied-off or static in this config"
MODULE: Base_sts_tniu_noc
Toggle dbg_data_in "logic dbg_data_in[31:0]"
Toggle dbg_data_out "logic dbg_data_out[31:0]"
Toggle dbg_timestamp_in "logic dbg_timestamp_in[63:0]"
Toggle dbg_timestamp_out "logic dbg_timestamp_out[63:0]"
Toggle dbg_data_gate "logic dbg_data_gate[31:0]"
Toggle dbg_data_out_tmp "logic dbg_data_out_tmp[31:0]"
Toggle dbg_timestamp_tmp "logic dbg_timestamp_tmp[63:0]"

// --- Base_sts_tniu_noc [fifo_ptr_dead_path] ---
CHECKSUM: "911015456 3619931088"
ANNOTATION: "FIFO pointer: fully uncovered = FIFO on structurally dead path (CTI/debug)"
MODULE: Base_sts_tniu_noc
Toggle req_wptr_async "logic req_wptr_async[3:0]"
Toggle req_rptr_async "logic req_rptr_async[3:0]"
Toggle req_rptr_sync "logic req_rptr_sync[3:0]"
Toggle rsp_wptr_async "logic rsp_wptr_async[3:0]"
Toggle rsp_rptr_async "logic rsp_rptr_async[3:0]"
Toggle rsp_rptr_sync "logic rsp_rptr_sync[3:0]"

// --- Base_sts_tniu_noc [handshake_dead_path] ---
CHECKSUM: "911015456 3619931088"
ANNOTATION: "Request/response handshake: fully uncovered = on structurally dead path"
MODULE: Base_sts_tniu_noc
Toggle in_req_vld "logic in_req_vld"
Toggle in_req_rdy "logic in_req_rdy"
Toggle out_rsp_vld "logic out_rsp_vld"
Toggle out_rsp_rdy "logic out_rsp_rdy"

// --- Base_sts_tniu_noc [pld_sync_dead_path] ---
CHECKSUM: "911015456 3619931088"
ANNOTATION: "Packed payload sync register: fully uncovered = on structurally dead path (CTI/debug)"
MODULE: Base_sts_tniu_noc
Toggle req_pld_sync "logic req_pld_sync[120:0]"
Toggle rsp_pld_sync "logic rsp_pld_sync[66:0]"

// --- Base_sts_tniu_noc [pprot_dead] ---
CHECKSUM: "911015456 3619931088"
ANNOTATION: "APB protection field unused in STS (always 0)"
MODULE: Base_sts_tniu_noc
Toggle pprot "logic pprot[2:0]"
Toggle pprot_pre_dec "logic pprot_pre_dec[2:0]"
Toggle pprot_reg "logic pprot_reg[2:0]"
Toggle pprot_pre_sync "logic pprot_pre_sync[2:0]"
Toggle cmn_pprot "logic cmn_pprot[2:0]"

// --- Base_sts_tniu_sys [clk_rst] ---
CHECKSUM: "417801667 849917854"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: Base_sts_tniu_sys
Toggle clk_src "logic clk_src"
Toggle clk_dst "logic clk_dst"
Toggle clk_dbg_timer "logic clk_dbg_timer"
Toggle rstn_src "logic rstn_src"
Toggle rstn_dst "logic rstn_dst"
Toggle rstn_dbg_timer "logic rstn_dbg_timer"
Toggle req_apb_tniu_pld.req.burst "logic req_apb_tniu_pld.req.burst[1:0]"
Toggle req_apb_tniu_pld_tmp.req.burst "logic req_apb_tniu_pld_tmp.req.burst[1:0]"

// --- Base_sts_tniu_sys [cti_dead] ---
CHECKSUM: "417801667 849917854"
ANNOTATION: "CTI event/channel ports: CTI subsystem tied-off in this topology"
MODULE: Base_sts_tniu_sys
Toggle cti_event_in "logic cti_event_in[7:0]"
Toggle cti_event_in_req "logic cti_event_in_req[7:0]"
Toggle cti_event_in_ack "logic cti_event_in_ack[7:0]"
Toggle cti_event_out "logic cti_event_out[7:0]"
Toggle cti_event_out_req "logic cti_event_out_req[7:0]"
Toggle cti_event_out_ack "logic cti_event_out_ack[7:0]"
Toggle cti_channel_in "logic cti_channel_in[7:0]"
Toggle cti_channel_in_req "logic cti_channel_in_req[7:0]"
Toggle cti_channel_in_ack "logic cti_channel_in_ack[7:0]"
Toggle cti_channel_out "logic cti_channel_out[7:0]"
Toggle cti_channel_out_req "logic cti_channel_out_req[7:0]"
Toggle cti_channel_out_ack "logic cti_channel_out_ack[7:0]"

// --- Base_sts_tniu_sys [debug_infra] ---
CHECKSUM: "417801667 849917854"
ANNOTATION: "Debug timestamp/data infrastructure: tied-off or static in this config"
MODULE: Base_sts_tniu_sys
Toggle dbg_data_in "logic dbg_data_in[31:0]"
Toggle dbg_data_out "logic dbg_data_out[31:0]"
Toggle dbg_timestamp_in "logic dbg_timestamp_in[63:0]"
Toggle dbg_timestamp_out "logic dbg_timestamp_out[63:0]"
Toggle dbg_timestamp_tmp "logic dbg_timestamp_tmp[63:0]"

// --- Base_sts_tniu_sys [fifo_ptr_dead_path] ---
CHECKSUM: "417801667 849917854"
ANNOTATION: "FIFO pointer: fully uncovered = FIFO on structurally dead path (CTI/debug)"
MODULE: Base_sts_tniu_sys
Toggle req_wptr_async "logic req_wptr_async[3:0]"
Toggle req_rptr_async "logic req_rptr_async[3:0]"
Toggle req_rptr_sync "logic req_rptr_sync[3:0]"
Toggle rsp_wptr_async "logic rsp_wptr_async[3:0]"
Toggle rsp_rptr_async "logic rsp_rptr_async[3:0]"
Toggle rsp_rptr_sync "logic rsp_rptr_sync[3:0]"

// --- Base_sts_tniu_sys [pld_sync_dead_path] ---
CHECKSUM: "417801667 849917854"
ANNOTATION: "Packed payload sync register: fully uncovered = on structurally dead path (CTI/debug)"
MODULE: Base_sts_tniu_sys
Toggle req_pld_sync "logic req_pld_sync[120:0]"
Toggle rsp_pld_sync "logic rsp_pld_sync[66:0]"

// --- Base_sts_tniu_sys [pprot_dead] ---
CHECKSUM: "417801667 849917854"
ANNOTATION: "APB protection field unused in STS (always 0)"
MODULE: Base_sts_tniu_sys
Toggle pprot_0 "logic pprot_0[2:0]"
Toggle pprot_1 "logic pprot_1[2:0]"
Toggle pprot_pre_dec "logic pprot_pre_dec[2:0]"
Toggle cmn_pprot "logic cmn_pprot[2:0]"

// --- Base_sts_tniu_top [clk_rst] ---
CHECKSUM: "731806648 2237614106"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: Base_sts_tniu_top
Toggle clk_src "logic clk_src"
Toggle clk_dst "logic clk_dst"
Toggle clk_dbg_timer "logic clk_dbg_timer"
Toggle rstn_src "logic rstn_src"
Toggle rstn_dst "logic rstn_dst"
Toggle rstn_dbg_timer "logic rstn_dbg_timer"
Toggle in_req_pld.req.burst "logic in_req_pld.req.burst[1:0]"

// --- Base_sts_tniu_top [cti_dead] ---
CHECKSUM: "731806648 2237614106"
ANNOTATION: "CTI event/channel ports: CTI subsystem tied-off in this topology"
MODULE: Base_sts_tniu_top
Toggle sys_cti_event_in "logic sys_cti_event_in[7:0]"
Toggle sys_cti_event_out "logic sys_cti_event_out[7:0]"
Toggle noc_cti_event_out "logic noc_cti_event_out[7:0]"
Toggle noc_cti_event_in "logic noc_cti_event_in[7:0]"
Toggle sys_cti_channel_in "logic sys_cti_channel_in[7:0]"
Toggle sys_cti_channel_out "logic sys_cti_channel_out[7:0]"
Toggle noc_cti_channel_out "logic noc_cti_channel_out[7:0]"
Toggle noc_cti_channel_in "logic noc_cti_channel_in[7:0]"

// --- Base_sts_tniu_top [debug_infra] ---
CHECKSUM: "731806648 2237614106"
ANNOTATION: "Debug timestamp/data infrastructure: tied-off or static in this config"
MODULE: Base_sts_tniu_top
Toggle dbg_data_in "logic dbg_data_in[31:0]"
Toggle dbg_data_out "logic dbg_data_out[31:0]"
Toggle dbg_timestamp_in "logic dbg_timestamp_in[63:0]"
Toggle dbg_timestamp_out "logic dbg_timestamp_out[63:0]"
Toggle dbg_data_tmp "logic dbg_data_tmp[31:0]"
Toggle dbg_timestamp_tmp "logic dbg_timestamp_tmp[63:0]"

// --- Base_sts_tniu_top [fifo_ptr_dead_path] ---
CHECKSUM: "731806648 2237614106"
ANNOTATION: "FIFO pointer: fully uncovered = FIFO on structurally dead path (CTI/debug)"
MODULE: Base_sts_tniu_top
Toggle tmp_req_wptr_async "logic tmp_req_wptr_async[3:0]"
Toggle tmp_req_rptr_async "logic tmp_req_rptr_async[3:0]"
Toggle tmp_req_rptr_sync "logic tmp_req_rptr_sync[3:0]"
Toggle tmp_rsp_wptr_async "logic tmp_rsp_wptr_async[3:0]"
Toggle tmp_rsp_rptr_async "logic tmp_rsp_rptr_async[3:0]"
Toggle tmp_rsp_rptr_sync "logic tmp_rsp_rptr_sync[3:0]"

// --- Base_sts_tniu_top [handshake_dead_path] ---
CHECKSUM: "731806648 2237614106"
ANNOTATION: "Request/response handshake: fully uncovered = on structurally dead path"
MODULE: Base_sts_tniu_top
Toggle in_req_vld "logic in_req_vld"
Toggle in_req_rdy "logic in_req_rdy"
Toggle out_rsp_vld "logic out_rsp_vld"
Toggle out_rsp_rdy "logic out_rsp_rdy"

// --- Base_sts_tniu_top [pld_sync_dead_path] ---
CHECKSUM: "731806648 2237614106"
ANNOTATION: "Packed payload sync register: fully uncovered = on structurally dead path (CTI/debug)"
MODULE: Base_sts_tniu_top
Toggle tmp_req_pld_sync "logic tmp_req_pld_sync[120:0]"
Toggle tmp_rsp_pld_sync "logic tmp_rsp_pld_sync[66:0]"

// --- Base_sts_tniu_top [pprot_dead] ---
CHECKSUM: "731806648 2237614106"
ANNOTATION: "APB protection field unused in STS (always 0)"
MODULE: Base_sts_tniu_top
Toggle pmc_pprot "logic pmc_pprot[2:0]"
Toggle pprot_0 "logic pprot_0[2:0]"
Toggle pprot_1 "logic pprot_1[2:0]"

// --- age_matrix [clk_rst] ---
CHECKSUM: "58483087 1804361438"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: age_matrix
Toggle clk "net clk"
Toggle rst_n "net rst_n"

// --- apb2apb_async_bridge_qual [clk_rst] ---
CHECKSUM: "1033879960 218430297"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: apb2apb_async_bridge_qual
Toggle clk_s "logic clk_s"
Toggle rstn_s "logic rstn_s"
Toggle clk_m "logic clk_m"
Toggle rstn_m "logic rstn_m"

// --- apb2apb_async_bridge_qual [pprot_dead] ---
CHECKSUM: "1033879960 218430297"
ANNOTATION: "APB protection field unused in STS (always 0)"
MODULE: apb2apb_async_bridge_qual
Toggle pprot_s "logic pprot_s[2:0]"
Toggle pprot_m "logic pprot_m[2:0]"
Toggle pprot_s_d "logic pprot_s_d[2:0]"

// --- arb_matrix [mux_dead_path] ---
CHECKSUM: "2549856609 369054113"
ANNOTATION: "Mux select: fully uncovered = on structurally dead path"
MODULE: arb_matrix
Toggle select_onehot "logic select_onehot[1:0]"

// --- arb_vrp [clk_rst] ---
CHECKSUM: "1092840857 1381784214"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: arb_vrp
Toggle clk "net clk"
Toggle rst_n "net rst_n"

// --- arb_vrp [handshake_dead_path] ---
CHECKSUM: "1092840857 1381784214"
ANNOTATION: "Handshake VLD/RDY: fully uncovered = on structurally dead path"
MODULE: arb_vrp
Toggle m_vld "logic m_vld"

// --- arb_vrp [pld_port_dead_path] ---
CHECKSUM: "1092840857 1381784214"
ANNOTATION: "Packed payload port: fully uncovered = module on structurally dead path"
MODULE: arb_vrp
Toggle m_pld "logic m_pld[118:0]"

// --- cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=4 ) [clk_rst] ---
CHECKSUM: "3634631500 2334074456"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=4 )
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"
Toggle in_pld.req.burst "logic in_pld.req.burst[1:0]"
Toggle out_pld.req.burst "logic out_pld.req.burst[1:0]"

// --- cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=4 ) [fifo_status_dead_path] ---
CHECKSUM: "3634631500 2334074456"
ANNOTATION: "FIFO status: fully uncovered = FIFO on structurally dead path"
MODULE: cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=4 )
Toggle empty "logic empty"
Toggle full "logic full"

// --- cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=4 ) [handshake_dead_path] ---
CHECKSUM: "3634631500 2334074456"
ANNOTATION: "Handshake VLD/RDY: fully uncovered = on structurally dead path"
MODULE: cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=4 )
Toggle in_vld "logic in_vld"
Toggle in_rdy "logic in_rdy"
Toggle out_vld "logic out_vld"
Toggle out_rdy "logic out_rdy"

// --- cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=4 ) [clk_rst] ---
CHECKSUM: "3634631500 2816323313"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=4 )
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=4 ) [fifo_status_dead_path] ---
CHECKSUM: "3634631500 2816323313"
ANNOTATION: "FIFO status: fully uncovered = FIFO on structurally dead path"
MODULE: cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=4 )
Toggle empty "logic empty"
Toggle full "logic full"

// --- cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=4 ) [handshake_dead_path] ---
CHECKSUM: "3634631500 2816323313"
ANNOTATION: "Handshake VLD/RDY: fully uncovered = on structurally dead path"
MODULE: cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=4 )
Toggle in_vld "logic in_vld"
Toggle in_rdy "logic in_rdy"
Toggle out_vld "logic out_vld"
Toggle out_rdy "logic out_rdy"

// --- cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=4 ) [clk_rst] ---
CHECKSUM: "3634631500 3753797670"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=4 )
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=4 ) [fifo_status_dead_path] ---
CHECKSUM: "3634631500 3753797670"
ANNOTATION: "FIFO status: fully uncovered = FIFO on structurally dead path"
MODULE: cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=4 )
Toggle empty "logic empty"
Toggle full "logic full"

// --- cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=4 ) [handshake_dead_path] ---
CHECKSUM: "3634631500 3753797670"
ANNOTATION: "Handshake VLD/RDY: fully uncovered = on structurally dead path"
MODULE: cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=4 )
Toggle in_vld "logic in_vld"
Toggle in_rdy "logic in_rdy"
Toggle out_vld "logic out_vld"
Toggle out_rdy "logic out_rdy"

// --- cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=8 ) [clk_rst] ---
CHECKSUM: "3634631500 2431554784"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=8 )
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=8 ) [fifo_status_dead_path] ---
CHECKSUM: "3634631500 2431554784"
ANNOTATION: "FIFO status: fully uncovered = FIFO on structurally dead path"
MODULE: cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=8 )
Toggle empty "logic empty"
Toggle full "logic full"

// --- cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=8 ) [handshake_dead_path] ---
CHECKSUM: "3634631500 2431554784"
ANNOTATION: "Handshake VLD/RDY: fully uncovered = on structurally dead path"
MODULE: cmn_vrp_reg_fifo ( parameter ADDR_WIDTH=8 )
Toggle in_vld "logic in_vld"
Toggle in_rdy "logic in_rdy"
Toggle out_vld "logic out_vld"
Toggle out_rdy "logic out_rdy"

// --- fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_ [clk_rst] ---
CHECKSUM: "2269949625 3171455134"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_EMPTY_THRESHOLD=4,SYNC_STAGE=2,VT_TYPE=1 )
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"
Toggle clk_marker "logic clk_marker"

// --- fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_ [fifo_ptr_dead_path] ---
CHECKSUM: "2269949625 3171455134"
ANNOTATION: "FIFO pointer: fully uncovered = FIFO on structurally dead path (CTI/debug)"
MODULE: fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_EMPTY_THRESHOLD=4,SYNC_STAGE=2,VT_TYPE=1 )
Toggle wptr_async "logic wptr_async[3:0]"
Toggle rptr_async "logic rptr_async[3:0]"
Toggle rptr_sync "logic rptr_sync[3:0]"
Toggle rptr_sync_nxt "logic rptr_sync_nxt[3:0]"
Toggle rptr_async_nxt "logic rptr_async_nxt[3:0]"
Toggle rq2_wptr_sync1 "logic rq2_wptr_sync1[3:0]"
Toggle rq2_wptr_sync0 "logic rq2_wptr_sync0[3:0]"
Toggle rptr_sync_inner_SIZE_ONLY "logic rptr_sync_inner_SIZE_ONLY[3:0]"
Toggle rptr_async_inner_SIZE_ONLY "logic rptr_async_inner_SIZE_ONLY[3:0]"
Toggle rptr_sync_nxt_size_only "logic rptr_sync_nxt_size_only[3:0]"
Toggle rptr_async_nxt_size_only "logic rptr_async_nxt_size_only[3:0]"
Toggle rptr_sync_marker_SIZE_ONLY "logic rptr_sync_marker_SIZE_ONLY[3:0]"
Toggle rptr_async_marker_SIZE_ONLY "logic rptr_async_marker_SIZE_ONLY[3:0]"
Toggle wptr_async_marker "logic wptr_async_marker[3:0]"

// --- fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_ [fifo_status_dead_path] ---
CHECKSUM: "2269949625 3171455134"
ANNOTATION: "FIFO status: fully uncovered = FIFO on structurally dead path"
MODULE: fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_EMPTY_THRESHOLD=4,SYNC_STAGE=2,VT_TYPE=1 )
Toggle almost_empty "logic almost_empty"
Toggle empty "logic empty"

// --- fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_ [handshake_dead_path] ---
CHECKSUM: "2269949625 3171455134"
ANNOTATION: "Handshake VLD/RDY: fully uncovered = on structurally dead path"
MODULE: fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_EMPTY_THRESHOLD=4,SYNC_STAGE=2,VT_TYPE=1 )
Toggle m_vld "logic m_vld"
Toggle m_rdy "logic m_rdy"

// --- fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_ [pld_port_dead_path] ---
CHECKSUM: "2269949625 3171455134"
ANNOTATION: "Packed payload port: fully uncovered = module on structurally dead path"
MODULE: fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_EMPTY_THRESHOLD=4,SYNC_STAGE=2,VT_TYPE=1 )
Toggle m_pld "logic m_pld[119:0]"

// --- fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_ [pld_sync_dead_path] ---
CHECKSUM: "2269949625 3171455134"
ANNOTATION: "Packed payload sync register: fully uncovered = on structurally dead path (CTI/debug)"
MODULE: fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_EMPTY_THRESHOLD=4,SYNC_STAGE=2,VT_TYPE=1 )
Toggle pld_sync "logic pld_sync[120:0]"
Toggle pld_sync_marker "logic pld_sync_marker[120:0]"

// --- fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_C [clk_rst] ---
CHECKSUM: "2269949625 1451461867"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_EMPTY_THRESHOLD=4,SYNC_STAGE=2,VT_TYPE=1 )
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"
Toggle clk_marker "logic clk_marker"

// --- fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_C [fifo_ptr_dead_path] ---
CHECKSUM: "2269949625 1451461867"
ANNOTATION: "FIFO pointer: fully uncovered = FIFO on structurally dead path (CTI/debug)"
MODULE: fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_EMPTY_THRESHOLD=4,SYNC_STAGE=2,VT_TYPE=1 )
Toggle wptr_async "logic wptr_async[3:0]"
Toggle rptr_async "logic rptr_async[3:0]"
Toggle rptr_sync "logic rptr_sync[3:0]"
Toggle rptr_sync_nxt "logic rptr_sync_nxt[3:0]"
Toggle rptr_async_nxt "logic rptr_async_nxt[3:0]"
Toggle rq2_wptr_sync1 "logic rq2_wptr_sync1[3:0]"
Toggle rq2_wptr_sync0 "logic rq2_wptr_sync0[3:0]"
Toggle rptr_sync_inner_SIZE_ONLY "logic rptr_sync_inner_SIZE_ONLY[3:0]"
Toggle rptr_async_inner_SIZE_ONLY "logic rptr_async_inner_SIZE_ONLY[3:0]"
Toggle rptr_sync_nxt_size_only "logic rptr_sync_nxt_size_only[3:0]"
Toggle rptr_async_nxt_size_only "logic rptr_async_nxt_size_only[3:0]"
Toggle rptr_sync_marker_SIZE_ONLY "logic rptr_sync_marker_SIZE_ONLY[3:0]"
Toggle rptr_async_marker_SIZE_ONLY "logic rptr_async_marker_SIZE_ONLY[3:0]"
Toggle wptr_async_marker "logic wptr_async_marker[3:0]"

// --- fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_C [fifo_status_dead_path] ---
CHECKSUM: "2269949625 1451461867"
ANNOTATION: "FIFO status: fully uncovered = FIFO on structurally dead path"
MODULE: fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_EMPTY_THRESHOLD=4,SYNC_STAGE=2,VT_TYPE=1 )
Toggle almost_empty "logic almost_empty"
Toggle empty "logic empty"

// --- fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_C [handshake_dead_path] ---
CHECKSUM: "2269949625 1451461867"
ANNOTATION: "Handshake VLD/RDY: fully uncovered = on structurally dead path"
MODULE: fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_EMPTY_THRESHOLD=4,SYNC_STAGE=2,VT_TYPE=1 )
Toggle m_vld "logic m_vld"
Toggle m_rdy "logic m_rdy"

// --- fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_C [pld_port_dead_path] ---
CHECKSUM: "2269949625 1451461867"
ANNOTATION: "Packed payload port: fully uncovered = module on structurally dead path"
MODULE: fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_EMPTY_THRESHOLD=4,SYNC_STAGE=2,VT_TYPE=1 )
Toggle m_pld "logic m_pld[65:0]"

// --- fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_C [pld_sync_dead_path] ---
CHECKSUM: "2269949625 1451461867"
ANNOTATION: "Packed payload sync register: fully uncovered = on structurally dead path (CTI/debug)"
MODULE: fcip_afifo_mst ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_EMPTY_THRESHOLD=4,SYNC_STAGE=2,VT_TYPE=1 )
Toggle pld_sync "logic pld_sync[66:0]"
Toggle pld_sync_marker "logic pld_sync_marker[66:0]"

// --- fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_ [clk_rst] ---
CHECKSUM: "2851294776 2602238882"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_FULL_THRESHOLD=12,SYNC_STAGE=2,VT_TYPE=1 )
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"
Toggle clk_marker "logic clk_marker"

// --- fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_ [fifo_ptr_dead_path] ---
CHECKSUM: "2851294776 2602238882"
ANNOTATION: "FIFO pointer: fully uncovered = FIFO on structurally dead path (CTI/debug)"
MODULE: fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_FULL_THRESHOLD=12,SYNC_STAGE=2,VT_TYPE=1 )
Toggle wptr_async "logic wptr_async[3:0]"
Toggle rptr_async "logic rptr_async[3:0]"
Toggle rptr_sync "logic rptr_sync[3:0]"
Toggle wptr_sync "logic wptr_sync[3:0]"
Toggle wptr_sync_nxt "logic wptr_sync_nxt[3:0]"
Toggle wptr_async_nxt "logic wptr_async_nxt[3:0]"
Toggle wq2_rptr_sync0 "logic wq2_rptr_sync0[3:0]"
Toggle wq2_rptr_sync1 "logic wq2_rptr_sync1[3:0]"
Toggle wptr_async_inner_SIZE_ONLY "logic wptr_async_inner_SIZE_ONLY[3:0]"
Toggle wptr_async_nxt_size_only "logic wptr_async_nxt_size_only[3:0]"
Toggle rptr_sync_marker "logic rptr_sync_marker[3:0]"
Toggle rptr_async_marker "logic rptr_async_marker[3:0]"
Toggle wptr_async_marker_SIZE_ONLY "logic wptr_async_marker_SIZE_ONLY[3:0]"

// --- fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_ [fifo_status_dead_path] ---
CHECKSUM: "2851294776 2602238882"
ANNOTATION: "FIFO status: fully uncovered = FIFO on structurally dead path"
MODULE: fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_FULL_THRESHOLD=12,SYNC_STAGE=2,VT_TYPE=1 )
Toggle almost_full "logic almost_full"
Toggle full "logic full"

// --- fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_ [handshake_dead_path] ---
CHECKSUM: "2851294776 2602238882"
ANNOTATION: "Handshake VLD/RDY: fully uncovered = on structurally dead path"
MODULE: fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_FULL_THRESHOLD=12,SYNC_STAGE=2,VT_TYPE=1 )
Toggle s_vld "logic s_vld"
Toggle s_rdy "logic s_rdy"

// --- fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_ [mux_dead_path] ---
CHECKSUM: "2851294776 2602238882"
ANNOTATION: "Mux select: fully uncovered = on structurally dead path"
MODULE: fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_FULL_THRESHOLD=12,SYNC_STAGE=2,VT_TYPE=1 )
Toggle select_onehot "logic select_onehot[3:0]"

// --- fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_ [pld_port_dead_path] ---
CHECKSUM: "2851294776 2602238882"
ANNOTATION: "Packed payload port: fully uncovered = module on structurally dead path"
MODULE: fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_FULL_THRESHOLD=12,SYNC_STAGE=2,VT_TYPE=1 )
Toggle s_pld "logic s_pld[119:0]"

// --- fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_ [pld_sync_dead_path] ---
CHECKSUM: "2851294776 2602238882"
ANNOTATION: "Packed payload sync register: fully uncovered = on structurally dead path (CTI/debug)"
MODULE: fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=120,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_FULL_THRESHOLD=12,SYNC_STAGE=2,VT_TYPE=1 )
Toggle pld_sync "logic pld_sync[120:0]"
Toggle pld_sync_marker "logic pld_sync_marker[120:0]"

// --- fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_C [clk_rst] ---
CHECKSUM: "2851294776 2451114303"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_FULL_THRESHOLD=12,SYNC_STAGE=2,VT_TYPE=1 )
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"
Toggle clk_marker "logic clk_marker"

// --- fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_C [fifo_ptr_dead_path] ---
CHECKSUM: "2851294776 2451114303"
ANNOTATION: "FIFO pointer: fully uncovered = FIFO on structurally dead path (CTI/debug)"
MODULE: fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_FULL_THRESHOLD=12,SYNC_STAGE=2,VT_TYPE=1 )
Toggle wptr_async "logic wptr_async[3:0]"
Toggle rptr_async "logic rptr_async[3:0]"
Toggle rptr_sync "logic rptr_sync[3:0]"
Toggle wptr_sync "logic wptr_sync[3:0]"
Toggle wptr_sync_nxt "logic wptr_sync_nxt[3:0]"
Toggle wptr_async_nxt "logic wptr_async_nxt[3:0]"
Toggle wq2_rptr_sync0 "logic wq2_rptr_sync0[3:0]"
Toggle wq2_rptr_sync1 "logic wq2_rptr_sync1[3:0]"
Toggle wptr_async_inner_SIZE_ONLY "logic wptr_async_inner_SIZE_ONLY[3:0]"
Toggle wptr_async_nxt_size_only "logic wptr_async_nxt_size_only[3:0]"
Toggle rptr_sync_marker "logic rptr_sync_marker[3:0]"
Toggle rptr_async_marker "logic rptr_async_marker[3:0]"
Toggle wptr_async_marker_SIZE_ONLY "logic wptr_async_marker_SIZE_ONLY[3:0]"

// --- fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_C [fifo_status_dead_path] ---
CHECKSUM: "2851294776 2451114303"
ANNOTATION: "FIFO status: fully uncovered = FIFO on structurally dead path"
MODULE: fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_FULL_THRESHOLD=12,SYNC_STAGE=2,VT_TYPE=1 )
Toggle almost_full "logic almost_full"
Toggle full "logic full"

// --- fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_C [handshake_dead_path] ---
CHECKSUM: "2851294776 2451114303"
ANNOTATION: "Handshake VLD/RDY: fully uncovered = on structurally dead path"
MODULE: fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_FULL_THRESHOLD=12,SYNC_STAGE=2,VT_TYPE=1 )
Toggle s_vld "logic s_vld"
Toggle s_rdy "logic s_rdy"

// --- fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_C [mux_dead_path] ---
CHECKSUM: "2851294776 2451114303"
ANNOTATION: "Mux select: fully uncovered = on structurally dead path"
MODULE: fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_FULL_THRESHOLD=12,SYNC_STAGE=2,VT_TYPE=1 )
Toggle select_onehot "logic select_onehot[3:0]"

// --- fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_C [pld_port_dead_path] ---
CHECKSUM: "2851294776 2451114303"
ANNOTATION: "Packed payload port: fully uncovered = module on structurally dead path"
MODULE: fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_FULL_THRESHOLD=12,SYNC_STAGE=2,VT_TYPE=1 )
Toggle s_pld "logic s_pld[65:0]"

// --- fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_C [pld_sync_dead_path] ---
CHECKSUM: "2851294776 2451114303"
ANNOTATION: "Packed payload sync register: fully uncovered = on structurally dead path (CTI/debug)"
MODULE: fcip_afifo_slv ( parameter FIFO_DEPTH=4,DATA_WIDTH=66,AUTO_CLEAR_EN=1,THRESHOLD_EN=0,ALMOST_FULL_THRESHOLD=12,SYNC_STAGE=2,VT_TYPE=1 )
Toggle pld_sync "logic pld_sync[66:0]"
Toggle pld_sync_marker "logic pld_sync_marker[66:0]"

// --- fcip_arb_vrp [clk_rst] ---
CHECKSUM: "3751832720 3046539970"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: fcip_arb_vrp
Toggle clk "net clk"
Toggle rst_n "net rst_n"

// --- fcip_arb_vrp [handshake_dead_path] ---
CHECKSUM: "3751832720 3046539970"
ANNOTATION: "Handshake VLD/RDY: fully uncovered = on structurally dead path"
MODULE: fcip_arb_vrp
Toggle m_vld "logic m_vld"

// --- fcip_arb_vrp [pld_port_dead_path] ---
CHECKSUM: "3751832720 3046539970"
ANNOTATION: "Packed payload port: fully uncovered = module on structurally dead path"
MODULE: fcip_arb_vrp
Toggle m_pld "logic m_pld[64:0]"

// --- fcip_data_pipe ( parameter DATA_WIDTH=2,PIPE_STAGE=1,VT_TYPE [clk_rst] ---
CHECKSUM: "3222869270 1361027238"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: fcip_data_pipe ( parameter DATA_WIDTH=2,PIPE_STAGE=1,VT_TYPE=0 )
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- fcip_data_pipe ( parameter DATA_WIDTH=4,PIPE_STAGE=1,VT_TYPE [clk_rst] ---
CHECKSUM: "3222869270 3388636040"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: fcip_data_pipe ( parameter DATA_WIDTH=4,PIPE_STAGE=1,VT_TYPE=0 )
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- fcip_fix_arb [clk_rst] ---
CHECKSUM: "4123955945 1486429461"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: fcip_fix_arb
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- fcip_fix_arb [handshake_dead_path] ---
CHECKSUM: "4123955945 1486429461"
ANNOTATION: "Handshake VLD/RDY: fully uncovered = on structurally dead path"
MODULE: fcip_fix_arb
Toggle s_vld "logic s_vld"
Toggle s_rdy "logic s_rdy"
Toggle m_vld "logic m_vld"
Toggle m_rdy "logic m_rdy"

// --- fcip_fix_arb [pld_port_dead_path] ---
CHECKSUM: "4123955945 1486429461"
ANNOTATION: "Packed payload port: fully uncovered = module on structurally dead path"
MODULE: fcip_fix_arb
Toggle s_pld "logic s_pld[120:0]"
Toggle m_pld "logic m_pld[120:0]"

// --- fcip_fix_arb [clk_rst] ---
CHECKSUM: "4123955945 2689351422"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: fcip_fix_arb
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- fcip_fix_arb [handshake_dead_path] ---
CHECKSUM: "4123955945 2689351422"
ANNOTATION: "Handshake VLD/RDY: fully uncovered = on structurally dead path"
MODULE: fcip_fix_arb
Toggle s_vld "logic s_vld"
Toggle s_rdy "logic s_rdy"
Toggle m_vld "logic m_vld"
Toggle m_rdy "logic m_rdy"

// --- fcip_fix_arb [pld_port_dead_path] ---
CHECKSUM: "4123955945 2689351422"
ANNOTATION: "Packed payload port: fully uncovered = module on structurally dead path"
MODULE: fcip_fix_arb
Toggle s_pld "logic s_pld[66:0]"
Toggle m_pld "logic m_pld[66:0]"

// --- fcip_grant_gen_rr [clk_rst] ---
CHECKSUM: "1187064235 1267900043"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: fcip_grant_gen_rr
Toggle clk "net clk"
Toggle rst_n "net rst_n"

// --- fcip_real_mux_onehot ( parameter WIDTH=2,PLD_WIDTH=65 ) [mux_dead_path] ---
CHECKSUM: "2636750315 2089823026"
ANNOTATION: "Mux select: fully uncovered = on structurally dead path"
MODULE: fcip_real_mux_onehot ( parameter WIDTH=2,PLD_WIDTH=65 )
Toggle select_onehot "net select_onehot[1:0]"

// --- fcip_reg_slice ( parameter RS_TYPE=0 ) [clk_rst] ---
CHECKSUM: "3424757416 1716814886"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: fcip_reg_slice ( parameter RS_TYPE=0 )
Toggle clk "net clk"
Toggle rst_n "net rst_n"
Toggle s_pld.req.burst "logic s_pld.req.burst[1:0]"
Toggle m_pld.req.burst "logic m_pld.req.burst[1:0]"

// --- fcip_reg_slice ( parameter RS_TYPE=0 ) [handshake_dead_path] ---
CHECKSUM: "3424757416 1716814886"
ANNOTATION: "Handshake VLD/RDY: fully uncovered = on structurally dead path"
MODULE: fcip_reg_slice ( parameter RS_TYPE=0 )
Toggle s_vld "logic s_vld"
Toggle s_rdy "logic s_rdy"
Toggle m_vld "logic m_vld"
Toggle m_rdy "logic m_rdy"

// --- fcip_reg_slice ( parameter RS_TYPE=0 ) [pld_port_dead_path] ---
CHECKSUM: "3424757416 1716814886"
ANNOTATION: "Packed payload port: fully uncovered = module on structurally dead path"
MODULE: fcip_reg_slice ( parameter RS_TYPE=0 )
Toggle s_pld.req.last "logic s_pld.req.last"
Toggle s_pld.req.strb "logic s_pld.req.strb[3:0]"
Toggle s_pld.req.data "logic s_pld.req.data[31:0]"
Toggle s_pld.req.user "logic s_pld.req.user[7:0]"
Toggle s_pld.req.lock "logic s_pld.req.lock"
Toggle s_pld.req.len "logic s_pld.req.len[5:0]"
Toggle s_pld.req.size "logic s_pld.req.size[2:0]"
Toggle s_pld.req.addr "logic s_pld.req.addr[31:0]"
Toggle s_pld.cmn.qos "logic s_pld.cmn.qos[3:0]"
Toggle s_pld.cmn.opcode "logic s_pld.cmn.opcode[1:0]"
Toggle s_pld.cmn.tgt_id "logic s_pld.cmn.tgt_id[7:0]"
Toggle s_pld.cmn.txn_id "logic s_pld.cmn.txn_id[7:0]"
Toggle s_pld.cmn.src_id "logic s_pld.cmn.src_id[7:0]"
Toggle m_pld.req.last "logic m_pld.req.last"
Toggle m_pld.req.strb "logic m_pld.req.strb[3:0]"
Toggle m_pld.req.data "logic m_pld.req.data[31:0]"
Toggle m_pld.req.user "logic m_pld.req.user[7:0]"
Toggle m_pld.req.lock "logic m_pld.req.lock"
Toggle m_pld.req.len "logic m_pld.req.len[5:0]"
Toggle m_pld.req.size "logic m_pld.req.size[2:0]"
Toggle m_pld.req.addr "logic m_pld.req.addr[31:0]"
Toggle m_pld.cmn.qos "logic m_pld.cmn.qos[3:0]"
Toggle m_pld.cmn.opcode "logic m_pld.cmn.opcode[1:0]"
Toggle m_pld.cmn.tgt_id "logic m_pld.cmn.tgt_id[7:0]"
Toggle m_pld.cmn.txn_id "logic m_pld.cmn.txn_id[7:0]"
Toggle m_pld.cmn.src_id "logic m_pld.cmn.src_id[7:0]"

// --- fcip_reg_slice ( parameter RS_TYPE=1 ) [clk_rst] ---
CHECKSUM: "3424757416 2953773372"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: fcip_reg_slice ( parameter RS_TYPE=1 )
Toggle clk "net clk"
Toggle rst_n "net rst_n"

// --- fcip_reg_slice ( parameter RS_TYPE=1 ) [handshake_dead_path] ---
CHECKSUM: "3424757416 2953773372"
ANNOTATION: "Handshake VLD/RDY: fully uncovered = on structurally dead path"
MODULE: fcip_reg_slice ( parameter RS_TYPE=1 )
Toggle s_vld "logic s_vld"
Toggle s_rdy "logic s_rdy"
Toggle m_vld "logic m_vld"
Toggle m_rdy "logic m_rdy"

// --- fcip_reg_slice ( parameter RS_TYPE=1 ) [pld_port_dead_path] ---
CHECKSUM: "3424757416 2953773372"
ANNOTATION: "Packed payload port: fully uncovered = module on structurally dead path"
MODULE: fcip_reg_slice ( parameter RS_TYPE=1 )
Toggle s_pld "logic s_pld[65:0]"
Toggle m_pld "logic m_pld[65:0]"

// --- fcip_req_rsp_afifo_mst ( parameter SYNC_STAGE=2,FIFO_DEPTH=4 [clk_rst] ---
CHECKSUM: "1707270697 299175842"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: fcip_req_rsp_afifo_mst ( parameter SYNC_STAGE=2,FIFO_DEPTH=4,AUTO_CLEAR_EN=1,REQ_WIDTH=119,RSP_WIDTH=65,VT_TYPE=1 )
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- fcip_req_rsp_afifo_mst ( parameter SYNC_STAGE=2,FIFO_DEPTH=4 [fifo_ptr_dead_path] ---
CHECKSUM: "1707270697 299175842"
ANNOTATION: "FIFO pointer: fully uncovered = FIFO on structurally dead path (CTI/debug)"
MODULE: fcip_req_rsp_afifo_mst ( parameter SYNC_STAGE=2,FIFO_DEPTH=4,AUTO_CLEAR_EN=1,REQ_WIDTH=119,RSP_WIDTH=65,VT_TYPE=1 )
Toggle req_wptr_async "logic req_wptr_async[3:0]"
Toggle req_rptr_async "logic req_rptr_async[3:0]"
Toggle req_rptr_sync "logic req_rptr_sync[3:0]"
Toggle rsp_wptr_async "logic rsp_wptr_async[3:0]"
Toggle rsp_rptr_async "logic rsp_rptr_async[3:0]"
Toggle rsp_rptr_sync "logic rsp_rptr_sync[3:0]"

// --- fcip_req_rsp_afifo_mst ( parameter SYNC_STAGE=2,FIFO_DEPTH=4 [pld_sync_dead_path] ---
CHECKSUM: "1707270697 299175842"
ANNOTATION: "Packed payload sync register: fully uncovered = on structurally dead path (CTI/debug)"
MODULE: fcip_req_rsp_afifo_mst ( parameter SYNC_STAGE=2,FIFO_DEPTH=4,AUTO_CLEAR_EN=1,REQ_WIDTH=119,RSP_WIDTH=65,VT_TYPE=1 )
Toggle req_pld_sync "logic req_pld_sync[120:0]"
Toggle rsp_pld_sync "logic rsp_pld_sync[66:0]"

// --- fcip_req_rsp_afifo_slv ( parameter SYNC_STAGE=2,FIFO_DEPTH=4 [clk_rst] ---
CHECKSUM: "3838745283 4050246514"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: fcip_req_rsp_afifo_slv ( parameter SYNC_STAGE=2,FIFO_DEPTH=4,AUTO_CLEAR_EN=1,REQ_WIDTH=119,RSP_WIDTH=65,VT_TYPE=1 )
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- fcip_req_rsp_afifo_slv ( parameter SYNC_STAGE=2,FIFO_DEPTH=4 [fifo_ptr_dead_path] ---
CHECKSUM: "3838745283 4050246514"
ANNOTATION: "FIFO pointer: fully uncovered = FIFO on structurally dead path (CTI/debug)"
MODULE: fcip_req_rsp_afifo_slv ( parameter SYNC_STAGE=2,FIFO_DEPTH=4,AUTO_CLEAR_EN=1,REQ_WIDTH=119,RSP_WIDTH=65,VT_TYPE=1 )
Toggle req_wptr_async "logic req_wptr_async[3:0]"
Toggle req_rptr_async "logic req_rptr_async[3:0]"
Toggle req_rptr_sync "logic req_rptr_sync[3:0]"
Toggle rsp_wptr_async "logic rsp_wptr_async[3:0]"
Toggle rsp_rptr_async "logic rsp_rptr_async[3:0]"
Toggle rsp_rptr_sync "logic rsp_rptr_sync[3:0]"

// --- fcip_req_rsp_afifo_slv ( parameter SYNC_STAGE=2,FIFO_DEPTH=4 [pld_sync_dead_path] ---
CHECKSUM: "3838745283 4050246514"
ANNOTATION: "Packed payload sync register: fully uncovered = on structurally dead path (CTI/debug)"
MODULE: fcip_req_rsp_afifo_slv ( parameter SYNC_STAGE=2,FIFO_DEPTH=4,AUTO_CLEAR_EN=1,REQ_WIDTH=119,RSP_WIDTH=65,VT_TYPE=1 )
Toggle req_pld_sync "logic req_pld_sync[120:0]"
Toggle rsp_pld_sync "logic rsp_pld_sync[66:0]"

// --- fcip_rob_prealloc [handshake_dead_path] ---
CHECKSUM: "4087802852 3145040554"
ANNOTATION: "Handshake VLD/RDY: fully uncovered = on structurally dead path"
MODULE: fcip_rob_prealloc
Toggle out_vld "logic out_vld"
Toggle out_rdy "logic out_rdy"

// --- lwring_id_remap [clk_rst] ---
CHECKSUM: "1880613491 805981886"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: lwring_id_remap
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- lwring_id_remap_entry [clk_rst] ---
CHECKSUM: "1128467969 2242895059"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: lwring_id_remap_entry
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- pulse_async_bridge_receiver_qactive [clk_rst] ---
CHECKSUM: "522531746 101212094"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: pulse_async_bridge_receiver_qactive
Toggle clk_rx "logic clk_rx"
Toggle rstn_rx "logic rstn_rx"
Toggle clk_rx_qactive "logic clk_rx_qactive"

// --- pulse_async_bridge_transmitter_qactive [clk_rst] ---
CHECKSUM: "38726965 2327885008"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: pulse_async_bridge_transmitter_qactive
Toggle clk_tx "logic clk_tx"
Toggle rstn_tx "logic rstn_tx"
Toggle clk_tx_qactive "logic clk_tx_qactive"

// --- real_mux_onehot [mux_dead_path] ---
CHECKSUM: "1871685386 1694842591"
ANNOTATION: "Mux select: fully uncovered = on structurally dead path"
MODULE: real_mux_onehot
Toggle select_onehot "net select_onehot[1:0]"

// --- top_newtb [clk_rst] ---
CHECKSUM: "2925386691 107797614"
ANNOTATION: "Clock/reset signals excluded from toggle coverage"
MODULE: top_newtb
Toggle clk_src "logic clk_src"
Toggle clk_dst "logic clk_dst"
Toggle clk_dbg_timer "logic clk_dbg_timer"
Toggle rstn_src "logic rstn_src"
Toggle rstn_dst "logic rstn_dst"
Toggle rstn_dbg_timer "logic rstn_dbg_timer"
Toggle s_awburst "logic s_awburst[1:0]"
Toggle s_arburst "logic s_arburst[1:0]"

// --- top_newtb [cti_dead] ---
CHECKSUM: "2925386691 107797614"
ANNOTATION: "CTI event/channel ports: CTI subsystem tied-off in this topology"
MODULE: top_newtb
Toggle sys_cti_event_in "logic sys_cti_event_in[7:0]"
Toggle sys_cti_event_out "logic sys_cti_event_out[7:0]"
Toggle sys_cti_channel_in "logic sys_cti_channel_in[7:0]"
Toggle sys_cti_channel_out "logic sys_cti_channel_out[7:0]"

// --- top_newtb [debug_infra] ---
CHECKSUM: "2925386691 107797614"
ANNOTATION: "Debug timestamp/data infrastructure: tied-off or static in this config"
MODULE: top_newtb
Toggle dbg_timestamp_in "logic dbg_timestamp_in[63:0]"
Toggle dbg_data_in "logic dbg_data_in[31:0]"
Toggle dbg_timestamp_out_0 "logic dbg_timestamp_out_0[63:0]"
Toggle dbg_timestamp_out_1 "logic dbg_timestamp_out_1[63:0]"
Toggle dbg_timestamp_out_2 "logic dbg_timestamp_out_2[63:0]"
Toggle dbg_data_out_0 "logic dbg_data_out_0[31:0]"
Toggle dbg_data_out_1 "logic dbg_data_out_1[31:0]"
Toggle dbg_data_out_2 "logic dbg_data_out_2[31:0]"

// --- top_newtb [node_id_static] ---
CHECKSUM: "2925386691 107797614"
ANNOTATION: "node_id is static configuration, fixed per instance"
MODULE: top_newtb
Toggle node_id "logic node_id[7:0]"
