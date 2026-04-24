#!/usr/bin/env python3
"""Compute toggle waiver amounts for wrapper modules that don't appear in modinfo.txt.

Analyzes RTL signal widths and DUT tieoffs to identify structurally dead toggle bits.
"""

# Width constants from lwnoc_sts_pack.sv
SRC_ID_WIDTH = 8
TXN_ID_WIDTH = 8
TGT_ID_WIDTH = 8
AXI_ADDR_WIDTH = 32
AXI_DATA_WIDTH = 32
AXI_STRB_WIDTH = 4
AXI_USER_WIDTH = 8
AXI_SIZE_WIDTH = 2
CTI_EVENT_WIDTH = 8
CTI_CHANNEL_WIDTH = 8

# Derived struct sizes
cmn_bits = SRC_ID_WIDTH + TXN_ID_WIDTH + TGT_ID_WIDTH + 2 + 4  # 30
req_ext = AXI_ADDR_WIDTH + 2 + 3 + 6 + 1 + AXI_USER_WIDTH + AXI_DATA_WIDTH + AXI_STRB_WIDTH + 1  # 89
rsp_ext = 2 + AXI_DATA_WIDTH + 1  # 35
REQ_BITS = cmn_bits + req_ext  # 119
RSP_BITS = cmn_bits + rsp_ext  # 65

DBG_TS_W = 64
DBG_DATA_W = 32
APB_ADDR_W = 32
AFIFO_DEPTH = 4

print(f"Struct sizes: cmn={cmn_bits} req={REQ_BITS} rsp={RSP_BITS}")
print()

# ============================================================
# sts_tniu_top (u_tniu0) analysis
# ============================================================
print("=" * 60)
print("sts_tniu_top (u_tniu0)")
print("=" * 60)

# DUT-level tieoffs (from TB/harness):
# write_stall = 1'b0, write_clear = 1'b0
# noc_cti_event_in = '0, noc_cti_channel_in = '0
# sys_cti_event_in = '0, sys_cti_channel_in = '0
# (All CTI inputs tied to 0 on both NOC and SYS sides)

# Dead ports at sts_tniu_top:
dead_top = {}
dead_top["write_stall"] = 1
dead_top["write_clear"] = 1
# 4 CTI input ports (all tied 0)
dead_top["noc_cti_event_in[7:0]"] = CTI_EVENT_WIDTH
dead_top["noc_cti_channel_in[7:0]"] = CTI_EVENT_WIDTH
dead_top["sys_cti_event_in[7:0]"] = CTI_EVENT_WIDTH
dead_top["sys_cti_channel_in[7:0]"] = CTI_EVENT_WIDTH
# 4 CTI output ports (driven by dead cti_handle children - inputs are all 0)
dead_top["noc_cti_event_out[7:0]"] = CTI_EVENT_WIDTH
dead_top["noc_cti_channel_out[7:0]"] = CTI_EVENT_WIDTH
dead_top["sys_cti_event_out[7:0]"] = CTI_EVENT_WIDTH
dead_top["sys_cti_channel_out[7:0]"] = CTI_EVENT_WIDTH

# Dead internal wires (CTI cross-domain handshake - all dead since both sides' inputs are 0)
dead_top["tmp_event_in_req[7:0]"] = CTI_EVENT_WIDTH
dead_top["tmp_event_in_ack[7:0]"] = CTI_EVENT_WIDTH
dead_top["tmp_event_out_req[7:0]"] = CTI_EVENT_WIDTH
dead_top["tmp_event_out_ack[7:0]"] = CTI_EVENT_WIDTH
dead_top["tmp_channel_in_req[7:0]"] = CTI_CHANNEL_WIDTH
dead_top["tmp_channel_in_ack[7:0]"] = CTI_CHANNEL_WIDTH
dead_top["tmp_channel_out_req[7:0]"] = CTI_CHANNEL_WIDTH
dead_top["tmp_channel_out_ack[7:0]"] = CTI_CHANNEL_WIDTH

dead_top_unique = sum(dead_top.values())
dead_top_toggle = dead_top_unique * 2  # 0->1 and 1->0

print(f"Dead signals:")
for name, w in dead_top.items():
    print(f"  {name}: {w} bits")
print(f"Total dead unique bits: {dead_top_unique}")
print(f"Total dead toggle bits: {dead_top_toggle}")
print(f"Observed uncov: 889")
print(f"After waiver: {889 - dead_top_toggle}")
print()

# ============================================================
# sts_tniu_sys (u_sts_tniu_sys) analysis
# ============================================================
print("=" * 60)
print("sts_tniu_sys (u_sts_tniu_sys)")
print("=" * 60)

# Dead CTI ports at sts_tniu_sys level:
# 12 CTI ports: 6 for event, 6 for channel
# event: cti_event_in[7:0], cti_event_in_req[7:0], cti_event_in_ack[7:0],
#         cti_event_out[7:0], cti_event_out_req[7:0], cti_event_out_ack[7:0]
# channel: cti_channel_in[7:0] ... same 6
# All dead because CTI inputs at both top-level sides are tied 0
dead_sys = {}
for prefix in ["cti_event", "cti_channel"]:
    for suffix in ["in", "in_req", "in_ack", "out", "out_req", "out_ack"]:
        dead_sys[f"{prefix}_{suffix}[7:0]"] = CTI_EVENT_WIDTH

dead_sys_unique = sum(dead_sys.values())
dead_sys_toggle = dead_sys_unique * 2

print(f"Dead signals:")
for name, w in dead_sys.items():
    print(f"  {name}: {w} bits")
print(f"Total dead unique bits: {dead_sys_unique}")
print(f"Total dead toggle bits: {dead_sys_toggle}")
print(f"Observed uncov: 992")
print(f"After waiver: {992 - dead_sys_toggle}")
print()

# ============================================================
# sts_tniu_noc (u_sts_tniu_noc) analysis - already has 2215 waiver
# ============================================================
print("=" * 60)
print("sts_tniu_noc (u_sts_tniu_noc) - already fully waived")
print("=" * 60)
print("Current waiver: 2215 toggle bits -> leaves 2641/2641 = 100%")
print()

# ============================================================
# Summary of waiver rules to add
# ============================================================
print("=" * 60)
print("WAIVER RULES TO ADD")
print("=" * 60)
print(f"waive_toggle_tniu_top: regex=u_tniu[0-2]$, toggle.total={dead_top_toggle}")
print(f"waive_toggle_tniu_sys: regex=u_tniu[0-2]\\.u_sts_tniu_sys$, toggle.total={dead_sys_toggle}")
print()

# ============================================================
# Verify against actual data
# ============================================================
print("=" * 60)
print("VERIFICATION")
print("=" * 60)
# From extractor: u_tniu0 raw 1665/2554, uncov=889
# After CTI waiver (260): 889-260=629 remaining -> 1665/(2554-260)=1665/2294
print(f"u_tniu0: raw=1665/2554, with -{dead_top_toggle} waiver -> 1665/{2554-dead_top_toggle} = {1665/(2554-dead_top_toggle)*100:.1f}%")
# From extractor: u_sts_tniu_sys raw 1642/2634, uncov=992
print(f"u_sts_tniu_sys: raw=1642/2634, with -{dead_sys_toggle} waiver -> 1642/{2634-dead_sys_toggle} = {1642/(2634-dead_sys_toggle)*100:.1f}%")
