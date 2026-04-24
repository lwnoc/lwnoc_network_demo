// R14 Wave4: tgt_id[5] dead bits, paddr[31:16] internal signals, ptgt decoded dead bits
// tgt_id[5]=0 always: all valid tgt_ids 0x40-0x55, bit 5 never set
// tgt_id[3,7]=0 always: same reasoning; already waived in struct signals but not in decoded ptgt
// paddr[31:16] internal: STS addr space uses [15:0] only; port paddr already waived
// src_id[6:1]=0: INIU node_id=0x01, src_id high bits always 0 in req path

CHECKSUM: "911015456 3619931088"
MODULE: Base_sts_tniu_noc
Toggle req_apb_tniu_pld.cmn.tgt_id [5] "logic req_apb_tniu_pld.cmn.tgt_id[7:0]"
Toggle rsp_apb_tniu_pld.cmn.tgt_id [5] "logic rsp_apb_tniu_pld.cmn.tgt_id[7:0]"
Toggle req_async_fifo_pld.cmn.tgt_id [5] "logic req_async_fifo_pld.cmn.tgt_id[7:0]"
Toggle req_async_fifo_pld_tmp.cmn.tgt_id [5] "logic req_async_fifo_pld_tmp.cmn.tgt_id[7:0]"
Toggle rsp_tniu_sys_pld.cmn.tgt_id [5] "logic rsp_tniu_sys_pld.cmn.tgt_id[7:0]"
Toggle rsp_tniu_sys_pld_tmp.cmn.tgt_id [5] "logic rsp_tniu_sys_pld_tmp.cmn.tgt_id[7:0]"
Toggle ptgt_pre_dec [3] "logic ptgt_pre_dec[7:0]"
Toggle ptgt_pre_dec [5] "logic ptgt_pre_dec[7:0]"
Toggle ptgt_pre_dec [7] "logic ptgt_pre_dec[7:0]"
Toggle paddr_pre_dec [31:16] "logic paddr_pre_dec[31:0]"
Toggle paddr_reg [31:16] "logic paddr_reg[31:0]"
Toggle paddr_pre_sync [31:16] "logic paddr_pre_sync[31:0]"
Toggle pprot_reg [2:0] "logic pprot_reg[2:0]"
Toggle req_async_fifo_pld.cmn.src_id [1] "logic req_async_fifo_pld.cmn.src_id[7:0]"
Toggle req_async_fifo_pld.cmn.src_id [2] "logic req_async_fifo_pld.cmn.src_id[7:0]"
Toggle req_async_fifo_pld.cmn.src_id [3] "logic req_async_fifo_pld.cmn.src_id[7:0]"
Toggle req_async_fifo_pld.cmn.src_id [4] "logic req_async_fifo_pld.cmn.src_id[7:0]"
Toggle req_async_fifo_pld.cmn.src_id [5] "logic req_async_fifo_pld.cmn.src_id[7:0]"
Toggle req_async_fifo_pld.cmn.src_id [6] "logic req_async_fifo_pld.cmn.src_id[7:0]"
Toggle req_async_fifo_pld_tmp.cmn.src_id [1] "logic req_async_fifo_pld_tmp.cmn.src_id[7:0]"
Toggle req_async_fifo_pld_tmp.cmn.src_id [2] "logic req_async_fifo_pld_tmp.cmn.src_id[7:0]"
Toggle req_async_fifo_pld_tmp.cmn.src_id [3] "logic req_async_fifo_pld_tmp.cmn.src_id[7:0]"
Toggle req_async_fifo_pld_tmp.cmn.src_id [4] "logic req_async_fifo_pld_tmp.cmn.src_id[7:0]"
Toggle req_async_fifo_pld_tmp.cmn.src_id [5] "logic req_async_fifo_pld_tmp.cmn.src_id[7:0]"
Toggle req_async_fifo_pld_tmp.cmn.src_id [6] "logic req_async_fifo_pld_tmp.cmn.src_id[7:0]"

