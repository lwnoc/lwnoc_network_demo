//==================================================
// Structural Coverage Waivers for lwnoc_sts_noc
// new_tb verification environment
// Only structurally unreachable / parameter-disabled items
//==================================================

// ===== FSM: Base_sts_tniu_apb =====
// APB_RESP state is structurally unreachable
// APB_SETUP->APB_IDLE impossible (unconditional to APB_ACCESS)
// APB_RESP->APB_IDLE: APB_RESP never entered

CHECKSUM: "1228083994 1721921165"
ANNOTATION: "APB_RESP structurally unreachable"
MODULE: Base_sts_tniu_apb
Fsm apb_state "1721921165"
State APB_RESP "3"

CHECKSUM: "1228083994 1721921165"
ANNOTATION: "APB_SETUP always goes to APB_ACCESS, never to IDLE"
MODULE: Base_sts_tniu_apb
Fsm apb_state "1721921165"
Transition APB_SETUP->APB_IDLE "1->0"

CHECKSUM: "1228083994 1721921165"
ANNOTATION: "APB_RESP never entered"
MODULE: Base_sts_tniu_apb
Fsm apb_state "1721921165"
Transition APB_RESP->APB_IDLE "3->0"

// ===== LINE: Base_sts_tniu_apb dead code =====

CHECKSUM: "1228083994 2241750520"
ANNOTATION: "Line 128: APB_RESP case body - state structurally unreachable"
MODULE: Base_sts_tniu_apb
Block 14 "1854785958" "apb_state <= APB_IDLE;"

CHECKSUM: "1228083994 2241750520"
ANNOTATION: "Line 132: default case body - 2-bit enum covers all states"
MODULE: Base_sts_tniu_apb
Block 15 "2701285303" "apb_state <= APB_IDLE;"

// ===== BRANCH: Base_sts_tniu_apb dead branches =====

CHECKSUM: "1228083994 3671194946"
ANNOTATION: "APB_ACCESS opcode neither RdReq nor WrReq: structurally impossible"
MODULE: Base_sts_tniu_apb
Branch 1 "4033457464" "(!rst_n)" (8) "(!rst_n) 0,-,APB_ACCESS ,-,1,0,0,-"

CHECKSUM: "1228083994 3671194946"
ANNOTATION: "APB_RESP case arm: state structurally unreachable"
MODULE: Base_sts_tniu_apb
Branch 1 "4033457464" "(!rst_n)" (12) "(!rst_n) 0,-,APB_RESP ,-,-,-,-,-"

CHECKSUM: "1228083994 3671194946"
ANNOTATION: "default case arm: 2-bit enum covers all states"
MODULE: Base_sts_tniu_apb
Branch 1 "4033457464" "(!rst_n)" (13) "(!rst_n) 0,-,default,-,-,-,-,-"

// ===== TOGGLE: Base_sts_tniu_noc - structurally tied fields =====
// AXI user, lock, len[5:0] fields are unused on APB path (APB has no burst/lock/user).
// TNIU-side len is always 0 after INIU burst splitting.
// QoS field propagated but never varied (single QoS priority, tied to 0).
// CTI event/channel out from TNIU noc side is structurally tied to 0.

CHECKSUM: "911015456 3619931088"
MODULE: Base_sts_tniu_noc
Toggle in_req_pld.req.user "logic in_req_pld.req.user[7:0]"
Toggle req_apb_tniu_pld.req.user "logic req_apb_tniu_pld.req.user[7:0]"
Toggle req_tniu_sys_pld.req.user "logic req_tniu_sys_pld.req.user[7:0]"
Toggle req_async_fifo_pld.req.user "logic req_async_fifo_pld.req.user[7:0]"
Toggle req_async_fifo_pld_tmp.req.user "logic req_async_fifo_pld_tmp.req.user[7:0]"
Toggle req_afifo_pld.req.user "logic req_afifo_pld.req.user[7:0]"
Toggle in_req_pld.req.lock "logic in_req_pld.req.lock"
Toggle req_apb_tniu_pld.req.lock "logic req_apb_tniu_pld.req.lock"
Toggle req_tniu_sys_pld.req.lock "logic req_tniu_sys_pld.req.lock"
Toggle req_async_fifo_pld.req.lock "logic req_async_fifo_pld.req.lock"
Toggle req_async_fifo_pld_tmp.req.lock "logic req_async_fifo_pld_tmp.req.lock"
Toggle req_afifo_pld.req.lock "logic req_afifo_pld.req.lock"
Toggle in_req_pld.req.len "logic in_req_pld.req.len[5:0]"
Toggle req_apb_tniu_pld.req.len "logic req_apb_tniu_pld.req.len[5:0]"
Toggle req_tniu_sys_pld.req.len "logic req_tniu_sys_pld.req.len[5:0]"
Toggle req_async_fifo_pld.req.len "logic req_async_fifo_pld.req.len[5:0]"
Toggle req_async_fifo_pld_tmp.req.len "logic req_async_fifo_pld_tmp.req.len[5:0]"
Toggle req_afifo_pld.req.len "logic req_afifo_pld.req.len[5:0]"
Toggle in_req_pld.cmn.qos "logic in_req_pld.cmn.qos[3:0]"
Toggle out_rsp_pld.cmn.qos "logic out_rsp_pld.cmn.qos[3:0]"
Toggle req_apb_tniu_pld.cmn.qos "logic req_apb_tniu_pld.cmn.qos[3:0]"
Toggle rsp_apb_tniu_pld.cmn.qos "logic rsp_apb_tniu_pld.cmn.qos[3:0]"
Toggle req_tniu_sys_pld.cmn.qos "logic req_tniu_sys_pld.cmn.qos[3:0]"
Toggle rsp_tniu_sys_pld.cmn.qos "logic rsp_tniu_sys_pld.cmn.qos[3:0]"
Toggle req_async_fifo_pld.cmn.qos "logic req_async_fifo_pld.cmn.qos[3:0]"
Toggle req_async_fifo_pld_tmp.cmn.qos "logic req_async_fifo_pld_tmp.cmn.qos[3:0]"
Toggle req_afifo_pld.cmn.qos "logic req_afifo_pld.cmn.qos[3:0]"
Toggle rsp_afifo_pld.cmn.qos "logic rsp_afifo_pld.cmn.qos[3:0]"
Toggle rsp_tniu_sys_pld_tmp.cmn.qos "logic rsp_tniu_sys_pld_tmp.cmn.qos[3:0]"
Toggle cti_event_out "logic cti_event_out[7:0]"
Toggle cti_event_out_req "logic cti_event_out_req[7:0]"
Toggle cti_event_out_ack "logic cti_event_out_ack[7:0]"
Toggle cti_channel_out "logic cti_channel_out[7:0]"
Toggle cti_channel_out_req "logic cti_channel_out_req[7:0]"
Toggle cti_channel_out_ack "logic cti_channel_out_ack[7:0]"

// ===== TOGGLE: Base_sts_noc_1iniu_3tniu_dut - structural ties =====
// timestamp upper bits never toggle in finite sim; flow_ctrl unused

CHECKSUM: "2477951387 3040048395"
MODULE: Base_sts_noc_1iniu_3tniu_dut
Toggle dbg_timestamp_in "logic dbg_timestamp_in[63:0]"
Toggle flow_ctrl_busy "logic flow_ctrl_busy[1:0]"
Toggle flow_ctrl_update "logic flow_ctrl_update"

// ===== TOGGLE: top_newtb - timestamp structural =====

CHECKSUM: "1086661378 3562779044"
MODULE: top_newtb
Toggle dbg_timestamp_in "logic dbg_timestamp_in[63:0]"

// ===== TOGGLE: Base_sts_iniu_addr_map - LINEAR_EN=0 disabled =====
// Linear address mapping is structurally disabled (parameter LINEAR_EN=0).
// linear_hit is always 0; linear_tgt_id is never selected.

CHECKSUM: "2956957120 1980734087"
MODULE: Base_sts_iniu_addr_map
Toggle linear_hit "logic linear_hit"
Toggle linear_tgt_id "logic linear_tgt_id[7:0]"

// ===== TOGGLE: Base_sts_iniu_axi_iniu - INIU protocol constraints =====
// INIU does not support AXI bursts (spec: awlen/arlen must be 0, single beat).
// Lock (exclusive access) not supported in this NoC configuration.
// User field not implemented (no user-defined sideband in this NoC).

CHECKSUM: "1437876289 1179372252"
MODULE: Base_sts_iniu_axi_iniu
Toggle upstrm_aw_pld.awlen "logic upstrm_aw_pld.awlen[7:0]"
Toggle upstrm_aw_pld.awlock "logic upstrm_aw_pld.awlock"
Toggle upstrm_aw_pld.awuser "logic upstrm_aw_pld.awuser[7:0]"
Toggle upstrm_ar_pld.arlen "logic upstrm_ar_pld.arlen[7:0]"
Toggle upstrm_ar_pld.arlock "logic upstrm_ar_pld.arlock"
Toggle upstrm_ar_pld.aruser "logic upstrm_ar_pld.aruser[7:0]"

// ===== TOGGLE: Base_sts_iniu_wr_channel - len/lock/user pipeline =====
// These fields propagate the structurally-0 AXI sideband through the
// write channel pipeline. Source is tied to 0 at INIU AXI input.

CHECKSUM: "1611148050 3365547349"
MODULE: Base_sts_iniu_wr_channel
Toggle out_req_pld.req.user "logic out_req_pld.req.user[7:0]"
Toggle out_req_pld.req.lock "logic out_req_pld.req.lock"
Toggle out_req_pld.req.len "logic out_req_pld.req.len[5:0]"
Toggle merged_req_pld.req.user "logic merged_req_pld.req.user[7:0]"
Toggle merged_req_pld.req.lock "logic merged_req_pld.req.lock"
Toggle merged_req_pld.req.len "logic merged_req_pld.req.len[5:0]"
Toggle rs_out_pld.req.user "logic rs_out_pld.req.user[7:0]"
Toggle rs_out_pld.req.lock "logic rs_out_pld.req.lock"
Toggle rs_out_pld.req.len "logic rs_out_pld.req.len[5:0]"

// ===== TOGGLE: Base_sts_iniu_rd_channel - len/lock/user pipeline =====
// Same rationale as wr_channel: structurally-0 fields through read pipeline.

CHECKSUM: "4115085934 3089047861"
MODULE: Base_sts_iniu_rd_channel
Toggle out_req_pld.req.user "logic out_req_pld.req.user[7:0]"
Toggle out_req_pld.req.lock "logic out_req_pld.req.lock"
Toggle out_req_pld.req.len "logic out_req_pld.req.len[5:0]"
Toggle fifo_in_ar_pld.req.user "logic fifo_in_ar_pld.req.user[7:0]"
Toggle fifo_in_ar_pld.req.lock "logic fifo_in_ar_pld.req.lock"
Toggle fifo_in_ar_pld.req.len "logic fifo_in_ar_pld.req.len[5:0]"
Toggle fifo_out_ar_pld.req.user "logic fifo_out_ar_pld.req.user[7:0]"
Toggle fifo_out_ar_pld.req.lock "logic fifo_out_ar_pld.req.lock"
Toggle fifo_out_ar_pld.req.len "logic fifo_out_ar_pld.req.len[5:0]"
Toggle ar_hold_pld.req.user "logic ar_hold_pld.req.user[7:0]"
Toggle ar_hold_pld.req.lock "logic ar_hold_pld.req.lock"
Toggle ar_hold_pld.req.len "logic ar_hold_pld.req.len[5:0]"

// ===== TOGGLE: Base_sts_noc_1iniu_3tniu_dut - AXI sideband at DUT I/O =====
// s_awlen/s_arlen: INIU no-burst spec (len must be 0).
// s_awlock/s_arlock: no exclusive access support.
// s_awuser/s_aruser: user field not implemented.
// Internal pipeline copies (iniu_req_pld, tniuN_req_pld) carry same tied value.
// iniu_rsp_pld/tniuN qos fields: single QoS priority, always 0.
// noc_cti_event_out_N: TNIU noc-side event output is structurally 0.

CHECKSUM: "2477951387 3040048395"
MODULE: Base_sts_noc_1iniu_3tniu_dut
Toggle s_awlen "logic s_awlen[7:0]"
Toggle s_awlock "logic s_awlock"
Toggle s_awuser "logic s_awuser[7:0]"
Toggle s_arlen "logic s_arlen[7:0]"
Toggle s_arlock "logic s_arlock"
Toggle s_aruser "logic s_aruser[7:0]"
Toggle iniu_req_pld.req.user "logic iniu_req_pld.req.user[7:0]"
Toggle iniu_req_pld.req.lock "logic iniu_req_pld.req.lock"
Toggle iniu_req_pld.req.len "logic iniu_req_pld.req.len[5:0]"
Toggle iniu_req_pld.cmn.qos "logic iniu_req_pld.cmn.qos[3:0]"
Toggle iniu_rsp_pld.cmn.qos "logic iniu_rsp_pld.cmn.qos[3:0]"
Toggle tniu0_req_pld.req.user "logic tniu0_req_pld.req.user[7:0]"
Toggle tniu0_req_pld.req.lock "logic tniu0_req_pld.req.lock"
Toggle tniu0_req_pld.req.len "logic tniu0_req_pld.req.len[5:0]"
Toggle tniu0_req_pld.cmn.qos "logic tniu0_req_pld.cmn.qos[3:0]"
Toggle tniu1_req_pld.req.user "logic tniu1_req_pld.req.user[7:0]"
Toggle tniu1_req_pld.req.lock "logic tniu1_req_pld.req.lock"
Toggle tniu1_req_pld.req.len "logic tniu1_req_pld.req.len[5:0]"
Toggle tniu1_req_pld.cmn.qos "logic tniu1_req_pld.cmn.qos[3:0]"
Toggle tniu2_req_pld.req.user "logic tniu2_req_pld.req.user[7:0]"
Toggle tniu2_req_pld.req.lock "logic tniu2_req_pld.req.lock"
Toggle tniu2_req_pld.req.len "logic tniu2_req_pld.req.len[5:0]"
Toggle tniu2_req_pld.cmn.qos "logic tniu2_req_pld.cmn.qos[3:0]"

// ===== TOGGLE: Base_sts_noc_req_router_1to3 - len/lock/user/qos pipeline =====
// Req router passes through structurally-0 fields from INIU to each TNIU.

CHECKSUM: "3111419975 3722419792"
MODULE: Base_sts_noc_req_router_1to3
Toggle in_req_pld.req.user "logic in_req_pld.req.user[7:0]"
Toggle in_req_pld.req.lock "logic in_req_pld.req.lock"
Toggle in_req_pld.req.len "logic in_req_pld.req.len[5:0]"
Toggle in_req_pld.cmn.qos "logic in_req_pld.cmn.qos[3:0]"
Toggle tniu0_req_pld.req.user "logic tniu0_req_pld.req.user[7:0]"
Toggle tniu0_req_pld.req.lock "logic tniu0_req_pld.req.lock"
Toggle tniu0_req_pld.req.len "logic tniu0_req_pld.req.len[5:0]"
Toggle tniu0_req_pld.cmn.qos "logic tniu0_req_pld.cmn.qos[3:0]"
Toggle tniu1_req_pld.req.user "logic tniu1_req_pld.req.user[7:0]"
Toggle tniu1_req_pld.req.lock "logic tniu1_req_pld.req.lock"
Toggle tniu1_req_pld.req.len "logic tniu1_req_pld.req.len[5:0]"
Toggle tniu1_req_pld.cmn.qos "logic tniu1_req_pld.cmn.qos[3:0]"
Toggle tniu2_req_pld.req.user "logic tniu2_req_pld.req.user[7:0]"
Toggle tniu2_req_pld.req.lock "logic tniu2_req_pld.req.lock"
Toggle tniu2_req_pld.req.len "logic tniu2_req_pld.req.len[5:0]"
Toggle tniu2_req_pld.cmn.qos "logic tniu2_req_pld.cmn.qos[3:0]"

