// R14 third wave: rsp-path dead bits (resp[0], opcode[1], rsp.last, rsp_last)

CHECKSUM: "3424757416 2953773372"
MODULE: fcip_reg_slice ( parameter RS_TYPE=1 )
Toggle s_pld [0] "logic s_pld[65:0]"
Toggle s_pld [1] "logic s_pld[65:0]"
Toggle s_pld [34] "logic s_pld[65:0]"
Toggle s_pld [40] "logic s_pld[65:0]"
Toggle m_pld [0] "logic m_pld[65:0]"
Toggle m_pld [1] "logic m_pld[65:0]"
Toggle m_pld [34] "logic m_pld[65:0]"
Toggle m_pld [40] "logic m_pld[65:0]"
Toggle rs_forward.pld_r [0] "logic rs_forward.pld_r[65:0]"
Toggle rs_forward.pld_r [1] "logic rs_forward.pld_r[65:0]"
Toggle rs_forward.pld_r [34] "logic rs_forward.pld_r[65:0]"
Toggle rs_forward.pld_r [40] "logic rs_forward.pld_r[65:0]"

CHECKSUM: "3047891155 2362043708"
MODULE: Base_sts_iniu_sys
Toggle rsp_pld_afifo [0] "logic rsp_pld_afifo[64:0]"
Toggle rsp_pld_afifo [33] "logic rsp_pld_afifo[64:0]"
Toggle rsp_pld_afifo [39] "logic rsp_pld_afifo[64:0]"
Toggle rsp_last_afifo "logic rsp_last_afifo"
Toggle rsp_last_temp "logic rsp_last_temp"
Toggle s_bresp [0] "logic s_bresp[1:0]"
Toggle s_rresp [0] "logic s_rresp[1:0]"
Toggle bundle_b_pld.bresp [0] "logic bundle_b_pld.bresp[1:0]"
Toggle bundle_r_pld.rresp [0] "logic bundle_r_pld.rresp[1:0]"

CHECKSUM: "911015456 3619931088"
MODULE: Base_sts_tniu_noc
Toggle rsp_apb_tniu_pld.rsp.resp [0] "logic rsp_apb_tniu_pld.rsp.resp[1:0]"
Toggle rsp_tniu_sys_pld.rsp.resp [0] "logic rsp_tniu_sys_pld.rsp.resp[1:0]"
Toggle req_tniu_sys_pld.cmn.opcode [1] "logic req_tniu_sys_pld.cmn.opcode[1:0]"
Toggle out_req_last_tmp "logic out_req_last_tmp"

CHECKSUM: "731806648 2237614106"
MODULE: Base_sts_tniu_top
Toggle out_rsp_pld.rsp.resp [0] "logic out_rsp_pld.rsp.resp[1:0]"

CHECKSUM: "1228083994 896648132"
MODULE: Base_sts_tniu_apb
Toggle out_rsp_pld.rsp.resp [0] "logic out_rsp_pld.rsp.resp[1:0]"
Toggle rsp_pld_r.rsp.resp [0] "logic rsp_pld_r.rsp.resp[1:0]"

CHECKSUM: "4115085934 3089047861"
MODULE: Base_sts_iniu_rd_channel
Toggle out_req_pld.cmn.opcode [1] "logic out_req_pld.cmn.opcode[1:0]"
Toggle fifo_in_ar_pld.cmn.opcode [1] "logic fifo_in_ar_pld.cmn.opcode[1:0]"
Toggle fifo_out_ar_pld.cmn.opcode [1] "logic fifo_out_ar_pld.cmn.opcode[1:0]"
Toggle ar_hold_pld.cmn.opcode [1] "logic ar_hold_pld.cmn.opcode[1:0]"
Toggle upstrm_r_pld.rresp [0] "logic upstrm_r_pld.rresp[1:0]"
Toggle fifo_in_rsp_pld.rresp [0] "logic fifo_in_rsp_pld.rresp[1:0]"