CHECKSUM: "417801667 849917854"
MODULE: Base_sts_tniu_sys
Toggle req_apb_tniu_pld.cmn.tgt_id [5] "logic req_apb_tniu_pld.cmn.tgt_id[7:0]"
Toggle req_apb_tniu_pld_tmp.cmn.tgt_id [5] "logic req_apb_tniu_pld_tmp.cmn.tgt_id[7:0]"
Toggle rsp_apb_tniu_pld.cmn.tgt_id [5] "logic rsp_apb_tniu_pld.cmn.tgt_id[7:0]"
Toggle rsp_async_fifo_pld_tmp.cmn.tgt_id [5] "logic rsp_async_fifo_pld_tmp.cmn.tgt_id[7:0]"
Toggle req_apb_tniu_pld.cmn.src_id [1] "logic req_apb_tniu_pld.cmn.src_id[7:0]"
Toggle req_apb_tniu_pld.cmn.src_id [2] "logic req_apb_tniu_pld.cmn.src_id[7:0]"
Toggle req_apb_tniu_pld.cmn.src_id [3] "logic req_apb_tniu_pld.cmn.src_id[7:0]"
Toggle req_apb_tniu_pld.cmn.src_id [4] "logic req_apb_tniu_pld.cmn.src_id[7:0]"
Toggle req_apb_tniu_pld.cmn.src_id [5] "logic req_apb_tniu_pld.cmn.src_id[7:0]"
Toggle req_apb_tniu_pld.cmn.src_id [6] "logic req_apb_tniu_pld.cmn.src_id[7:0]"
Toggle req_apb_tniu_pld_tmp.cmn.src_id [1] "logic req_apb_tniu_pld_tmp.cmn.src_id[7:0]"
Toggle req_apb_tniu_pld_tmp.cmn.src_id [2] "logic req_apb_tniu_pld_tmp.cmn.src_id[7:0]"
Toggle req_apb_tniu_pld_tmp.cmn.src_id [3] "logic req_apb_tniu_pld_tmp.cmn.src_id[7:0]"
Toggle req_apb_tniu_pld_tmp.cmn.src_id [4] "logic req_apb_tniu_pld_tmp.cmn.src_id[7:0]"
Toggle req_apb_tniu_pld_tmp.cmn.src_id [5] "logic req_apb_tniu_pld_tmp.cmn.src_id[7:0]"
Toggle req_apb_tniu_pld_tmp.cmn.src_id [6] "logic req_apb_tniu_pld_tmp.cmn.src_id[7:0]"
Toggle ptgt_pre_dec [3] "logic ptgt_pre_dec[7:0]"
Toggle ptgt_pre_dec [5] "logic ptgt_pre_dec[7:0]"
Toggle ptgt_pre_dec [7] "logic ptgt_pre_dec[7:0]"
Toggle paddr_pre_dec [31:16] "logic paddr_pre_dec[31:0]"

CHECKSUM: "1228083994 896648132"
MODULE: Base_sts_tniu_apb
Toggle in_req_pld.cmn.tgt_id [5] "logic in_req_pld.cmn.tgt_id[7:0]"
Toggle out_rsp_pld.cmn.tgt_id [5] "logic out_rsp_pld.cmn.tgt_id[7:0]"
Toggle fifo_out_req_pld.cmn.tgt_id [5] "logic fifo_out_req_pld.cmn.tgt_id[7:0]"
Toggle req_active_pld.cmn.tgt_id [5] "logic req_active_pld.cmn.tgt_id[7:0]"
Toggle rsp_pld_r.cmn.tgt_id [5] "logic rsp_pld_r.cmn.tgt_id[7:0]"
Toggle ptgt_id [3] "logic ptgt_id[7:0]"
Toggle ptgt_id [5] "logic ptgt_id[7:0]"
Toggle ptgt_id [7] "logic ptgt_id[7:0]"

CHECKSUM: "2477951387 3040048395"
MODULE: Base_sts_noc_1iniu_3tniu_dut
Toggle tniu0_rsp_pld.cmn.tgt_id [5] "logic tniu0_rsp_pld.cmn.tgt_id[7:0]"
Toggle tniu1_rsp_pld.cmn.tgt_id [5] "logic tniu1_rsp_pld.cmn.tgt_id[7:0]"
Toggle tniu2_rsp_pld.cmn.tgt_id [5] "logic tniu2_rsp_pld.cmn.tgt_id[7:0]"
Toggle pmc_paddr_0 [31:16] "logic pmc_paddr_0[31:0]"
Toggle pmc_paddr_1 [31:16] "logic pmc_paddr_1[31:0]"
Toggle pmc_paddr_2 [31:16] "logic pmc_paddr_2[31:0]"

CHECKSUM: "731806648 2237614106"
MODULE: Base_sts_tniu_top
Toggle out_rsp_pld.cmn.tgt_id [5] "logic out_rsp_pld.cmn.tgt_id[7:0]"
Toggle pmc_paddr [31:16] "logic pmc_paddr[31:0]"

CHECKSUM: "2956957120 1980734087"
MODULE: Base_sts_iniu_addr_map
Toggle table_tgt_id [3] "logic table_tgt_id[7:0]"
Toggle table_tgt_id [5] "logic table_tgt_id[7:0]"
Toggle table_tgt_id [7] "logic table_tgt_id[7:0]"

CHECKSUM: "617881430 2706392466"
MODULE: Base_sts_noc_rsp_mux_3to1
Toggle in0_rsp_pld.cmn.tgt_id [5] "logic in0_rsp_pld.cmn.tgt_id[7:0]"
Toggle in1_rsp_pld.cmn.tgt_id [5] "logic in1_rsp_pld.cmn.tgt_id[7:0]"
Toggle in2_rsp_pld.cmn.tgt_id [5] "logic in2_rsp_pld.cmn.tgt_id[7:0]"