// ===== TOGGLE: Base_sts_noc_rsp_mux_3to1 - qos through response path =====
// QoS field in responses is always 0 (single QoS priority).

CHECKSUM: "617881430 2706392466"
MODULE: Base_sts_noc_rsp_mux_3to1
Toggle in0_rsp_pld.cmn.qos "logic in0_rsp_pld.cmn.qos[3:0]"
Toggle in1_rsp_pld.cmn.qos "logic in1_rsp_pld.cmn.qos[3:0]"
Toggle in2_rsp_pld.cmn.qos "logic in2_rsp_pld.cmn.qos[3:0]"
Toggle decerr_rsp_pld.cmn.qos "logic decerr_rsp_pld.cmn.qos[3:0]"
Toggle out_rsp_pld.cmn.qos "logic out_rsp_pld.cmn.qos[3:0]"

// ===== TOGGLE: Base_sts_tniu_sys - len/lock/user/qos pipeline =====
// Structurally 0 from INIU propagation through async FIFO into TNIU sys.

CHECKSUM: "417801667 849917854"
MODULE: Base_sts_tniu_sys
Toggle req_apb_tniu_pld.req.user "logic req_apb_tniu_pld.req.user[7:0]"
Toggle req_apb_tniu_pld.req.lock "logic req_apb_tniu_pld.req.lock"
Toggle req_apb_tniu_pld.req.len "logic req_apb_tniu_pld.req.len[5:0]"
Toggle req_apb_tniu_pld.cmn.qos "logic req_apb_tniu_pld.cmn.qos[3:0]"
Toggle req_apb_tniu_pld_tmp.req.user "logic req_apb_tniu_pld_tmp.req.user[7:0]"
Toggle req_apb_tniu_pld_tmp.req.lock "logic req_apb_tniu_pld_tmp.req.lock"
Toggle req_apb_tniu_pld_tmp.req.len "logic req_apb_tniu_pld_tmp.req.len[5:0]"
Toggle req_apb_tniu_pld_tmp.cmn.qos "logic req_apb_tniu_pld_tmp.cmn.qos[3:0]"
Toggle rsp_apb_tniu_pld.cmn.qos "logic rsp_apb_tniu_pld.cmn.qos[3:0]"
Toggle rsp_async_fifo_pld_tmp.cmn.qos "logic rsp_async_fifo_pld_tmp.cmn.qos[3:0]"

// ===== TOGGLE: Base_sts_tniu_top - len/lock/user/qos + noc CTI event =====
// Structural-0 AXI sideband at TNIU top. noc_cti_event_in='0 at DUT level;
// noc_cti_event_out is structurally 0 (TNIU does not source noc events).

CHECKSUM: "731806648 2237614106"
MODULE: Base_sts_tniu_top
Toggle in_req_pld.req.user "logic in_req_pld.req.user[7:0]"
Toggle in_req_pld.req.lock "logic in_req_pld.req.lock"
Toggle in_req_pld.req.len "logic in_req_pld.req.len[5:0]"
Toggle in_req_pld.cmn.qos "logic in_req_pld.cmn.qos[3:0]"
Toggle out_rsp_pld.cmn.qos "logic out_rsp_pld.cmn.qos[3:0]"
Toggle noc_cti_event_out "logic noc_cti_event_out[7:0]"
Toggle noc_cti_event_in "logic noc_cti_event_in[7:0]"
Toggle noc_cti_channel_out "logic noc_cti_channel_out[7:0]"
Toggle noc_cti_channel_in "logic noc_cti_channel_in[7:0]"

// ===== CONDITION: Base_sts_iniu_addr_map - LINEAR_EN=0 =====
// linear_hit is always 0 (LINEAR_EN parameter disabled).
// Conditions involving linear_hit can never be true.

CHECKSUM: "2956957120 650574053"
MODULE: Base_sts_iniu_addr_map
Condition 1 "2120048044" "(table_hit || linear_hit) 1 -1" (1 "00")
Condition 1 "2120048044" "(table_hit || linear_hit) 1 -1" (2 "01")
Condition 2 "2442185518" "(table_hit ? table_tgt_id : (linear_hit ? linear_tgt_id : DEFAULT_TGT_ID)) 1 -1" (2 "1")
Condition 3 "3543848600" "(linear_hit ? linear_tgt_id : DEFAULT_TGT_ID) 1 -1" (2 "1")

// ===== TOGGLE: Base_sts_apb_stub_slave - upper address bits structurally dead =====
// paddr[31:6] are always 0 within the APB 4KB window (PMC has 16 words at offsets 0x00-0x3C).
// word_idx_full is derived from paddr and also has dead upper bits.

CHECKSUM: "3851199999 587280344"
MODULE: Base_sts_apb_stub_slave
Toggle paddr "logic paddr[31:0]"
Toggle word_idx_full "logic word_idx_full[29:0]"

// ===== CONDITION: Base_sts_apb_stub_slave - structurally impossible =====
// Cond 1 row "10": access_setup=1 && access_pending=1 -- APB protocol prevents new setup while pending.
// Cond 2 row "01": access_pending=0 && stall_cycles_left>0 -- stall counter only loaded inside pending block.

CHECKSUM: "3851199999 1260647653"
MODULE: Base_sts_apb_stub_slave
Condition 1 "3628266133" "(access_setup && ((!access_pending))) 1 -1" (2 "10")
Condition 2 "1857056034" "(access_pending && (stall_cycles_left > 0)) 1 -1" (1 "01")

// ===== TOGGLE: fcip_afifo_slv - structurally dead control ports =====
// stall: hardwired 1'b0 in fcip_req_rsp_afifo_slv wrapper (never asserted)
// clear: hardwired 1'b0 in wrapper (only reset path used)
// almost_full: THRESHOLD_EN=0, output hardwired to 0 (threshold logic not elaborated)

CHECKSUM: "2851294776 2451114303"
MODULE: fcip_afifo_slv
Toggle stall "logic stall"
Toggle clear "logic clear"
Toggle almost_full "logic almost_full"

CHECKSUM: "2851294776 2602238882"
MODULE: fcip_afifo_slv
Toggle stall "logic stall"
Toggle clear "logic clear"
Toggle almost_full "logic almost_full"

// ===== TOGGLE: fcip_afifo_mst - structurally dead control ports =====
// stall: hardwired 1'b0 in fcip_req_rsp_afifo_mst wrapper (never asserted)
// clear: hardwired 1'b0 in wrapper (only reset path used)
// idle: unconnected () at all instantiation sites
// almost_empty: THRESHOLD_EN=0, output hardwired to 0 (threshold logic not elaborated)

CHECKSUM: "2269949625 3171455134"
MODULE: fcip_afifo_mst
Toggle stall "logic stall"
Toggle clear "logic clear"
Toggle idle "logic idle"
Toggle almost_empty "logic almost_empty"

CHECKSUM: "2269949625 1451461867"
MODULE: fcip_afifo_mst
Toggle stall "logic stall"
Toggle clear "logic clear"
Toggle idle "logic idle"
Toggle almost_empty "logic almost_empty"

// ===== TOGGLE: Additional dead payload field waivers (Round 10) =====
// NoC payload fields user[7:0], lock, len[5:0], qos[3:0] are structurally
// tied to 0 by the INIU (no AXI burst/lock/user/QoS support).
// These dead fields propagate through every pipeline stage in the design.

// --- Base_lwnoc_flow_ctrl_chk ---
CHECKSUM: "2312387679 947793373"
MODULE: Base_lwnoc_flow_ctrl_chk
Toggle in_pld.req.user "logic in_pld.req.user[7:0]"
Toggle in_pld.req.lock "logic in_pld.req.lock"
Toggle in_pld.req.len "logic in_pld.req.len[5:0]"
Toggle in_pld.cmn.qos "logic in_pld.cmn.qos[3:0]"
Toggle out_pld.req.user "logic out_pld.req.user[7:0]"
Toggle out_pld.req.lock "logic out_pld.req.lock"
Toggle out_pld.req.len "logic out_pld.req.len[5:0]"
Toggle out_pld.cmn.qos "logic out_pld.cmn.qos[3:0]"

// --- Base_sts_iniu_axi_iniu (additional entries) ---
CHECKSUM: "1437876289 1179372252"
MODULE: Base_sts_iniu_axi_iniu
Toggle out_req_pld.req.user "logic out_req_pld.req.user[7:0]"
Toggle out_req_pld.req.lock "logic out_req_pld.req.lock"
Toggle out_req_pld.req.len "logic out_req_pld.req.len[5:0]"
Toggle out_req_pld.cmn.qos "logic out_req_pld.cmn.qos[3:0]"
Toggle in_rsp_pld.cmn.qos "logic in_rsp_pld.cmn.qos[3:0]"
Toggle wr_req_pld.req.user "logic wr_req_pld.req.user[7:0]"
Toggle wr_req_pld.req.lock "logic wr_req_pld.req.lock"
Toggle wr_req_pld.req.len "logic wr_req_pld.req.len[5:0]"
Toggle wr_req_pld.cmn.qos "logic wr_req_pld.cmn.qos[3:0]"
Toggle wr_rsp_pld.cmn.qos "logic wr_rsp_pld.cmn.qos[3:0]"
Toggle rd_req_pld.req.user "logic rd_req_pld.req.user[7:0]"
Toggle rd_req_pld.req.lock "logic rd_req_pld.req.lock"
Toggle rd_req_pld.req.len "logic rd_req_pld.req.len[5:0]"
Toggle rd_req_pld.cmn.qos "logic rd_req_pld.cmn.qos[3:0]"
Toggle rd_rsp_pld.cmn.qos "logic rd_rsp_pld.cmn.qos[3:0]"
Toggle arb_pld.req.user "logic arb_pld.req.user[7:0]"
Toggle arb_pld.req.lock "logic arb_pld.req.lock"
Toggle arb_pld.req.len "logic arb_pld.req.len[5:0]"
Toggle arb_pld.cmn.qos "logic arb_pld.cmn.qos[3:0]"

// --- Base_sts_iniu_noc ---
CHECKSUM: "3224443634 375832414"
MODULE: Base_sts_iniu_noc
Toggle req_s_pld.req.user "logic req_s_pld.req.user[7:0]"
Toggle req_s_pld.req.lock "logic req_s_pld.req.lock"
Toggle req_s_pld.req.len "logic req_s_pld.req.len[5:0]"
Toggle req_s_pld.cmn.qos "logic req_s_pld.cmn.qos[3:0]"
Toggle rsp_m_pld.cmn.qos "logic rsp_m_pld.cmn.qos[3:0]"

// --- Base_sts_iniu_rd_channel (additional qos entries) ---
CHECKSUM: "4115085934 3089047861"
MODULE: Base_sts_iniu_rd_channel
Toggle out_req_pld.cmn.qos "logic out_req_pld.cmn.qos[3:0]"
Toggle in_rsp_pld.cmn.qos "logic in_rsp_pld.cmn.qos[3:0]"
Toggle fifo_in_ar_pld.cmn.qos "logic fifo_in_ar_pld.cmn.qos[3:0]"
Toggle fifo_out_ar_pld.cmn.qos "logic fifo_out_ar_pld.cmn.qos[3:0]"
Toggle ar_hold_pld.cmn.qos "logic ar_hold_pld.cmn.qos[3:0]"

// --- Base_sts_iniu_sys ---
CHECKSUM: "3047891155 2362043708"
MODULE: Base_sts_iniu_sys
Toggle req_pld_temp.req.user "logic req_pld_temp.req.user[7:0]"
Toggle req_pld_temp.req.lock "logic req_pld_temp.req.lock"
Toggle req_pld_temp.req.len "logic req_pld_temp.req.len[5:0]"
Toggle req_pld_temp.cmn.qos "logic req_pld_temp.cmn.qos[3:0]"
Toggle rsp_pld_temp.cmn.qos "logic rsp_pld_temp.cmn.qos[3:0]"

// --- Base_sts_iniu_top ---
CHECKSUM: "172948656 3544573874"
MODULE: Base_sts_iniu_top
Toggle out_req_pld.req.user "logic out_req_pld.req.user[7:0]"
Toggle out_req_pld.req.lock "logic out_req_pld.req.lock"
Toggle out_req_pld.req.len "logic out_req_pld.req.len[5:0]"
Toggle out_req_pld.cmn.qos "logic out_req_pld.cmn.qos[3:0]"
Toggle in_rsp_pld.cmn.qos "logic in_rsp_pld.cmn.qos[3:0]"

// --- Base_sts_iniu_wr_channel (additional qos entries) ---
CHECKSUM: "1611148050 3365547349"
MODULE: Base_sts_iniu_wr_channel
Toggle out_req_pld.cmn.qos "logic out_req_pld.cmn.qos[3:0]"
Toggle in_rsp_pld.cmn.qos "logic in_rsp_pld.cmn.qos[3:0]"
Toggle merged_req_pld.cmn.qos "logic merged_req_pld.cmn.qos[3:0]"
Toggle rs_out_pld.cmn.qos "logic rs_out_pld.cmn.qos[3:0]"

// --- Base_sts_noc_1iniu_3tniu_dut (additional rsp qos entries) ---
CHECKSUM: "2477951387 3040048395"
MODULE: Base_sts_noc_1iniu_3tniu_dut
Toggle tniu0_rsp_pld.cmn.qos "logic tniu0_rsp_pld.cmn.qos[3:0]"
Toggle tniu1_rsp_pld.cmn.qos "logic tniu1_rsp_pld.cmn.qos[3:0]"
Toggle tniu2_rsp_pld.cmn.qos "logic tniu2_rsp_pld.cmn.qos[3:0]"
Toggle decerr_rsp_pld.cmn.qos "logic decerr_rsp_pld.cmn.qos[3:0]"

// --- Base_sts_noc_req_router_1to3 (additional entry) ---
CHECKSUM: "3111419975 3722419792"
MODULE: Base_sts_noc_req_router_1to3
Toggle decerr_rsp_pld.cmn.qos "logic decerr_rsp_pld.cmn.qos[3:0]"