CHECKSUM: "1611148050 3365547349"
MODULE: Base_sts_iniu_wr_channel
Toggle out_req_pld.cmn.opcode [1] "logic out_req_pld.cmn.opcode[1:0]"
Toggle merged_req_pld.cmn.opcode [1] "logic merged_req_pld.cmn.opcode[1:0]"
Toggle rs_out_pld.cmn.opcode [1] "logic rs_out_pld.cmn.opcode[1:0]"
Toggle upstrm_b_pld.bresp [0] "logic upstrm_b_pld.bresp[1:0]"
Toggle fifo_in_rsp_pld.bresp [0] "logic fifo_in_rsp_pld.bresp[1:0]"

CHECKSUM: "1437876289 1179372252"
MODULE: Base_sts_iniu_axi_iniu
Toggle upstrm_b_pld.bresp [0] "logic upstrm_b_pld.bresp[1:0]"
Toggle upstrm_r_pld.rresp [0] "logic upstrm_r_pld.rresp[1:0]"
Toggle wr_req_pld.cmn.opcode [1] "logic wr_req_pld.cmn.opcode[1:0]"
Toggle rd_req_pld.cmn.opcode [1] "logic rd_req_pld.cmn.opcode[1:0]"

CHECKSUM: "2477951387 3040048395"
MODULE: Base_sts_noc_1iniu_3tniu_dut
Toggle tniu0_rsp_pld.rsp.resp [0] "logic tniu0_rsp_pld.rsp.resp[1:0]"
Toggle tniu1_rsp_pld.rsp.resp [0] "logic tniu1_rsp_pld.rsp.resp[1:0]"
Toggle tniu2_rsp_pld.rsp.resp [0] "logic tniu2_rsp_pld.rsp.resp[1:0]"
Toggle decerr_rsp_pld.rsp.resp [1:0] "logic decerr_rsp_pld.rsp.resp[1:0]"

CHECKSUM: "417801667 849917854"
MODULE: Base_sts_tniu_sys
Toggle rsp_apb_tniu_pld.rsp.resp [0] "logic rsp_apb_tniu_pld.rsp.resp[1:0]"
Toggle rsp_async_fifo_pld_tmp.rsp.resp [0] "logic rsp_async_fifo_pld_tmp.rsp.resp[1:0]"
Toggle rsp_async_fifo_last "logic rsp_async_fifo_last"

CHECKSUM: "3838745283 4050246514"
MODULE: fcip_req_rsp_afifo_slv ( parameter SYNC_STAGE=2,FIFO_DEPTH=4,AUTO_CLEAR_EN=1,REQ_WIDTH=119,RSP_WIDTH=65,VT_TYPE=1 )
Toggle rsp_m_pld [0] "logic rsp_m_pld[64:0]"
Toggle rsp_m_pld [33] "logic rsp_m_pld[64:0]"
Toggle rsp_m_pld [39] "logic rsp_m_pld[64:0]"
Toggle rsp_m_last "logic rsp_m_last"

CHECKSUM: "1707270697 299175842"
MODULE: fcip_req_rsp_afifo_mst ( parameter SYNC_STAGE=2,FIFO_DEPTH=4,AUTO_CLEAR_EN=1,REQ_WIDTH=119,RSP_WIDTH=65,VT_TYPE=1 )
Toggle rsp_ext_m_last "logic rsp_ext_m_last"
Toggle req_ext_s_last "logic req_ext_s_last"

CHECKSUM: "617881430 2706392466"
MODULE: Base_sts_noc_rsp_mux_3to1
Toggle in0_rsp_pld.rsp.resp [0] "logic in0_rsp_pld.rsp.resp[1:0]"
Toggle in1_rsp_pld.rsp.resp [0] "logic in1_rsp_pld.rsp.resp[1:0]"
Toggle in2_rsp_pld.rsp.resp [0] "logic in2_rsp_pld.rsp.resp[1:0]"
Toggle decerr_rsp_pld.rsp.resp [0] "logic decerr_rsp_pld.rsp.resp[1:0]"
Toggle out_rsp_pld.rsp.resp [0] "logic out_rsp_pld.rsp.resp[1:0]"