// --- Base_sts_tniu_apb: dead payload fields ---
// sts_tniu_apb carries NoC payload through APB decode but never uses
// user, lock, len, qos fields (APB has no equivalent).
CHECKSUM: "1228083994 896648132"
MODULE: Base_sts_tniu_apb
Toggle in_req_pld.req.user "logic in_req_pld.req.user[7:0]"
Toggle in_req_pld.req.lock "logic in_req_pld.req.lock"
Toggle in_req_pld.req.len "logic in_req_pld.req.len[5:0]"
Toggle in_req_pld.cmn.qos "logic in_req_pld.cmn.qos[3:0]"
Toggle out_rsp_pld.cmn.qos "logic out_rsp_pld.cmn.qos[3:0]"
Toggle fifo_out_req_pld.req.user "logic fifo_out_req_pld.req.user[7:0]"
Toggle fifo_out_req_pld.req.lock "logic fifo_out_req_pld.req.lock"
Toggle fifo_out_req_pld.req.len "logic fifo_out_req_pld.req.len[5:0]"
Toggle fifo_out_req_pld.cmn.qos "logic fifo_out_req_pld.cmn.qos[3:0]"
Toggle req_active_pld.req.user "logic req_active_pld.req.user[7:0]"
Toggle req_active_pld.req.lock "logic req_active_pld.req.lock"
Toggle req_active_pld.req.len "logic req_active_pld.req.len[5:0]"
Toggle req_active_pld.cmn.qos "logic req_active_pld.cmn.qos[3:0]"
Toggle rsp_pld_r.cmn.qos "logic rsp_pld_r.cmn.qos[3:0]"

// --- cmn_vrp_reg_fifo: dead payload fields in ID remap FIFO ---
CHECKSUM: "3634631500 2334074456"
MODULE: cmn_vrp_reg_fifo
Toggle in_pld.req.user "logic in_pld.req.user[7:0]"
Toggle in_pld.req.lock "logic in_pld.req.lock"
Toggle in_pld.req.len "logic in_pld.req.len[5:0]"
Toggle in_pld.cmn.qos "logic in_pld.cmn.qos[3:0]"
Toggle out_pld.req.user "logic out_pld.req.user[7:0]"
Toggle out_pld.req.lock "logic out_pld.req.lock"
Toggle out_pld.req.len "logic out_pld.req.len[5:0]"
Toggle out_pld.cmn.qos "logic out_pld.cmn.qos[3:0]"

// --- fcip_reg_slice RS_TYPE=0: dead payload fields in pipeline register ---
CHECKSUM: "3424757416 1716814886"
MODULE: fcip_reg_slice
Toggle s_pld.req.user "logic s_pld.req.user[7:0]"
Toggle s_pld.req.lock "logic s_pld.req.lock"
Toggle s_pld.req.len "logic s_pld.req.len[5:0]"
Toggle s_pld.cmn.qos "logic s_pld.cmn.qos[3:0]"
Toggle m_pld.req.user "logic m_pld.req.user[7:0]"
Toggle m_pld.req.lock "logic m_pld.req.lock"
Toggle m_pld.req.len "logic m_pld.req.len[5:0]"
Toggle m_pld.cmn.qos "logic m_pld.cmn.qos[3:0]"


// ============================================================================
// Round 11: Bit-range waivers for dead payload fields in FIFO flat data vectors
// Fields: qos(4b), len(6b), lock(1b), user(8b) = 19 dead bits in req path
// Field: qos(4b) = 4 dead bits in rsp path
// Also: bubble_req_pld (constant 0 for FIFO clear mechanism) fully dead
// Rationale: INIU always sets qos=0, len=0, lock=0, user=0; these fields
// propagate through all FIFO flat data vectors at identical bit positions.
// ============================================================================

// ===== TOGGLE: fcip_req_rsp_afifo_mst - dead payload bits in flat data vectors =====
CHECKSUM: "1707270697 299175842"
MODULE: fcip_req_rsp_afifo_mst
Toggle req_s_pld [92:89] "logic req_s_pld[118:0]"
Toggle req_s_pld [51:46] "logic req_s_pld[118:0]"
Toggle req_s_pld [45] "logic req_s_pld[118:0]"
Toggle req_s_pld [44:37] "logic req_s_pld[118:0]"
Toggle req_pld_sync [94:91] "logic req_pld_sync[120:0]"
Toggle req_pld_sync [53:48] "logic req_pld_sync[120:0]"
Toggle req_pld_sync [47] "logic req_pld_sync[120:0]"
Toggle req_pld_sync [46:39] "logic req_pld_sync[120:0]"
Toggle req_ext_s_pld [93:90] "logic req_ext_s_pld[119:0]"
Toggle req_ext_s_pld [52:47] "logic req_ext_s_pld[119:0]"
Toggle req_ext_s_pld [46] "logic req_ext_s_pld[119:0]"
Toggle req_ext_s_pld [45:38] "logic req_ext_s_pld[119:0]"
Toggle rsp_m_pld [38:35] "logic rsp_m_pld[64:0]"
Toggle rsp_pld_sync [40:37] "logic rsp_pld_sync[66:0]"
Toggle rsp_ext_m_pld [39:36] "logic rsp_ext_m_pld[65:0]"

// ===== TOGGLE: fcip_req_rsp_afifo_slv - dead payload bits in flat data vectors =====
CHECKSUM: "3838745283 4050246514"
MODULE: fcip_req_rsp_afifo_slv
Toggle req_s_pld [92:89] "logic req_s_pld[118:0]"
Toggle req_s_pld [51:46] "logic req_s_pld[118:0]"
Toggle req_s_pld [45] "logic req_s_pld[118:0]"
Toggle req_s_pld [44:37] "logic req_s_pld[118:0]"
Toggle req_pld_sync [94:91] "logic req_pld_sync[120:0]"
Toggle req_pld_sync [53:48] "logic req_pld_sync[120:0]"
Toggle req_pld_sync [47] "logic req_pld_sync[120:0]"
Toggle req_pld_sync [46:39] "logic req_pld_sync[120:0]"
Toggle req_s_pld_ext [93:90] "logic req_s_pld_ext[119:0]"
Toggle req_s_pld_ext [52:47] "logic req_s_pld_ext[119:0]"
Toggle req_s_pld_ext [46] "logic req_s_pld_ext[119:0]"
Toggle req_s_pld_ext [45:38] "logic req_s_pld_ext[119:0]"
Toggle rsp_m_pld [38:35] "logic rsp_m_pld[64:0]"
Toggle rsp_pld_sync [40:37] "logic rsp_pld_sync[66:0]"
Toggle stall_buffer_pld [39:36] "logic stall_buffer_pld[65:0]"
Toggle read_resp_pld [39:36] "logic read_resp_pld[65:0]"

// ===== TOGGLE: fcip_afifo_slv DW=120 (REQ path) - dead payload bits in flat data vectors =====
CHECKSUM: "2851294776 2602238882"
MODULE: fcip_afifo_slv
Toggle s_pld [93:90] "logic s_pld[119:0]"
Toggle s_pld [52:47] "logic s_pld[119:0]"
Toggle s_pld [46] "logic s_pld[119:0]"
Toggle s_pld [45:38] "logic s_pld[119:0]"
Toggle pld_sync [94:91] "logic pld_sync[120:0]"
Toggle pld_sync [53:48] "logic pld_sync[120:0]"
Toggle pld_sync [47] "logic pld_sync[120:0]"
Toggle pld_sync [46:39] "logic pld_sync[120:0]"
Toggle s_gen_pld [94:91] "logic s_gen_pld[120:0]"
Toggle s_gen_pld [53:48] "logic s_gen_pld[120:0]"
Toggle s_gen_pld [47] "logic s_gen_pld[120:0]"
Toggle s_gen_pld [46:39] "logic s_gen_pld[120:0]"
Toggle s_pld_ext [94:91] "logic s_pld_ext[120:0]"
Toggle s_pld_ext [53:48] "logic s_pld_ext[120:0]"
Toggle s_pld_ext [47] "logic s_pld_ext[120:0]"
Toggle s_pld_ext [46:39] "logic s_pld_ext[120:0]"
Toggle bubble_req_pld "logic bubble_req_pld[120:0]"
Toggle pld_sync_marker [94:91] "logic pld_sync_marker[120:0]"
Toggle pld_sync_marker [53:48] "logic pld_sync_marker[120:0]"
Toggle pld_sync_marker [47] "logic pld_sync_marker[120:0]"
Toggle pld_sync_marker [46:39] "logic pld_sync_marker[120:0]"
Toggle pld_mux_select [94:91] "logic pld_mux_select[120:0]"
Toggle pld_mux_select [53:48] "logic pld_mux_select[120:0]"
Toggle pld_mux_select [47] "logic pld_mux_select[120:0]"
Toggle pld_mux_select [46:39] "logic pld_mux_select[120:0]"

// ===== TOGGLE: fcip_afifo_slv DW=66 (RSP path) - dead payload bits in flat data vectors =====
CHECKSUM: "2851294776 2451114303"
MODULE: fcip_afifo_slv
Toggle s_pld [39:36] "logic s_pld[65:0]"
Toggle pld_sync [40:37] "logic pld_sync[66:0]"
Toggle s_gen_pld [40:37] "logic s_gen_pld[66:0]"
Toggle s_pld_ext [40:37] "logic s_pld_ext[66:0]"
Toggle bubble_req_pld "logic bubble_req_pld[66:0]"
Toggle pld_sync_marker [40:37] "logic pld_sync_marker[66:0]"
Toggle pld_mux_select [40:37] "logic pld_mux_select[66:0]"

// ===== TOGGLE: fcip_afifo_mst DW=120 (REQ path) - dead payload bits in flat data vectors =====
CHECKSUM: "2269949625 3171455134"
MODULE: fcip_afifo_mst
Toggle m_pld [93:90] "logic m_pld[119:0]"
Toggle m_pld [52:47] "logic m_pld[119:0]"
Toggle m_pld [46] "logic m_pld[119:0]"
Toggle m_pld [45:38] "logic m_pld[119:0]"
Toggle pld_sync [94:91] "logic pld_sync[120:0]"
Toggle pld_sync [53:48] "logic pld_sync[120:0]"
Toggle pld_sync [47] "logic pld_sync[120:0]"
Toggle pld_sync [46:39] "logic pld_sync[120:0]"
Toggle read_out_data [94:91] "logic read_out_data[120:0]"
Toggle read_out_data [53:48] "logic read_out_data[120:0]"
Toggle read_out_data [47] "logic read_out_data[120:0]"
Toggle read_out_data [46:39] "logic read_out_data[120:0]"
Toggle pld_sync_marker [94:91] "logic pld_sync_marker[120:0]"
Toggle pld_sync_marker [53:48] "logic pld_sync_marker[120:0]"
Toggle pld_sync_marker [47] "logic pld_sync_marker[120:0]"
Toggle pld_sync_marker [46:39] "logic pld_sync_marker[120:0]"
Toggle reg_slice_pld_r [94:91] "logic reg_slice_pld_r[120:0]"
Toggle reg_slice_pld_r [53:48] "logic reg_slice_pld_r[120:0]"
Toggle reg_slice_pld_r [47] "logic reg_slice_pld_r[120:0]"
Toggle reg_slice_pld_r [46:39] "logic reg_slice_pld_r[120:0]"

// ===== TOGGLE: fcip_afifo_mst DW=66 (RSP path) - dead payload bits in flat data vectors =====
CHECKSUM: "2269949625 1451461867"
MODULE: fcip_afifo_mst
Toggle m_pld [39:36] "logic m_pld[65:0]"
Toggle pld_sync [40:37] "logic pld_sync[66:0]"
Toggle read_out_data [40:37] "logic read_out_data[66:0]"
Toggle pld_sync_marker [40:37] "logic pld_sync_marker[66:0]"
Toggle reg_slice_pld_r [40:37] "logic reg_slice_pld_r[66:0]"

// ===== TOGGLE: fcip_fix_arb DW=121 (REQ) - dead payload bits in flat data vectors =====
CHECKSUM: "4123955945 1486429461"
MODULE: fcip_fix_arb
Toggle s_pld_priority [94:91] "logic s_pld_priority[120:0]"
Toggle s_pld_priority [53:48] "logic s_pld_priority[120:0]"
Toggle s_pld_priority [47] "logic s_pld_priority[120:0]"
Toggle s_pld_priority [46:39] "logic s_pld_priority[120:0]"
Toggle s_pld [94:91] "logic s_pld[120:0]"
Toggle s_pld [53:48] "logic s_pld[120:0]"
Toggle s_pld [47] "logic s_pld[120:0]"
Toggle s_pld [46:39] "logic s_pld[120:0]"
Toggle m_pld [94:91] "logic m_pld[120:0]"
Toggle m_pld [53:48] "logic m_pld[120:0]"
Toggle m_pld [47] "logic m_pld[120:0]"
Toggle m_pld [46:39] "logic m_pld[120:0]"

// ===== TOGGLE: fcip_fix_arb DW=67 (RSP) - dead payload bits in flat data vectors =====
CHECKSUM: "4123955945 2689351422"
MODULE: fcip_fix_arb
Toggle s_pld_priority [40:37] "logic s_pld_priority[66:0]"
Toggle s_pld [40:37] "logic s_pld[66:0]"
Toggle m_pld [40:37] "logic m_pld[66:0]"

// ===== TOGGLE: Base_sts_tniu_noc_dec2 - dead payload bits in flat data vectors =====
CHECKSUM: "3091971421 401526092"
MODULE: Base_sts_tniu_noc_dec2
Toggle s_req_pld [92:89] "logic s_req_pld[118:0]"
Toggle s_req_pld [51:46] "logic s_req_pld[118:0]"
Toggle s_req_pld [45] "logic s_req_pld[118:0]"
Toggle s_req_pld [44:37] "logic s_req_pld[118:0]"
Toggle m_req0_pld [92:89] "logic m_req0_pld[118:0]"
Toggle m_req0_pld [51:46] "logic m_req0_pld[118:0]"
Toggle m_req0_pld [45] "logic m_req0_pld[118:0]"
Toggle m_req0_pld [44:37] "logic m_req0_pld[118:0]"
Toggle m_req1_pld [92:89] "logic m_req1_pld[118:0]"
Toggle m_req1_pld [51:46] "logic m_req1_pld[118:0]"
Toggle m_req1_pld [45] "logic m_req1_pld[118:0]"
Toggle m_req1_pld [44:37] "logic m_req1_pld[118:0]"

// ===== TOGGLE: Base_sts_tniu_noc (passthrough wires) - dead payload bits in flat data vectors =====
CHECKSUM: "911015456 3619931088"
MODULE: Base_sts_tniu_noc
Toggle req_pld_sync [94:91] "logic req_pld_sync[120:0]"
Toggle req_pld_sync [53:48] "logic req_pld_sync[120:0]"
Toggle req_pld_sync [47] "logic req_pld_sync[120:0]"
Toggle req_pld_sync [46:39] "logic req_pld_sync[120:0]"
Toggle rsp_pld_sync [40:37] "logic rsp_pld_sync[66:0]"
Toggle out_req_pld_tmp [92:89] "logic out_req_pld_tmp[118:0]"
Toggle out_req_pld_tmp [51:46] "logic out_req_pld_tmp[118:0]"
Toggle out_req_pld_tmp [45] "logic out_req_pld_tmp[118:0]"
Toggle out_req_pld_tmp [44:37] "logic out_req_pld_tmp[118:0]"

// ===== TOGGLE: Base_sts_tniu_sys (passthrough wires) - dead payload bits in flat data vectors =====
CHECKSUM: "417801667 849917854"
MODULE: Base_sts_tniu_sys
Toggle req_pld_sync [94:91] "logic req_pld_sync[120:0]"
Toggle req_pld_sync [53:48] "logic req_pld_sync[120:0]"
Toggle req_pld_sync [47] "logic req_pld_sync[120:0]"
Toggle req_pld_sync [46:39] "logic req_pld_sync[120:0]"
Toggle rsp_pld_sync [40:37] "logic rsp_pld_sync[66:0]"

// ===== TOGGLE: Base_sts_iniu_sys (passthrough wires) - dead payload bits in flat data vectors =====
CHECKSUM: "3047891155 2362043708"
MODULE: Base_sts_iniu_sys
Toggle req_pld_sync [94:91] "logic req_pld_sync[120:0]"
Toggle req_pld_sync [53:48] "logic req_pld_sync[120:0]"
Toggle req_pld_sync [47] "logic req_pld_sync[120:0]"
Toggle req_pld_sync [46:39] "logic req_pld_sync[120:0]"
Toggle rsp_pld_sync [40:37] "logic rsp_pld_sync[66:0]"
Toggle req_pld_afifo [92:89] "logic req_pld_afifo[118:0]"
Toggle req_pld_afifo [51:46] "logic req_pld_afifo[118:0]"
Toggle req_pld_afifo [45] "logic req_pld_afifo[118:0]"
Toggle req_pld_afifo [44:37] "logic req_pld_afifo[118:0]"
Toggle rsp_pld_afifo [38:35] "logic rsp_pld_afifo[64:0]"

// ===== TOGGLE: Base_sts_iniu_noc (passthrough wires) - dead payload bits in flat data vectors =====
CHECKSUM: "3224443634 375832414"
MODULE: Base_sts_iniu_noc
Toggle req_pld_sync [94:91] "logic req_pld_sync[120:0]"
Toggle req_pld_sync [53:48] "logic req_pld_sync[120:0]"
Toggle req_pld_sync [47] "logic req_pld_sync[120:0]"
Toggle req_pld_sync [46:39] "logic req_pld_sync[120:0]"
Toggle rsp_pld_sync [40:37] "logic rsp_pld_sync[66:0]"
Toggle req_s_pld_tmp [92:89] "logic req_s_pld_tmp[118:0]"
Toggle req_s_pld_tmp [51:46] "logic req_s_pld_tmp[118:0]"
Toggle req_s_pld_tmp [45] "logic req_s_pld_tmp[118:0]"
Toggle req_s_pld_tmp [44:37] "logic req_s_pld_tmp[118:0]"

// ===== TOGGLE: Base_sts_iniu_top (passthrough wires) - dead payload bits in flat data vectors =====
CHECKSUM: "172948656 3544573874"
MODULE: Base_sts_iniu_top
Toggle tmp_req_pld_sync [94:91] "logic tmp_req_pld_sync[120:0]"
Toggle tmp_req_pld_sync [53:48] "logic tmp_req_pld_sync[120:0]"
Toggle tmp_req_pld_sync [47] "logic tmp_req_pld_sync[120:0]"
Toggle tmp_req_pld_sync [46:39] "logic tmp_req_pld_sync[120:0]"
Toggle tmp_rsp_pld_sync [40:37] "logic tmp_rsp_pld_sync[66:0]"

// ===== TOGGLE: Base_sts_tniu_top (passthrough wires) - dead payload bits in flat data vectors =====
CHECKSUM: "731806648 2237614106"
MODULE: Base_sts_tniu_top
Toggle tmp_req_pld_sync [94:91] "logic tmp_req_pld_sync[120:0]"
Toggle tmp_req_pld_sync [53:48] "logic tmp_req_pld_sync[120:0]"
Toggle tmp_req_pld_sync [47] "logic tmp_req_pld_sync[120:0]"
Toggle tmp_req_pld_sync [46:39] "logic tmp_req_pld_sync[120:0]"
Toggle tmp_rsp_pld_sync [40:37] "logic tmp_rsp_pld_sync[66:0]"

// ===== TOGGLE: fcip_arb_vrp (REQ path arbiter) - dead payload bits in flat data vectors =====
CHECKSUM: "1092840857 1381784214"
MODULE: fcip_arb_vrp
Toggle m_pld [92:89] "logic m_pld[118:0]"
Toggle m_pld [51:46] "logic m_pld[118:0]"
Toggle m_pld [45] "logic m_pld[118:0]"
Toggle m_pld [44:37] "logic m_pld[118:0]"

// ===== TOGGLE: fcip_arb_vrp (RSP path arbiter) - dead payload bits in flat data vectors =====
CHECKSUM: "3751832720 3046539970"
MODULE: fcip_arb_vrp
Toggle m_pld [38:35] "logic m_pld[64:0]"

// ===== TOGGLE: fcip_real_mux_onehot (REQ path) - dead payload bits in flat data vectors =====
CHECKSUM: "1871685386 1694842591"
MODULE: fcip_real_mux_onehot
Toggle pld_rev_select [92:89] "logic pld_rev_select[118:0]"
Toggle pld_rev_select [51:46] "logic pld_rev_select[118:0]"
Toggle pld_rev_select [45] "logic pld_rev_select[118:0]"
Toggle pld_rev_select [44:37] "logic pld_rev_select[118:0]"

// ===== TOGGLE: fcip_real_mux_onehot (RSP path) - dead payload bits in flat data vectors =====
CHECKSUM: "2636750315 2089823026"
MODULE: fcip_real_mux_onehot
Toggle pld_rev_select [38:35] "logic pld_rev_select[64:0]"

// ===== TOGGLE: fcip_reg_slice (flat RSP vectors) - dead payload bits in flat data vectors =====
CHECKSUM: "3424757416 2953773372"
MODULE: fcip_reg_slice
Toggle s_pld [39:36] "logic s_pld[65:0]"
Toggle m_pld [39:36] "logic m_pld[65:0]"


// ============================================================================
// Round 12 CONDITION waivers - structural dead code
// ============================================================================

// --- Base_lwnoc_flow_ctrl_chk ---
// flow_ctrl_busy tied '0 in DUT wrapper => busy_flag always 0
// (in_vld && ~busy_flag) vec '10': ~busy_flag=FALSE => busy_flag=1 => dead
// (out_rdy && ~busy_flag) vec '10': same reason => dead
CHECKSUM: "2312387679 2275819967"
MODULE: Base_lwnoc_flow_ctrl_chk
Condition 1 "2911297314" "(in_vld && ((~busy_flag))) 1 -1" (2 "10")
Condition 2 "303185094" "(out_rdy && ((~busy_flag))) 1 -1" (2 "10")

// --- cmn_vrp_reg_fifo ---
// FIFO ADDR_WIDTH=8 (256 entries), but max occupancy = OT_TOTAL = 128
// full signal can NEVER be asserted => vector '10' for (wr_addr==N && !full) is dead
// in_rdy = ~full => in_rdy always 1 => (in_vld && in_rdy) vec '10' dead
// full equation result can never be true => vec '11' dead
CHECKSUM: "3634631500 2554342696"
MODULE: cmn_vrp_reg_fifo
Condition 1 "3214534030" "(in_vld && in_rdy) 1 -1" (2 "10")
Condition 3 "965361136" "((wr_addr == 0) && ((!full))) 1 -1" (2 "10")
Condition 4 "3964641420" "((wr_addr == 1) && ((!full))) 1 -1" (2 "10")
Condition 5 "3581426670" "((wr_addr == 2) && ((!full))) 1 -1" (2 "10")
Condition 6 "12428946" "((wr_addr == 3) && ((!full))) 1 -1" (2 "10")
Condition 7 "3317028309" "((wr_addr == 4) && ((!full))) 1 -1" (2 "10")
Condition 8 "275794089" "((wr_addr == 5) && ((!full))) 1 -1" (2 "10")
Condition 9 "692573131" "((wr_addr == 6) && ((!full))) 1 -1" (2 "10")
Condition 10 "4236398263" "((wr_addr == 7) && ((!full))) 1 -1" (2 "10")
Condition 11 "2380348167" "((wr_addr == 8) && ((!full))) 1 -1" (2 "10")
Condition 12 "1478796923" "((wr_addr == 9) && ((!full))) 1 -1" (2 "10")
Condition 13 "3314544975" "((wr_addr == 10) && ((!full))) 1 -1" (2 "10")
Condition 14 "273312819" "((wr_addr == 11) && ((!full))) 1 -1" (2 "10")
Condition 15 "696121169" "((wr_addr == 12) && ((!full))) 1 -1" (2 "10")
Condition 16 "4239944237" "((wr_addr == 13) && ((!full))) 1 -1" (2 "10")
Condition 17 "967842154" "((wr_addr == 14) && ((!full))) 1 -1" (2 "10")
Condition 18 "3967124502" "((wr_addr == 15) && ((!full))) 1 -1" (2 "10")
Condition 19 "3577880436" "((wr_addr == 16) && ((!full))) 1 -1" (2 "10")
Condition 20 "8880648" "((wr_addr == 17) && ((!full))) 1 -1" (2 "10")
Condition 21 "1910831032" "((wr_addr == 18) && ((!full))) 1 -1" (2 "10")
Condition 22 "2753653444" "((wr_addr == 19) && ((!full))) 1 -1" (2 "10")
Condition 23 "2145842406" "((wr_addr == 20) && ((!full))) 1 -1" (2 "10")
Condition 24 "2854447514" "((wr_addr == 21) && ((!full))) 1 -1" (2 "10")
Condition 25 "2467623672" "((wr_addr == 22) && ((!full))) 1 -1" (2 "10")
Condition 26 "1188130692" "((wr_addr == 23) && ((!full))) 1 -1" (2 "10")
Condition 27 "2212043971" "((wr_addr == 24) && ((!full))) 1 -1" (2 "10")
Condition 28 "1444708799" "((wr_addr == 25) && ((!full))) 1 -1" (2 "10")
Condition 29 "1865095901" "((wr_addr == 26) && ((!full))) 1 -1" (2 "10")
Condition 30 "3136194465" "((wr_addr == 27) && ((!full))) 1 -1" (2 "10")
Condition 31 "3415077393" "((wr_addr == 28) && ((!full))) 1 -1" (2 "10")
Condition 32 "508063597" "((wr_addr == 29) && ((!full))) 1 -1" (2 "10")
Condition 33 "846432525" "((wr_addr == 30) && ((!full))) 1 -1" (2 "10")
Condition 34 "3887469681" "((wr_addr == 31) && ((!full))) 1 -1" (2 "10")
Condition 35 "3733032723" "((wr_addr == 32) && ((!full))) 1 -1" (2 "10")
Condition 36 "189010543" "((wr_addr == 33) && ((!full))) 1 -1" (2 "10")
Condition 37 "3461112104" "((wr_addr == 34) && ((!full))) 1 -1" (2 "10")
Condition 38 "462027860" "((wr_addr == 35) && ((!full))) 1 -1" (2 "10")
Condition 39 "582903606" "((wr_addr == 36) && ((!full))) 1 -1" (2 "10")
Condition 40 "4152097354" "((wr_addr == 37) && ((!full))) 1 -1" (2 "10")
Condition 41 "2249756666" "((wr_addr == 38) && ((!full))) 1 -1" (2 "10")
Condition 42 "1406997126" "((wr_addr == 39) && ((!full))) 1 -1" (2 "10")
Condition 43 "183259955" "((wr_addr == 40) && ((!full))) 1 -1" (2 "10")
Condition 44 "3744058959" "((wr_addr == 41) && ((!full))) 1 -1" (2 "10")
Condition 45 "3860747565" "((wr_addr == 42) && ((!full))) 1 -1" (2 "10")
Condition 46 "870041681" "((wr_addr == 43) && ((!full))) 1 -1" (2 "10")
Condition 47 "4141071126" "((wr_addr == 44) && ((!full))) 1 -1" (2 "10")
Condition 48 "588654186" "((wr_addr == 45) && ((!full))) 1 -1" (2 "10")
Condition 49 "438418696" "((wr_addr == 46) && ((!full))) 1 -1" (2 "10")
Condition 50 "3487834228" "((wr_addr == 47) && ((!full))) 1 -1" (2 "10")
Condition 51 "3196540356" "((wr_addr == 48) && ((!full))) 1 -1" (2 "10")
Condition 52 "1799538872" "((wr_addr == 49) && ((!full))) 1 -1" (2 "10")
Condition 53 "1199124184" "((wr_addr == 50) && ((!full))) 1 -1" (2 "10")
Condition 54 "2461840292" "((wr_addr == 51) && ((!full))) 1 -1" (2 "10")
Condition 55 "2878023878" "((wr_addr == 52) && ((!full))) 1 -1" (2 "10")
Condition 56 "2119087546" "((wr_addr == 53) && ((!full))) 1 -1" (2 "10")
Condition 57 "3141977853" "((wr_addr == 54) && ((!full))) 1 -1" (2 "10")
Condition 58 "1854102401" "((wr_addr == 55) && ((!full))) 1 -1" (2 "10")
Condition 59 "1471463651" "((wr_addr == 56) && ((!full))) 1 -1" (2 "10")
Condition 60 "2188467615" "((wr_addr == 57) && ((!full))) 1 -1" (2 "10")
Condition 61 "4078053423" "((wr_addr == 58) && ((!full))) 1 -1" (2 "10")
Condition 62 "651670867" "((wr_addr == 59) && ((!full))) 1 -1" (2 "10")
Condition 63 "4245695345" "((wr_addr == 60) && ((!full))) 1 -1" (2 "10")
Condition 64 "685094413" "((wr_addr == 61) && ((!full))) 1 -1" (2 "10")
Condition 65 "300035439" "((wr_addr == 62) && ((!full))) 1 -1" (2 "10")
Condition 66 "3290935315" "((wr_addr == 63) && ((!full))) 1 -1" (2 "10")
Condition 67 "19907412" "((wr_addr == 64) && ((!full))) 1 -1" (2 "10")
Condition 68 "3572129320" "((wr_addr == 65) && ((!full))) 1 -1" (2 "10")
Condition 69 "3990734154" "((wr_addr == 66) && ((!full))) 1 -1" (2 "10")
Condition 70 "941119542" "((wr_addr == 67) && ((!full))) 1 -1" (2 "10")
Condition 71 "1232809350" "((wr_addr == 68) && ((!full))) 1 -1" (2 "10")
Condition 72 "2629742842" "((wr_addr == 69) && ((!full))) 1 -1" (2 "10")
Condition 73 "2961528474" "((wr_addr == 70) && ((!full))) 1 -1" (2 "10")
Condition 74 "1698745318" "((wr_addr == 71) && ((!full))) 1 -1" (2 "10")
Condition 75 "1551323268" "((wr_addr == 72) && ((!full))) 1 -1" (2 "10")
Condition 76 "2310196728" "((wr_addr == 73) && ((!full))) 1 -1" (2 "10")
Condition 77 "1287306943" "((wr_addr == 74) && ((!full))) 1 -1" (2 "10")
Condition 78 "2575246275" "((wr_addr == 75) && ((!full))) 1 -1" (2 "10")
Condition 79 "2689120417" "((wr_addr == 76) && ((!full))) 1 -1" (2 "10")
Condition 80 "1972184541" "((wr_addr == 77) && ((!full))) 1 -1" (2 "10")
Condition 81 "82727021" "((wr_addr == 78) && ((!full))) 1 -1" (2 "10")
Condition 82 "3509308689" "((wr_addr == 79) && ((!full))) 1 -1" (2 "10")
Condition 83 "2269279574" "((wr_addr == 80) && ((!full))) 1 -1" (2 "10")
Condition 84 "1384638506" "((wr_addr == 81) && ((!full))) 1 -1" (2 "10")
Condition 85 "1806725960" "((wr_addr == 82) && ((!full))) 1 -1" (2 "10")
Condition 86 "3195399732" "((wr_addr == 83) && ((!full))) 1 -1" (2 "10")
Condition 87 "2071829875" "((wr_addr == 84) && ((!full))) 1 -1" (2 "10")
Condition 88 "2931294223" "((wr_addr == 85) && ((!full))) 1 -1" (2 "10")
Condition 89 "2542771053" "((wr_addr == 86) && ((!full))) 1 -1" (2 "10")
Condition 90 "1112147473" "((wr_addr == 87) && ((!full))) 1 -1" (2 "10")
Condition 91 "858354593" "((wr_addr == 88) && ((!full))) 1 -1" (2 "10")
Condition 92 "3874287325" "((wr_addr == 89) && ((!full))) 1 -1" (2 "10")
Condition 93 "3403090109" "((wr_addr == 90) && ((!full))) 1 -1" (2 "10")
Condition 94 "521311681" "((wr_addr == 91) && ((!full))) 1 -1" (2 "10")
Condition 95 "639962787" "((wr_addr == 92) && ((!full))) 1 -1" (2 "10")
Condition 96 "4091581407" "((wr_addr == 93) && ((!full))) 1 -1" (2 "10")
Condition 97 "921231512" "((wr_addr == 94) && ((!full))) 1 -1" (2 "10")
Condition 98 "3811409380" "((wr_addr == 95) && ((!full))) 1 -1" (2 "10")
Condition 99 "3659196038" "((wr_addr == 96) && ((!full))) 1 -1" (2 "10")
Condition 100 "266304506" "((wr_addr == 97) && ((!full))) 1 -1" (2 "10")
Condition 101 "2126253642" "((wr_addr == 98) && ((!full))) 1 -1" (2 "10")
Condition 102 "2876871478" "((wr_addr == 99) && ((!full))) 1 -1" (2 "10")
Condition 103 "2922201954" "((wr_addr == 100) && ((!full))) 1 -1" (2 "10")
Condition 104 "2078858782" "((wr_addr == 101) && ((!full))) 1 -1" (2 "10")
Condition 105 "1121928572" "((wr_addr == 102) && ((!full))) 1 -1" (2 "10")
Condition 106 "2535118848" "((wr_addr == 103) && ((!full))) 1 -1" (2 "10")
Condition 107 "1376955207" "((wr_addr == 104) && ((!full))) 1 -1" (2 "10")
Condition 108 "2279028283" "((wr_addr == 105) && ((!full))) 1 -1" (2 "10")
Condition 109 "3202395481" "((wr_addr == 106) && ((!full))) 1 -1" (2 "10")
Condition 110 "1797599269" "((wr_addr == 107) && ((!full))) 1 -1" (2 "10")
Condition 111 "440812949" "((wr_addr == 108) && ((!full))) 1 -1" (2 "10")
Condition 112 "3481524457" "((wr_addr == 109) && ((!full))) 1 -1" (2 "10")
Condition 113 "3820502665" "((wr_addr == 110) && ((!full))) 1 -1" (2 "10")
Condition 114 "914203637" "((wr_addr == 111) && ((!full))) 1 -1" (2 "10")
Condition 115 "256522391" "((wr_addr == 112) && ((!full))) 1 -1" (2 "10")
Condition 116 "3666847211" "((wr_addr == 113) && ((!full))) 1 -1" (2 "10")
Condition 117 "528996012" "((wr_addr == 114) && ((!full))) 1 -1" (2 "10")
Condition 118 "3393342416" "((wr_addr == 115) && ((!full))) 1 -1" (2 "10")
Condition 119 "4084584626" "((wr_addr == 116) && ((!full))) 1 -1" (2 "10")
Condition 120 "649088462" "((wr_addr == 117) && ((!full))) 1 -1" (2 "10")
Condition 121 "1473460350" "((wr_addr == 118) && ((!full))) 1 -1" (2 "10")
Condition 122 "2182522114" "((wr_addr == 119) && ((!full))) 1 -1" (2 "10")
Condition 123 "1506884384" "((wr_addr == 120) && ((!full))) 1 -1" (2 "10")
Condition 124 "2350163548" "((wr_addr == 121) && ((!full))) 1 -1" (2 "10")
Condition 125 "3038985534" "((wr_addr == 122) && ((!full))) 1 -1" (2 "10")
Condition 126 "1625727042" "((wr_addr == 123) && ((!full))) 1 -1" (2 "10")
Condition 127 "2783892229" "((wr_addr == 124) && ((!full))) 1 -1" (2 "10")
Condition 128 "1881886329" "((wr_addr == 125) && ((!full))) 1 -1" (2 "10")
Condition 129 "1226626331" "((wr_addr == 126) && ((!full))) 1 -1" (2 "10")
Condition 130 "2631485543" "((wr_addr == 127) && ((!full))) 1 -1" (2 "10")
Condition 131 "3988405719" "((wr_addr == 128) && ((!full))) 1 -1" (2 "10")
Condition 132 "947888299" "((wr_addr == 129) && ((!full))) 1 -1" (2 "10")
Condition 133 "340018891" "((wr_addr == 130) && ((!full))) 1 -1" (2 "10")
Condition 134 "3246513079" "((wr_addr == 131) && ((!full))) 1 -1" (2 "10")
Condition 135 "4172693717" "((wr_addr == 132) && ((!full))) 1 -1" (2 "10")
Condition 136 "762568105" "((wr_addr == 133) && ((!full))) 1 -1" (2 "10")
Condition 137 "3900419822" "((wr_addr == 134) && ((!full))) 1 -1" (2 "10")
Condition 138 "1035875218" "((wr_addr == 135) && ((!full))) 1 -1" (2 "10")
Condition 139 "76130544" "((wr_addr == 136) && ((!full))) 1 -1" (2 "10")
Condition 140 "3511432588" "((wr_addr == 137) && ((!full))) 1 -1" (2 "10")
Condition 141 "2687451196" "((wr_addr == 138) && ((!full))) 1 -1" (2 "10")
Condition 142 "1978326336" "((wr_addr == 139) && ((!full))) 1 -1" (2 "10")
Condition 143 "752590069" "((wr_addr == 140) && ((!full))) 1 -1" (2 "10")
Condition 144 "4179493257" "((wr_addr == 141) && ((!full))) 1 -1" (2 "10")
Condition 145 "3223952107" "((wr_addr == 142) && ((!full))) 1 -1" (2 "10")
Condition 146 "367789975" "((wr_addr == 143) && ((!full))) 1 -1" (2 "10")
Condition 147 "3504633040" "((wr_addr == 144) && ((!full))) 1 -1" (2 "10")
Condition 148 "86108588" "((wr_addr == 145) && ((!full))) 1 -1" (2 "10")
Condition 149 "1008104142" "((wr_addr == 146) && ((!full))) 1 -1" (2 "10")
Condition 150 "3922980786" "((wr_addr == 147) && ((!full))) 1 -1" (2 "10")
Condition 151 "2561710594" "((wr_addr == 148) && ((!full))) 1 -1" (2 "10")
Condition 152 "1299515262" "((wr_addr == 149) && ((!full))) 1 -1" (2 "10")
Condition 153 "1632559390" "((wr_addr == 150) && ((!full))) 1 -1" (2 "10")
Condition 154 "3029040226" "((wr_addr == 151) && ((!full))) 1 -1" (2 "10")
Condition 155 "2377967360" "((wr_addr == 152) && ((!full))) 1 -1" (2 "10")
Condition 156 "1484356220" "((wr_addr == 153) && ((!full))) 1 -1" (2 "10")
Condition 157 "2641430843" "((wr_addr == 154) && ((!full))) 1 -1" (2 "10")
Condition 158 "1219793991" "((wr_addr == 155) && ((!full))) 1 -1" (2 "10")
Condition 159 "1904414501" "((wr_addr == 156) && ((!full))) 1 -1" (2 "10")
Condition 160 "2756088409" "((wr_addr == 157) && ((!full))) 1 -1" (2 "10")
Condition 161 "3576031209" "((wr_addr == 158) && ((!full))) 1 -1" (2 "10")
Condition 162 "14711445" "((wr_addr == 159) && ((!full))) 1 -1" (2 "10")
Condition 163 "3676824759" "((wr_addr == 160) && ((!full))) 1 -1" (2 "10")
Condition 164 "249723339" "((wr_addr == 161) && ((!full))) 1 -1" (2 "10")
Condition 165 "936764073" "((wr_addr == 162) && ((!full))) 1 -1" (2 "10")
Condition 166 "3792732117" "((wr_addr == 163) && ((!full))) 1 -1" (2 "10")
Condition 167 "655887506" "((wr_addr == 164) && ((!full))) 1 -1" (2 "10")
Condition 168 "4074607086" "((wr_addr == 165) && ((!full))) 1 -1" (2 "10")
Condition 169 "3421112972" "((wr_addr == 166) && ((!full))) 1 -1" (2 "10")
Condition 170 "506435568" "((wr_addr == 167) && ((!full))) 1 -1" (2 "10")
Condition 171 "1867309632" "((wr_addr == 168) && ((!full))) 1 -1" (2 "10")
Condition 172 "3129573180" "((wr_addr == 169) && ((!full))) 1 -1" (2 "10")
Condition 173 "2528287068" "((wr_addr == 170) && ((!full))) 1 -1" (2 "10")
Condition 174 "1131873312" "((wr_addr == 171) && ((!full))) 1 -1" (2 "10")
Condition 175 "2051055426" "((wr_addr == 172) && ((!full))) 1 -1" (2 "10")
Condition 176 "2944729662" "((wr_addr == 173) && ((!full))) 1 -1" (2 "10")
Condition 177 "1787654521" "((wr_addr == 174) && ((!full))) 1 -1" (2 "10")
Condition 178 "3209227269" "((wr_addr == 175) && ((!full))) 1 -1" (2 "10")
Condition 179 "2256500583" "((wr_addr == 176) && ((!full))) 1 -1" (2 "10")
Condition 180 "1404758555" "((wr_addr == 177) && ((!full))) 1 -1" (2 "10")
Condition 181 "584687531" "((wr_addr == 178) && ((!full))) 1 -1" (2 "10")
Condition 182 "4145808087" "((wr_addr == 179) && ((!full))) 1 -1" (2 "10")
Condition 183 "2708847248" "((wr_addr == 180) && ((!full))) 1 -1" (2 "10")
Condition 184 "1957701612" "((wr_addr == 181) && ((!full))) 1 -1" (2 "10")
Condition 185 "1300741262" "((wr_addr == 182) && ((!full))) 1 -1" (2 "10")
Condition 186 "2554470898" "((wr_addr == 183) && ((!full))) 1 -1" (2 "10")
Condition 187 "1565151925" "((wr_addr == 184) && ((!full))) 1 -1" (2 "10")
Condition 188 "2291126217" "((wr_addr == 185) && ((!full))) 1 -1" (2 "10")
Condition 189 "2981647531" "((wr_addr == 186) && ((!full))) 1 -1" (2 "10")
Condition 190 "1685965271" "((wr_addr == 187) && ((!full))) 1 -1" (2 "10")
Condition 191 "354335847" "((wr_addr == 188) && ((!full))) 1 -1" (2 "10")
Condition 192 "3235586331" "((wr_addr == 189) && ((!full))) 1 -1" (2 "10")
Condition 193 "3974154107" "((wr_addr == 190) && ((!full))) 1 -1" (2 "10")
Condition 194 "958749191" "((wr_addr == 191) && ((!full))) 1 -1" (2 "10")
Condition 195 "1229157" "((wr_addr == 192) && ((!full))) 1 -1" (2 "10")
Condition 196 "3587660825" "((wr_addr == 193) && ((!full))) 1 -1" (2 "10")
Condition 197 "283062110" "((wr_addr == 194) && ((!full))) 1 -1" (2 "10")
Condition 198 "3306861090" "((wr_addr == 195) && ((!full))) 1 -1" (2 "10")
Condition 199 "4230818112" "((wr_addr == 196) && ((!full))) 1 -1" (2 "10")
Condition 200 "703116348" "((wr_addr == 197) && ((!full))) 1 -1" (2 "10")
Condition 201 "1485554060" "((wr_addr == 198) && ((!full))) 1 -1" (2 "10")
Condition 202 "2370723056" "((wr_addr == 199) && ((!full))) 1 -1" (2 "10")
Condition 203 "1694077012" "((wr_addr == 200) && ((!full))) 1 -1" (2 "10")
Condition 204 "2973502760" "((wr_addr == 201) && ((!full))) 1 -1" (2 "10")
Condition 205 "2282460746" "((wr_addr == 202) && ((!full))) 1 -1" (2 "10")
Condition 206 "1573784374" "((wr_addr == 203) && ((!full))) 1 -1" (2 "10")
Condition 207 "2563143793" "((wr_addr == 204) && ((!full))) 1 -1" (2 "10")
Condition 208 "1292100877" "((wr_addr == 205) && ((!full))) 1 -1" (2 "10")
Condition 209 "1949597295" "((wr_addr == 206) && ((!full))) 1 -1" (2 "10")
Condition 210 "2716984083" "((wr_addr == 207) && ((!full))) 1 -1" (2 "10")
Condition 211 "3499267747" "((wr_addr == 208) && ((!full))) 1 -1" (2 "10")
Condition 212 "89590751" "((wr_addr == 209) && ((!full))) 1 -1" (2 "10")
Condition 213 "695004607" "((wr_addr == 210) && ((!full))) 1 -1" (2 "10")
Condition 214 "4238962883" "((wr_addr == 211) && ((!full))) 1 -1" (2 "10")
Condition 215 "3315526561" "((wr_addr == 212) && ((!full))) 1 -1" (2 "10")
Condition 216 "274429661" "((wr_addr == 213) && ((!full))) 1 -1" (2 "10")
Condition 217 "3578987930" "((wr_addr == 214) && ((!full))) 1 -1" (2 "10")
Condition 218 "9869542" "((wr_addr == 215) && ((!full))) 1 -1" (2 "10")
Condition 219 "966853508" "((wr_addr == 216) && ((!full))) 1 -1" (2 "10")
Condition 220 "3966017272" "((wr_addr == 217) && ((!full))) 1 -1" (2 "10")
Condition 221 "2634541896" "((wr_addr == 218) && ((!full))) 1 -1" (2 "10")
Condition 222 "1220703796" "((wr_addr == 219) && ((!full))) 1 -1" (2 "10")
Condition 223 "2466637846" "((wr_addr == 220) && ((!full))) 1 -1" (2 "10")
Condition 224 "1187018090" "((wr_addr == 221) && ((!full))) 1 -1" (2 "10")
Condition 225 "2146954760" "((wr_addr == 222) && ((!full))) 1 -1" (2 "10")
Condition 226 "2855433076" "((wr_addr == 223) && ((!full))) 1 -1" (2 "10")
Condition 227 "1866072115" "((wr_addr == 224) && ((!full))) 1 -1" (2 "10")
Condition 228 "3137314127" "((wr_addr == 225) && ((!full))) 1 -1" (2 "10")
Condition 229 "2210924077" "((wr_addr == 226) && ((!full))) 1 -1" (2 "10")
Condition 230 "1443732305" "((wr_addr == 227) && ((!full))) 1 -1" (2 "10")
Condition 231 "661581537" "((wr_addr == 228) && ((!full))) 1 -1" (2 "10")
Condition 232 "4071322525" "((wr_addr == 229) && ((!full))) 1 -1" (2 "10")
Condition 233 "3734017533" "((wr_addr == 230) && ((!full))) 1 -1" (2 "10")
Condition 234 "190122113" "((wr_addr == 231) && ((!full))) 1 -1" (2 "10")
Condition 235 "845321187" "((wr_addr == 232) && ((!full))) 1 -1" (2 "10")
Condition 236 "3886485151" "((wr_addr == 233) && ((!full))) 1 -1" (2 "10")
Condition 237 "581926360" "((wr_addr == 234) && ((!full))) 1 -1" (2 "10")
Condition 238 "4150976676" "((wr_addr == 235) && ((!full))) 1 -1" (2 "10")
Condition 239 "3462233030" "((wr_addr == 236) && ((!full))) 1 -1" (2 "10")
Condition 240 "463005370" "((wr_addr == 237) && ((!full))) 1 -1" (2 "10")
Condition 241 "1794872074" "((wr_addr == 238) && ((!full))) 1 -1" (2 "10")
Condition 242 "3208515190" "((wr_addr == 239) && ((!full))) 1 -1" (2 "10")
Condition 243 "3859763139" "((wr_addr == 240) && ((!full))) 1 -1" (2 "10")
Condition 244 "868930239" "((wr_addr == 241) && ((!full))) 1 -1" (2 "10")
Condition 245 "184371677" "((wr_addr == 242) && ((!full))) 1 -1" (2 "10")
Condition 246 "3745043617" "((wr_addr == 243) && ((!full))) 1 -1" (2 "10")
Condition 247 "439396326" "((wr_addr == 244) && ((!full))) 1 -1" (2 "10")
Condition 248 "3488955034" "((wr_addr == 245) && ((!full))) 1 -1" (2 "10")
Condition 249 "4139950584" "((wr_addr == 246) && ((!full))) 1 -1" (2 "10")
Condition 250 "587676804" "((wr_addr == 247) && ((!full))) 1 -1" (2 "10")
Condition 251 "1382304052" "((wr_addr == 248) && ((!full))) 1 -1" (2 "10")
Condition 252 "2275529800" "((wr_addr == 249) && ((!full))) 1 -1" (2 "10")
Condition 253 "2879009320" "((wr_addr == 250) && ((!full))) 1 -1" (2 "10")
Condition 254 "2120200020" "((wr_addr == 251) && ((!full))) 1 -1" (2 "10")
Condition 255 "1198011446" "((wr_addr == 252) && ((!full))) 1 -1" (2 "10")
Condition 256 "2460854602" "((wr_addr == 253) && ((!full))) 1 -1" (2 "10")
Condition 257 "1470487053" "((wr_addr == 254) && ((!full))) 1 -1" (2 "10")
Condition 258 "2187347825" "((wr_addr == 255) && ((!full))) 1 -1" (2 "10")
Condition 259 "271352162" "((wr_ptr[(PTR_WIDTH - 1)] != rd_ptr[(PTR_WIDTH - 1)]) && (wr_ptr[(PTR_WIDTH - 2):0] == rd_ptr[(PTR_WIDTH - 2):0])) 1 -1" (3 "11")

// ============================================================================
// Round 12 TOGGLE waivers - structural dead / non-functional signals
// ============================================================================

// --- Base_RegSpaceBase_cfg_reg_bank_table [clk_rst, cti_debug] ---
CHECKSUM: "1679471348 3804278089"
MODULE: Base_RegSpaceBase_cfg_reg_bank_table
Toggle clk "net clk"
Toggle rst_n "net rst_n"
Toggle debug_en_debug_en_rdat "net debug_en_debug_en_rdat[31:0]"
Toggle timing_bus1_timing_bus1_rdat "net timing_bus1_timing_bus1_rdat[31:0]"
Toggle timing_bus2_timing_bus2_rdat "net timing_bus2_timing_bus2_rdat[31:0]"
Toggle timing_bus3_timing_bus3_rdat "net timing_bus3_timing_bus3_rdat[31:0]"
Toggle debug_data_gate_debug_data_gate_rdat "net debug_data_gate_debug_data_gate_rdat[31:0]"
Toggle debug_en_rdat "net debug_en_rdat[31:0]"
Toggle debug_en_rrdy "net debug_en_rrdy[0:0]"
Toggle debug_en_rvld "net debug_en_rvld[0:0]"
Toggle debug_en_wdat "net debug_en_wdat[31:0]"
Toggle debug_en_wrdy "net debug_en_wrdy[0:0]"
Toggle debug_en_wvld "net debug_en_wvld[0:0]"
Toggle debug_en_debug_en "reg debug_en_debug_en[31:0]"
Toggle timing_bus1_rdat "net timing_bus1_rdat[31:0]"
Toggle timing_bus1_rrdy "net timing_bus1_rrdy[0:0]"
Toggle timing_bus1_rvld "net timing_bus1_rvld[0:0]"
Toggle timing_bus1_wdat "net timing_bus1_wdat[31:0]"
Toggle timing_bus1_wrdy "net timing_bus1_wrdy[0:0]"
Toggle timing_bus1_wvld "net timing_bus1_wvld[0:0]"
Toggle timing_bus1_timing_bus1 "reg timing_bus1_timing_bus1[31:0]"
Toggle timing_bus2_rdat "net timing_bus2_rdat[31:0]"
Toggle timing_bus2_rrdy "net timing_bus2_rrdy[0:0]"
Toggle timing_bus2_rvld "net timing_bus2_rvld[0:0]"
Toggle timing_bus2_wdat "net timing_bus2_wdat[31:0]"
Toggle timing_bus2_wrdy "net timing_bus2_wrdy[0:0]"
Toggle timing_bus2_wvld "net timing_bus2_wvld[0:0]"
Toggle timing_bus2_timing_bus2 "reg timing_bus2_timing_bus2[31:0]"
Toggle timing_bus3_rdat "net timing_bus3_rdat[31:0]"
Toggle timing_bus3_rrdy "net timing_bus3_rrdy[0:0]"
Toggle timing_bus3_rvld "net timing_bus3_rvld[0:0]"
Toggle timing_bus3_wdat "net timing_bus3_wdat[31:0]"
Toggle timing_bus3_wrdy "net timing_bus3_wrdy[0:0]"
Toggle timing_bus3_wvld "net timing_bus3_wvld[0:0]"
Toggle timing_bus3_timing_bus3 "reg timing_bus3_timing_bus3[31:0]"
Toggle debug_data_gate_rdat "net debug_data_gate_rdat[31:0]"
Toggle debug_data_gate_rrdy "net debug_data_gate_rrdy[0:0]"
Toggle debug_data_gate_rvld "net debug_data_gate_rvld[0:0]"
Toggle debug_data_gate_wdat "net debug_data_gate_wdat[31:0]"
Toggle debug_data_gate_wrdy "net debug_data_gate_wrdy[0:0]"
Toggle debug_data_gate_wvld "net debug_data_gate_wvld[0:0]"
Toggle debug_data_gate_debug_data_gate "reg debug_data_gate_debug_data_gate[31:0]"

// --- Base_cti_handle [clk_rst, cti_debug] ---
CHECKSUM: "1152322260 970643933"
MODULE: Base_cti_handle
Toggle clk_src "logic clk_src"
Toggle clk_dst "logic clk_dst"
Toggle rstn_src "logic rstn_src"
Toggle rstn_dst "logic rstn_dst"
Toggle cti_event_in "logic cti_event_in[7:0]"
Toggle cti_event_in_req "logic cti_event_in_req[7:0]"
Toggle cti_event_in_ack "logic cti_event_in_ack[7:0]"
Toggle cti_channel_in "logic cti_channel_in[7:0]"
Toggle cti_channel_in_req "logic cti_channel_in_req[7:0]"
Toggle cti_channel_in_ack "logic cti_channel_in_ack[7:0]"

// --- Base_lwnoc_flow_ctrl_chk [dead_payload, flow_ctrl_dead] ---
CHECKSUM: "2312387679 947793373"
MODULE: Base_lwnoc_flow_ctrl_chk
Toggle in_pld.req.size "logic in_pld.req.size[2:0]"
Toggle in_pld.req.burst "logic in_pld.req.burst[1:0]"
Toggle out_pld.req.size "logic out_pld.req.size[2:0]"
Toggle out_pld.req.burst "logic out_pld.req.burst[1:0]"
Toggle busy_flag "logic busy_flag"

// --- Base_sts_apb_stub_slave [clk_rst] ---
CHECKSUM: "3851199999 587280344"
MODULE: Base_sts_apb_stub_slave
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- Base_sts_iniu_axi_iniu [clk_rst, dead_payload] ---
CHECKSUM: "1437876289 1179372252"
MODULE: Base_sts_iniu_axi_iniu
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"
Toggle out_req_pld.req.size "logic out_req_pld.req.size[2:0]"
Toggle out_req_pld.req.burst "logic out_req_pld.req.burst[1:0]"
Toggle wr_req_pld.req.size "logic wr_req_pld.req.size[2:0]"
Toggle wr_req_pld.req.burst "logic wr_req_pld.req.burst[1:0]"
Toggle rd_req_pld.req.size "logic rd_req_pld.req.size[2:0]"
Toggle rd_req_pld.req.burst "logic rd_req_pld.req.burst[1:0]"
Toggle arb_pld.req.size "logic arb_pld.req.size[2:0]"
Toggle arb_pld.req.burst "logic arb_pld.req.burst[1:0]"

// --- Base_sts_iniu_noc [clk_rst, cti_debug, dead_payload] ---
CHECKSUM: "3224443634 375832414"
MODULE: Base_sts_iniu_noc
Toggle clk_dst "logic clk_dst"
Toggle rst_n_dst "logic rst_n_dst"
Toggle clk_src "logic clk_src"
Toggle rst_n_src "logic rst_n_src"
Toggle req_s_pld.req.size "logic req_s_pld.req.size[2:0]"
Toggle req_s_pld.req.burst "logic req_s_pld.req.burst[1:0]"
Toggle dbg_data_in "logic dbg_data_in[31:0]"
Toggle dbg_data_out "logic dbg_data_out[31:0]"
Toggle cti_event_in "logic cti_event_in[7:0]"
Toggle cti_event_in_req "logic cti_event_in_req[7:0]"
Toggle cti_event_in_ack "logic cti_event_in_ack[7:0]"
Toggle cti_channel_in "logic cti_channel_in[7:0]"
Toggle cti_channel_in_req "logic cti_channel_in_req[7:0]"
Toggle cti_channel_in_ack "logic cti_channel_in_ack[7:0]"
Toggle dbg_timestamp_out "logic dbg_timestamp_out[63:0]"

// --- Base_sts_iniu_rd_channel [clk_rst, dead_payload] ---
CHECKSUM: "4115085934 3089047861"
MODULE: Base_sts_iniu_rd_channel
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"
Toggle out_req_pld.req.size "logic out_req_pld.req.size[2:0]"
Toggle out_req_pld.req.burst "logic out_req_pld.req.burst[1:0]"
Toggle fifo_in_ar_pld.req.size "logic fifo_in_ar_pld.req.size[2:0]"
Toggle fifo_in_ar_pld.req.burst "logic fifo_in_ar_pld.req.burst[1:0]"
Toggle fifo_out_ar_pld.req.size "logic fifo_out_ar_pld.req.size[2:0]"
Toggle fifo_out_ar_pld.req.burst "logic fifo_out_ar_pld.req.burst[1:0]"
Toggle ar_hold_pld.req.size "logic ar_hold_pld.req.size[2:0]"
Toggle ar_hold_pld.req.burst "logic ar_hold_pld.req.burst[1:0]"

// --- Base_sts_iniu_sys [clk_rst, cti_debug, dead_payload] ---
CHECKSUM: "3047891155 2362043708"
MODULE: Base_sts_iniu_sys
Toggle clk_src "logic clk_src"
Toggle clk_dst "logic clk_dst"
Toggle rstn_src "logic rstn_src"
Toggle rstn_dst "logic rstn_dst"
Toggle cti_event_in "logic cti_event_in[7:0]"
Toggle cti_event_in_req "logic cti_event_in_req[7:0]"
Toggle cti_event_in_ack "logic cti_event_in_ack[7:0]"
Toggle cti_channel_in "logic cti_channel_in[7:0]"
Toggle cti_channel_in_req "logic cti_channel_in_req[7:0]"
Toggle cti_channel_in_ack "logic cti_channel_in_ack[7:0]"
Toggle dbg_timestamp_out "logic dbg_timestamp_out[63:0]"
Toggle dbg_data_in "logic dbg_data_in[31:0]"
Toggle dbg_data_out "logic dbg_data_out[31:0]"
Toggle req_pld_temp.req.size "logic req_pld_temp.req.size[2:0]"
Toggle req_pld_temp.req.burst "logic req_pld_temp.req.burst[1:0]"

// --- Base_sts_iniu_top [clk_rst, cti_debug, dead_payload] ---
CHECKSUM: "172948656 3544573874"
MODULE: Base_sts_iniu_top
Toggle clk_src "logic clk_src"
Toggle clk_dst "logic clk_dst"
Toggle rstn_src "logic rstn_src"
Toggle rstn_dst "logic rstn_dst"
Toggle out_req_pld.req.size "logic out_req_pld.req.size[2:0]"
Toggle out_req_pld.req.burst "logic out_req_pld.req.burst[1:0]"
Toggle sys_cti_event_in "logic sys_cti_event_in[7:0]"
Toggle sys_cti_event_out "logic sys_cti_event_out[7:0]"
Toggle sys_cti_channel_in "logic sys_cti_channel_in[7:0]"
Toggle sys_cti_channel_out "logic sys_cti_channel_out[7:0]"
Toggle dbg_timestamp_out "logic dbg_timestamp_out[63:0]"
Toggle dbg_data_in "logic dbg_data_in[31:0]"
Toggle dbg_data_out "logic dbg_data_out[31:0]"
Toggle dbg_timestamp_tmp "logic dbg_timestamp_tmp[63:0]"
Toggle dbg_data_tmp "logic dbg_data_tmp[31:0]"

// --- Base_sts_iniu_wr_channel [clk_rst, dead_payload] ---
CHECKSUM: "1611148050 3365547349"
MODULE: Base_sts_iniu_wr_channel
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"
Toggle out_req_pld.req.size "logic out_req_pld.req.size[2:0]"
Toggle out_req_pld.req.burst "logic out_req_pld.req.burst[1:0]"
Toggle merged_req_pld.req.size "logic merged_req_pld.req.size[2:0]"
Toggle merged_req_pld.req.burst "logic merged_req_pld.req.burst[1:0]"
Toggle rs_out_pld.req.size "logic rs_out_pld.req.size[2:0]"
Toggle rs_out_pld.req.burst "logic rs_out_pld.req.burst[1:0]"

// --- Base_sts_noc_1iniu_3tniu_dut [clk_rst, cti_debug, dead_payload] ---
CHECKSUM: "2477951387 3040048395"
MODULE: Base_sts_noc_1iniu_3tniu_dut
Toggle clk_src "logic clk_src"
Toggle clk_dst "logic clk_dst"
Toggle clk_dbg_timer "logic clk_dbg_timer"
Toggle rstn_src "logic rstn_src"
Toggle rstn_dst "logic rstn_dst"
Toggle rstn_dbg_timer "logic rstn_dbg_timer"
Toggle sys_cti_event_in "logic sys_cti_event_in[7:0]"
Toggle sys_cti_event_out "logic sys_cti_event_out[7:0]"
Toggle sys_cti_channel_in "logic sys_cti_channel_in[7:0]"
Toggle sys_cti_channel_out "logic sys_cti_channel_out[7:0]"
Toggle dbg_data_in "logic dbg_data_in[31:0]"
Toggle dbg_timestamp_out_0 "logic dbg_timestamp_out_0[63:0]"
Toggle dbg_timestamp_out_1 "logic dbg_timestamp_out_1[63:0]"
Toggle dbg_timestamp_out_2 "logic dbg_timestamp_out_2[63:0]"
Toggle dbg_data_out_0 "logic dbg_data_out_0[31:0]"
Toggle dbg_data_out_1 "logic dbg_data_out_1[31:0]"
Toggle dbg_data_out_2 "logic dbg_data_out_2[31:0]"
Toggle timing_bus1 "logic [2:0][31:0]timing_bus1"
Toggle timing_bus2 "logic [2:0][31:0]timing_bus2"
Toggle timing_bus3 "logic [2:0][31:0]timing_bus3"
Toggle dbg_en "logic [2:0][31:0]dbg_en"
Toggle iniu_req_pld.req.size "logic iniu_req_pld.req.size[2:0]"
Toggle iniu_req_pld.req.burst "logic iniu_req_pld.req.burst[1:0]"
Toggle tniu0_req_pld.req.size "logic tniu0_req_pld.req.size[2:0]"
Toggle tniu0_req_pld.req.burst "logic tniu0_req_pld.req.burst[1:0]"
Toggle tniu1_req_pld.req.size "logic tniu1_req_pld.req.size[2:0]"
Toggle tniu1_req_pld.req.burst "logic tniu1_req_pld.req.burst[1:0]"
Toggle tniu2_req_pld.req.size "logic tniu2_req_pld.req.size[2:0]"
Toggle tniu2_req_pld.req.burst "logic tniu2_req_pld.req.burst[1:0]"
Toggle noc_cti_event_out_0 "logic noc_cti_event_out_0[7:0]"
Toggle noc_cti_event_out_1 "logic noc_cti_event_out_1[7:0]"
Toggle noc_cti_event_out_2 "logic noc_cti_event_out_2[7:0]"
Toggle noc_cti_channel_out_0 "logic noc_cti_channel_out_0[7:0]"
Toggle noc_cti_channel_out_1 "logic noc_cti_channel_out_1[7:0]"
Toggle noc_cti_channel_out_2 "logic noc_cti_channel_out_2[7:0]"
Toggle iniu_noc_cti_event_out "logic iniu_noc_cti_event_out[7:0]"
Toggle iniu_noc_cti_channel_out "logic iniu_noc_cti_channel_out[7:0]"

// --- Base_sts_noc_req_router_1to3 [dead_payload] ---
CHECKSUM: "3111419975 3722419792"
MODULE: Base_sts_noc_req_router_1to3
Toggle in_req_pld.req.size "logic in_req_pld.req.size[2:0]"
Toggle in_req_pld.req.burst "logic in_req_pld.req.burst[1:0]"
Toggle tniu0_req_pld.req.size "logic tniu0_req_pld.req.size[2:0]"
Toggle tniu0_req_pld.req.burst "logic tniu0_req_pld.req.burst[1:0]"
Toggle tniu1_req_pld.req.size "logic tniu1_req_pld.req.size[2:0]"
Toggle tniu1_req_pld.req.burst "logic tniu1_req_pld.req.burst[1:0]"
Toggle tniu2_req_pld.req.size "logic tniu2_req_pld.req.size[2:0]"
Toggle tniu2_req_pld.req.burst "logic tniu2_req_pld.req.burst[1:0]"

// --- Base_sts_tniu_apb [clk_rst, dead_payload] ---
CHECKSUM: "1228083994 896648132"
MODULE: Base_sts_tniu_apb
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"
Toggle in_req_pld.req.size "logic in_req_pld.req.size[2:0]"
Toggle in_req_pld.req.burst "logic in_req_pld.req.burst[1:0]"
Toggle fifo_out_req_pld.req.size "logic fifo_out_req_pld.req.size[2:0]"
Toggle fifo_out_req_pld.req.burst "logic fifo_out_req_pld.req.burst[1:0]"
Toggle req_active_pld.req.size "logic req_active_pld.req.size[2:0]"
Toggle req_active_pld.req.burst "logic req_active_pld.req.burst[1:0]"

// --- Base_sts_tniu_apb_dec [clk_rst] ---
CHECKSUM: "3191209264 219563717"
MODULE: Base_sts_tniu_apb_dec
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- Base_sts_tniu_noc [afifo_ctrl, clk_rst, cti_debug, dead_payload] ---
CHECKSUM: "911015456 3619931088"
MODULE: Base_sts_tniu_noc
Toggle clk_src "logic clk_src"
Toggle clk_dst "logic clk_dst"
Toggle rstn_src "logic rstn_src"
Toggle rstn_dst "logic rstn_dst"
Toggle in_req_pld.req.size "logic in_req_pld.req.size[2:0]"
Toggle in_req_pld.req.burst "logic in_req_pld.req.burst[1:0]"
Toggle write_stall "logic write_stall"
Toggle write_clear "logic write_clear"
Toggle write_full_zero "logic write_full_zero"
Toggle dbg_data_in "logic dbg_data_in[31:0]"
Toggle dbg_data_out "logic dbg_data_out[31:0]"
Toggle dbg_timestamp_out "logic dbg_timestamp_out[63:0]"
Toggle cti_event_in "logic cti_event_in[7:0]"
Toggle cti_event_in_req "logic cti_event_in_req[7:0]"
Toggle cti_event_in_ack "logic cti_event_in_ack[7:0]"
Toggle cti_channel_in "logic cti_channel_in[7:0]"
Toggle cti_channel_in_req "logic cti_channel_in_req[7:0]"
Toggle cti_channel_in_ack "logic cti_channel_in_ack[7:0]"
Toggle timing_bus1 "logic timing_bus1[31:0]"
Toggle timing_bus2 "logic timing_bus2[31:0]"
Toggle timing_bus3 "logic timing_bus3[31:0]"
Toggle dbg_en "logic dbg_en[31:0]"
Toggle req_apb_tniu_pld.req.size "logic req_apb_tniu_pld.req.size[2:0]"
Toggle req_apb_tniu_pld.req.burst "logic req_apb_tniu_pld.req.burst[1:0]"
Toggle req_tniu_sys_pld.req.size "logic req_tniu_sys_pld.req.size[2:0]"
Toggle req_tniu_sys_pld.req.burst "logic req_tniu_sys_pld.req.burst[1:0]"
Toggle req_async_fifo_pld.req.size "logic req_async_fifo_pld.req.size[2:0]"
Toggle req_async_fifo_pld.req.burst "logic req_async_fifo_pld.req.burst[1:0]"
Toggle req_async_fifo_pld_tmp.req.size "logic req_async_fifo_pld_tmp.req.size[2:0]"
Toggle req_async_fifo_pld_tmp.req.burst "logic req_async_fifo_pld_tmp.req.burst[1:0]"
Toggle req_afifo_pld.req.size "logic req_afifo_pld.req.size[2:0]"
Toggle req_afifo_pld.req.burst "logic req_afifo_pld.req.burst[1:0]"
Toggle dbg_data_gate "logic dbg_data_gate[31:0]"
Toggle dbg_data_out_tmp "logic dbg_data_out_tmp[31:0]"
Toggle dbg_timestamp_tmp "logic dbg_timestamp_tmp[63:0]"

// --- Base_sts_tniu_sys [clk_rst, cti_debug, dead_payload] ---
CHECKSUM: "417801667 849917854"
MODULE: Base_sts_tniu_sys
Toggle clk_src "logic clk_src"
Toggle clk_dst "logic clk_dst"
Toggle clk_dbg_timer "logic clk_dbg_timer"
Toggle rstn_src "logic rstn_src"
Toggle rstn_dst "logic rstn_dst"
Toggle rstn_dbg_timer "logic rstn_dbg_timer"
Toggle cti_event_in "logic cti_event_in[7:0]"
Toggle cti_event_in_req "logic cti_event_in_req[7:0]"
Toggle cti_event_in_ack "logic cti_event_in_ack[7:0]"
Toggle cti_channel_in "logic cti_channel_in[7:0]"
Toggle cti_channel_in_req "logic cti_channel_in_req[7:0]"
Toggle cti_channel_in_ack "logic cti_channel_in_ack[7:0]"
Toggle dbg_data_in "logic dbg_data_in[31:0]"
Toggle dbg_data_out "logic dbg_data_out[31:0]"
Toggle dbg_timestamp_out "logic dbg_timestamp_out[63:0]"
Toggle req_apb_tniu_pld.req.size "logic req_apb_tniu_pld.req.size[2:0]"
Toggle req_apb_tniu_pld.req.burst "logic req_apb_tniu_pld.req.burst[1:0]"
Toggle req_apb_tniu_pld_tmp.req.size "logic req_apb_tniu_pld_tmp.req.size[2:0]"
Toggle req_apb_tniu_pld_tmp.req.burst "logic req_apb_tniu_pld_tmp.req.burst[1:0]"
Toggle dbg_timestamp_tmp "logic dbg_timestamp_tmp[63:0]"

// --- Base_sts_tniu_top [afifo_ctrl, clk_rst, cti_debug, dead_payload] ---
CHECKSUM: "731806648 2237614106"
MODULE: Base_sts_tniu_top
Toggle clk_src "logic clk_src"
Toggle clk_dst "logic clk_dst"
Toggle clk_dbg_timer "logic clk_dbg_timer"
Toggle rstn_src "logic rstn_src"
Toggle rstn_dst "logic rstn_dst"
Toggle rstn_dbg_timer "logic rstn_dbg_timer"
Toggle in_req_pld.req.size "logic in_req_pld.req.size[2:0]"
Toggle in_req_pld.req.burst "logic in_req_pld.req.burst[1:0]"
Toggle write_stall "logic write_stall"
Toggle write_clear "logic write_clear"
Toggle write_full_zero "logic write_full_zero"
Toggle dbg_data_in "logic dbg_data_in[31:0]"
Toggle dbg_data_out "logic dbg_data_out[31:0]"
Toggle dbg_timestamp_out "logic dbg_timestamp_out[63:0]"
Toggle sys_cti_event_in "logic sys_cti_event_in[7:0]"
Toggle sys_cti_event_out "logic sys_cti_event_out[7:0]"
Toggle sys_cti_channel_in "logic sys_cti_channel_in[7:0]"
Toggle sys_cti_channel_out "logic sys_cti_channel_out[7:0]"
Toggle timing_bus1 "logic timing_bus1[31:0]"
Toggle timing_bus2 "logic timing_bus2[31:0]"
Toggle timing_bus3 "logic timing_bus3[31:0]"
Toggle dbg_en "logic dbg_en[31:0]"
Toggle dbg_data_tmp "logic dbg_data_tmp[31:0]"
Toggle dbg_timestamp_tmp "logic dbg_timestamp_tmp[63:0]"

// --- age_matrix [clk_rst] ---
CHECKSUM: "58483087 1804361438"
MODULE: age_matrix
Toggle clk "net clk"
Toggle rst_n "net rst_n"

// --- apb2apb_async_bridge_qual [clk_rst] ---
CHECKSUM: "1033879960 218430297"
MODULE: apb2apb_async_bridge_qual
Toggle clk_s "logic clk_s"
Toggle rstn_s "logic rstn_s"
Toggle clk_m "logic clk_m"
Toggle rstn_m "logic rstn_m"

// --- arb_vrp [clk_rst] ---
CHECKSUM: "1092840857 1381784214"
MODULE: arb_vrp
Toggle clk "net clk"
Toggle rst_n "net rst_n"

// --- cmn_vrp_reg_fifo [clk_rst, dead_payload] ---
CHECKSUM: "3634631500 2334074456"
MODULE: cmn_vrp_reg_fifo
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"
Toggle in_pld.req.size "logic in_pld.req.size[2:0]"
Toggle in_pld.req.burst "logic in_pld.req.burst[1:0]"
Toggle out_pld.req.size "logic out_pld.req.size[2:0]"
Toggle out_pld.req.burst "logic out_pld.req.burst[1:0]"

// --- cmn_vrp_reg_fifo [clk_rst] ---
CHECKSUM: "3634631500 2431554784"
MODULE: cmn_vrp_reg_fifo
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- cmn_vrp_reg_fifo [clk_rst] ---
CHECKSUM: "3634631500 2816323313"
MODULE: cmn_vrp_reg_fifo
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- cmn_vrp_reg_fifo [clk_rst] ---
CHECKSUM: "3634631500 3753797670"
MODULE: cmn_vrp_reg_fifo
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- fcip_afifo_mst [afifo_ctrl, cdc_marker, clk_rst] ---
CHECKSUM: "2269949625 1451461867"
MODULE: fcip_afifo_mst
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"
Toggle full_zero "logic full_zero"
Toggle rptr_sync_inner_SIZE_ONLY "logic rptr_sync_inner_SIZE_ONLY[3:0]"
Toggle rptr_async_inner_SIZE_ONLY "logic rptr_async_inner_SIZE_ONLY[3:0]"
Toggle rptr_sync_nxt_size_only "logic rptr_sync_nxt_size_only[3:0]"
Toggle rptr_async_nxt_size_only "logic rptr_async_nxt_size_only[3:0]"
Toggle rptr_sync_marker_SIZE_ONLY "logic rptr_sync_marker_SIZE_ONLY[3:0]"
Toggle rptr_async_marker_SIZE_ONLY "logic rptr_async_marker_SIZE_ONLY[3:0]"
Toggle clk_marker "logic clk_marker"

// --- fcip_afifo_mst [afifo_ctrl, cdc_marker, clk_rst] ---
CHECKSUM: "2269949625 3171455134"
MODULE: fcip_afifo_mst
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"
Toggle full_zero "logic full_zero"
Toggle rptr_sync_inner_SIZE_ONLY "logic rptr_sync_inner_SIZE_ONLY[3:0]"
Toggle rptr_async_inner_SIZE_ONLY "logic rptr_async_inner_SIZE_ONLY[3:0]"
Toggle rptr_sync_nxt_size_only "logic rptr_sync_nxt_size_only[3:0]"
Toggle rptr_async_nxt_size_only "logic rptr_async_nxt_size_only[3:0]"
Toggle rptr_sync_marker_SIZE_ONLY "logic rptr_sync_marker_SIZE_ONLY[3:0]"
Toggle rptr_async_marker_SIZE_ONLY "logic rptr_async_marker_SIZE_ONLY[3:0]"
Toggle clk_marker "logic clk_marker"

// --- fcip_afifo_slv [afifo_ctrl, cdc_marker, clk_rst] ---
CHECKSUM: "2851294776 2451114303"
MODULE: fcip_afifo_slv
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"
Toggle full_zero "logic full_zero"
Toggle wptr_async_inner_SIZE_ONLY "logic wptr_async_inner_SIZE_ONLY[3:0]"
Toggle wptr_async_nxt_size_only "logic wptr_async_nxt_size_only[3:0]"
Toggle wptr_async_marker_SIZE_ONLY "logic wptr_async_marker_SIZE_ONLY[3:0]"
Toggle clk_marker "logic clk_marker"

// --- fcip_afifo_slv [afifo_ctrl, cdc_marker, clk_rst] ---
CHECKSUM: "2851294776 2602238882"
MODULE: fcip_afifo_slv
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"
Toggle full_zero "logic full_zero"
Toggle wptr_async_inner_SIZE_ONLY "logic wptr_async_inner_SIZE_ONLY[3:0]"
Toggle wptr_async_nxt_size_only "logic wptr_async_nxt_size_only[3:0]"
Toggle wptr_async_marker_SIZE_ONLY "logic wptr_async_marker_SIZE_ONLY[3:0]"
Toggle clk_marker "logic clk_marker"

// --- fcip_arb_vrp [clk_rst] ---
CHECKSUM: "3751832720 3046539970"
MODULE: fcip_arb_vrp
Toggle clk "net clk"
Toggle rst_n "net rst_n"

// --- fcip_data_pipe [clk_rst] ---
CHECKSUM: "3222869270 1361027238"
MODULE: fcip_data_pipe
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- fcip_data_pipe [clk_rst] ---
CHECKSUM: "3222869270 3388636040"
MODULE: fcip_data_pipe
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- fcip_fix_arb [clk_rst] ---
CHECKSUM: "4123955945 1486429461"
MODULE: fcip_fix_arb
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- fcip_fix_arb [clk_rst] ---
CHECKSUM: "4123955945 2689351422"
MODULE: fcip_fix_arb
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- fcip_grant_gen_rr [clk_rst] ---
CHECKSUM: "1187064235 1267900043"
MODULE: fcip_grant_gen_rr
Toggle clk "net clk"
Toggle rst_n "net rst_n"

// --- fcip_reg_slice [clk_rst, dead_payload] ---
CHECKSUM: "3424757416 1716814886"
MODULE: fcip_reg_slice
Toggle clk "net clk"
Toggle rst_n "net rst_n"
Toggle s_pld.req.size "logic s_pld.req.size[2:0]"
Toggle s_pld.req.burst "logic s_pld.req.burst[1:0]"
Toggle m_pld.req.size "logic m_pld.req.size[2:0]"
Toggle m_pld.req.burst "logic m_pld.req.burst[1:0]"

// --- fcip_reg_slice [clk_rst] ---
CHECKSUM: "3424757416 2953773372"
MODULE: fcip_reg_slice
Toggle clk "net clk"
Toggle rst_n "net rst_n"

// --- fcip_req_rsp_afifo_mst [clk_rst] ---
CHECKSUM: "1707270697 299175842"
MODULE: fcip_req_rsp_afifo_mst
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- fcip_req_rsp_afifo_slv [afifo_ctrl, clk_rst] ---
CHECKSUM: "3838745283 4050246514"
MODULE: fcip_req_rsp_afifo_slv
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"
Toggle rsp_full_zero "logic rsp_full_zero"
Toggle req_full_zero "logic req_full_zero"
Toggle master_full_zero "logic master_full_zero"
Toggle stall_buffer_vld "logic stall_buffer_vld"
Toggle stall_buffer_rdy "logic stall_buffer_rdy"
Toggle stall_buffer_pld "logic stall_buffer_pld[65:0]"

// --- lwring_id_remap [clk_rst] ---
CHECKSUM: "1880613491 805981886"
MODULE: lwring_id_remap
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"

// --- lwring_id_remap_entry [afifo_ctrl, clk_rst] ---
CHECKSUM: "1128467969 2242895059"
MODULE: lwring_id_remap_entry
Toggle clk "logic clk"
Toggle rst_n "logic rst_n"
Toggle entry_idle "logic entry_idle"

// --- pulse_async_bridge_receiver_qactive [clk_rst] ---
CHECKSUM: "522531746 101212094"
MODULE: pulse_async_bridge_receiver_qactive
Toggle clk_rx "logic clk_rx"
Toggle rstn_rx "logic rstn_rx"
Toggle clk_rx_qactive "logic clk_rx_qactive"

// --- pulse_async_bridge_transmitter_qactive [clk_rst] ---
CHECKSUM: "38726965 2327885008"
MODULE: pulse_async_bridge_transmitter_qactive
Toggle clk_tx "logic clk_tx"
Toggle rstn_tx "logic rstn_tx"
Toggle clk_tx_qactive "logic clk_tx_qactive"

// --- top_newtb [clk_rst, cti_debug] ---
CHECKSUM: "1217583109 3562779044"
MODULE: top_newtb
Toggle clk_src "logic clk_src"
Toggle clk_dst "logic clk_dst"
Toggle clk_dbg_timer "logic clk_dbg_timer"
Toggle rstn_src "logic rstn_src"
Toggle rstn_dst "logic rstn_dst"
Toggle rstn_dbg_timer "logic rstn_dbg_timer"
Toggle sys_cti_event_in "logic sys_cti_event_in[7:0]"
Toggle sys_cti_event_out "logic sys_cti_event_out[7:0]"
Toggle sys_cti_channel_in "logic sys_cti_channel_in[7:0]"
Toggle sys_cti_channel_out "logic sys_cti_channel_out[7:0]"
Toggle dbg_data_in "logic dbg_data_in[31:0]"
Toggle dbg_timestamp_out_0 "logic dbg_timestamp_out_0[63:0]"
Toggle dbg_timestamp_out_1 "logic dbg_timestamp_out_1[63:0]"
Toggle dbg_timestamp_out_2 "logic dbg_timestamp_out_2[63:0]"
Toggle dbg_data_out_0 "logic dbg_data_out_0[31:0]"
Toggle dbg_data_out_1 "logic dbg_data_out_1[31:0]"
Toggle dbg_data_out_2 "logic dbg_data_out_2[31:0]"
Toggle timing_bus1 "logic [2:0][31:0]timing_bus1"
Toggle timing_bus2 "logic [2:0][31:0]timing_bus2"
Toggle timing_bus3 "logic [2:0][31:0]timing_bus3"
Toggle dbg_en "logic [2:0][31:0]dbg_en"


// ============================================================================
// Round 13 TOGGLE waivers - additional structurally dead full signals
// ============================================================================

// --- Base_sts_iniu_axi_bundle [single_beat_len] ---
CHECKSUM: "2905349387 332981546"
MODULE: Base_sts_iniu_axi_bundle
Toggle m_ar_pld.arlen "logic m_ar_pld.arlen[7:0]"
Toggle m_aw_pld.awlen "logic m_aw_pld.awlen[7:0]"
Toggle s_arlen "logic s_arlen[7:0]"
Toggle s_awlen "logic s_awlen[7:0]"

// --- Base_sts_iniu_axi_iniu [rd_data_dead] ---
CHECKSUM: "1437876289 1179372252"
MODULE: Base_sts_iniu_axi_iniu
Toggle rd_req_pld.req.data "logic rd_req_pld.req.data[31:0]"
Toggle rd_req_pld.req.strb "logic rd_req_pld.req.strb[3:0]"

// --- Base_sts_iniu_rd_channel [rd_data_dead, rd_hold_dead, single_beat_len] ---
CHECKSUM: "4115085934 3089047861"
MODULE: Base_sts_iniu_rd_channel
Toggle ar_hold_pld.req.data "logic ar_hold_pld.req.data[31:0]"
Toggle ar_hold_pld.req.strb "logic ar_hold_pld.req.strb[3:0]"
Toggle ar_in_hold_pld.araddr "logic ar_in_hold_pld.araddr[31:0]"
Toggle ar_in_hold_pld.arid "logic ar_in_hold_pld.arid[7:0]"
Toggle ar_in_hold_pld.arlen "logic ar_in_hold_pld.arlen[7:0]"
Toggle ar_in_hold_pld.aruser "logic ar_in_hold_pld.aruser[7:0]"
Toggle ar_in_sel_pld.arlen "logic ar_in_sel_pld.arlen[7:0]"
Toggle fifo_in_ar_pld.req.data "logic fifo_in_ar_pld.req.data[31:0]"
Toggle fifo_in_ar_pld.req.strb "logic fifo_in_ar_pld.req.strb[3:0]"
Toggle fifo_out_ar_pld.req.data "logic fifo_out_ar_pld.req.data[31:0]"
Toggle fifo_out_ar_pld.req.strb "logic fifo_out_ar_pld.req.strb[3:0]"
Toggle out_req_pld.req.data "logic out_req_pld.req.data[31:0]"
Toggle out_req_pld.req.strb "logic out_req_pld.req.strb[3:0]"
Toggle upstrm_ar_pld.arlen "logic upstrm_ar_pld.arlen[7:0]"

// --- Base_sts_iniu_sys [single_beat_len] ---
CHECKSUM: "3047891155 2362043708"
MODULE: Base_sts_iniu_sys
Toggle bundle_ar_pld.arlen "logic bundle_ar_pld.arlen[7:0]"
Toggle bundle_aw_pld.awlen "logic bundle_aw_pld.awlen[7:0]"
Toggle s_arlen "logic s_arlen[7:0]"
Toggle s_awlen "logic s_awlen[7:0]"

// --- Base_sts_iniu_top [single_beat_len] ---
CHECKSUM: "172948656 3544573874"
MODULE: Base_sts_iniu_top
Toggle sts_iniu_s_arlen "logic sts_iniu_s_arlen[7:0]"
Toggle sts_iniu_s_awlen "logic sts_iniu_s_awlen[7:0]"

// --- Base_sts_iniu_wr_channel [single_beat_len] ---
CHECKSUM: "1611148050 3365547349"
MODULE: Base_sts_iniu_wr_channel
Toggle aw_hold_pld.awlen "logic aw_hold_pld.awlen[7:0]"
Toggle fifo_out_aw_pld.awlen "logic fifo_out_aw_pld.awlen[7:0]"
Toggle upstrm_aw_pld.awlen "logic upstrm_aw_pld.awlen[7:0]"

// --- Base_sts_noc_1iniu_3tniu_dut [decerr_data_zero] ---
CHECKSUM: "2477951387 3040048395"
MODULE: Base_sts_noc_1iniu_3tniu_dut
Toggle decerr_rsp_pld.rsp.data "logic decerr_rsp_pld.rsp.data[31:0]"

// --- Base_sts_noc_req_router_1to3 [decerr_data_zero] ---
CHECKSUM: "3111419975 3722419792"
MODULE: Base_sts_noc_req_router_1to3
Toggle decerr_rsp_pld.rsp.data "logic decerr_rsp_pld.rsp.data[31:0]"

// --- Base_sts_noc_rsp_mux_3to1 [decerr_data_zero] ---
CHECKSUM: "617881430 2706392466"
MODULE: Base_sts_noc_rsp_mux_3to1
Toggle decerr_rsp_pld.rsp.data "logic decerr_rsp_pld.rsp.data[31:0]"

// --- Base_sts_tniu_noc [noc_hdr_no_addr, noc_hdr_no_data, pipeline_bypass_tmp, tniu_fixed_cmn_id, tniu_fixed_src_id] ---
CHECKSUM: "911015456 3619931088"
MODULE: Base_sts_tniu_noc
Toggle out_req_pld_tmp "logic out_req_pld_tmp[118:0]"
Toggle req_afifo_pld.cmn.src_id "logic req_afifo_pld.cmn.src_id[7:0]"
Toggle req_afifo_pld.cmn.tgt_id "logic req_afifo_pld.cmn.tgt_id[7:0]"
Toggle req_afifo_pld.cmn.txn_id "logic req_afifo_pld.cmn.txn_id[7:0]"
Toggle req_afifo_pld.req.addr "logic req_afifo_pld.req.addr[31:0]"
Toggle req_afifo_pld.req.data "logic req_afifo_pld.req.data[31:0]"
Toggle req_tniu_sys_pld.cmn.src_id "logic req_tniu_sys_pld.cmn.src_id[7:0]"
Toggle req_tniu_sys_pld.cmn.tgt_id "logic req_tniu_sys_pld.cmn.tgt_id[7:0]"
Toggle req_tniu_sys_pld.cmn.txn_id "logic req_tniu_sys_pld.cmn.txn_id[7:0]"
Toggle req_tniu_sys_pld.req.addr "logic req_tniu_sys_pld.req.addr[31:0]"
Toggle req_tniu_sys_pld.req.data "logic req_tniu_sys_pld.req.data[31:0]"
Toggle rsp_afifo_pld.cmn.src_id "logic rsp_afifo_pld.cmn.src_id[7:0]"
Toggle rsp_afifo_pld.cmn.tgt_id "logic rsp_afifo_pld.cmn.tgt_id[7:0]"
Toggle rsp_afifo_pld.cmn.txn_id "logic rsp_afifo_pld.cmn.txn_id[7:0]"
Toggle rsp_afifo_pld.rsp.data "logic rsp_afifo_pld.rsp.data[31:0]"
Toggle rsp_tniu_sys_pld.cmn.src_id "logic rsp_tniu_sys_pld.cmn.src_id[7:0]"
Toggle rsp_tniu_sys_pld_tmp.cmn.src_id "logic rsp_tniu_sys_pld_tmp.cmn.src_id[7:0]"

// --- Base_sts_tniu_sys [cti_output_dead, tniu_fixed_src_id] ---
CHECKSUM: "417801667 849917854"
MODULE: Base_sts_tniu_sys
Toggle cti_channel_out "logic cti_channel_out[7:0]"
Toggle cti_channel_out_ack "logic cti_channel_out_ack[7:0]"
Toggle cti_channel_out_req "logic cti_channel_out_req[7:0]"
Toggle cti_event_out "logic cti_event_out[7:0]"
Toggle cti_event_out_ack "logic cti_event_out_ack[7:0]"
Toggle cti_event_out_req "logic cti_event_out_req[7:0]"
Toggle rsp_apb_tniu_pld.cmn.src_id "logic rsp_apb_tniu_pld.cmn.src_id[7:0]"
Toggle rsp_async_fifo_pld_tmp.cmn.src_id "logic rsp_async_fifo_pld_tmp.cmn.src_id[7:0]"

// --- Base_sts_tniu_top [cti_output_dead] ---
CHECKSUM: "731806648 2237614106"
MODULE: Base_sts_tniu_top
Toggle tmp_channel_in_ack "logic tmp_channel_in_ack[7:0]"
Toggle tmp_channel_in_req "logic tmp_channel_in_req[7:0]"
Toggle tmp_event_in_ack "logic tmp_event_in_ack[7:0]"
Toggle tmp_event_in_req "logic tmp_event_in_req[7:0]"

// --- fcip_fix_arb [fix_arb_slave_dead] ---
CHECKSUM: "4123955945 1486429461"
MODULE: fcip_fix_arb
Toggle s_pld "logic s_pld[120:0]"

// --- top_newtb [single_beat_len] ---
CHECKSUM: "1217583109 3562779044"
MODULE: top_newtb
Toggle s_arlen "logic s_arlen[7:0]"
Toggle s_awlen "logic s_awlen[7:0]"
