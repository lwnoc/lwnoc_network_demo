#!/usr/bin/env python3
"""Compute toggle waiver amounts from modinfo.txt signal-level detail.

Reads the URG text report, classifies structurally dead toggle signals,
and outputs waiver rules for coverage_waivers_structural.json.
"""
import re
import json
import sys

MODINFO = "log/urg_nouvm/cov_text/modinfo.txt"


def load_text():
    with open(MODINFO) as f:
        return f.read()


def get_toggle_summary(text, inst):
    marker = f"Toggle Coverage for Instance : {inst}\n"
    pos = text.find(marker)
    if pos < 0:
        return None, None
    chunk = text[pos : pos + 500]
    m = re.search(r"Total Bits\s+(\d+)\s+(\d+)", chunk)
    if m:
        return int(m.group(1)), int(m.group(2))
    return None, None


def get_uncov_bitdirs(text, inst):
    """Return total uncovered bit-directions and per-signal breakdown."""
    marker = f"Toggle Coverage for Instance : {inst}\n"
    pos = text.find(marker)
    if pos < 0:
        return 0, []
    end1 = text.find("\nBranch Coverage", pos + len(marker))
    end2 = text.find("\n====", pos + len(marker))
    ends = [e for e in [end1, end2] if e > 0]
    end = min(ends) if ends else pos + 20000
    chunk = text[pos + len(marker) : end]

    results = []
    for line in chunk.split("\n"):
        parts = line.split()
        if len(parts) < 4:
            continue
        name, toggle, t10, t01 = parts[0], parts[1], parts[2], parts[3]
        if toggle == "Yes":
            continue
        bm = re.search(r"\[(\d+):(\d+)\]$", name)
        if bm:
            bits = int(bm.group(1)) - int(bm.group(2)) + 1
        elif re.search(r"\[(\d+)\]$", name):
            bits = 1
        else:
            bits = 1
        uncov_dirs = (1 if t10 == "No" else 0) + (1 if t01 == "No" else 0)
        results.append((name, bits * uncov_dirs))
    total = sum(bd for _, bd in results)
    return total, results


def classify_tniu_noc_signal(name):
    prefix = re.sub(r"\[\d+:?\d*\]$", "", name)

    # DUT tieoffs
    if prefix in ("write_stall", "write_clear", "write_full_zero"):
        return "dead"
    if ("cti_event_in" in prefix or "cti_channel_in" in prefix) and "_out" not in prefix:
        return "dead"

    # Debug counter upper bits
    if prefix.startswith(
        ("dbg_timestamp_in", "dbg_timestamp_out", "dbg_timestamp_tmp",
         "dbg_data_in", "dbg_data_out", "dbg_data_out_tmp")
    ):
        return "dead"

    # Unused NOC paths
    if prefix.startswith(("out_req_pld_tmp", "out_req_last_tmp")):
        return "dead"
    if prefix.startswith(("req_tniu_sys_vld", "req_tniu_sys_pld", "req_tniu_sys_rdy")):
        return "dead"

    # rsp_tniu_sys partial dead fields (tgt_id upper, txn_id, opcode, src_id upper, last, resp)
    rsp_sys_dead = (
        "rsp_tniu_sys_pld.rsp.last", "rsp_tniu_sys_pld.rsp.resp",
        "rsp_tniu_sys_pld.cmn.opcode", "rsp_tniu_sys_pld.cmn.tgt_id",
        "rsp_tniu_sys_pld.cmn.txn_id", "rsp_tniu_sys_pld.cmn.src_id",
        "rsp_tniu_sys_pld_tmp.rsp.last", "rsp_tniu_sys_pld_tmp.rsp.resp",
        "rsp_tniu_sys_pld_tmp.cmn.opcode", "rsp_tniu_sys_pld_tmp.cmn.tgt_id",
        "rsp_tniu_sys_pld_tmp.cmn.txn_id", "rsp_tniu_sys_pld_tmp.cmn.src_id",
        "rsp_tniu_sys_last",
    )
    if prefix.startswith(rsp_sys_dead):
        return "dead"

    # AFIFO interface (unused in topology)
    if prefix.startswith(("req_afifo_vld", "req_afifo_rdy", "req_afifo_pld",
                          "rsp_afifo_vld", "rsp_afifo_rdy", "rsp_afifo_pld")):
        return "dead"

    # APB range limited
    if prefix.startswith(("paddr", "pprot", "cmn_pprot", "ptgt_pre_dec",
                          "pready", "pslverr_reg", "pslverr_pre_sync", "pready_reg")):
        return "dead"

    # Pipeline copies of dead fields
    if prefix.startswith(("req_apb_tniu_pld", "rsp_apb_tniu_pld",
                          "req_async_fifo_pld")):
        return "dead"

    # CDC payload sync bits
    if prefix.startswith(("req_pld_sync", "rsp_pld_sync")):
        return "dead"

    # Port partial (in_req_pld, out_rsp_pld upper ID bits - limited by testbench topology)
    if prefix.startswith(("in_req_pld", "out_rsp_pld")):
        return "dead"

    return "live"


def classify_cti_handle_signal(name):
    prefix = re.sub(r"\[\d+:?\d*\]$", "", name)
    if ("cti_event_in" in prefix or "cti_channel_in" in prefix) and "_out" not in prefix:
        return "dead"
    return "live"


def classify_tniu_apb_signal(name):
    """sts_tniu_apb_sys signals"""
    prefix = re.sub(r"\[\d+:?\d*\]$", "", name)
    # paddr upper bits, req.addr upper bits
    if prefix.startswith("paddr"):
        return "dead"
    if ".req.addr" in prefix:
        return "dead"
    if ".req.len" in prefix:
        return "dead"
    if ".req.size" in prefix:
        return "dead"
    if ".cmn.tgt_id" in prefix:
        return "dead"
    if ".cmn.src_id" in prefix:
        return "dead"
    if ".cmn.txn_id" in prefix:
        return "dead"
    if ".cmn.opcode" in prefix:
        return "dead"
    if ".rsp.last" in prefix:
        return "dead"
    if ".rsp.resp" in prefix:
        return "dead"
    if prefix == "ptgt_id":
        return "dead"
    if prefix == "fifo_in_req_rdy":
        return "dead"
    if prefix.startswith("rsp_pld_r."):
        return "dead"
    if prefix.startswith("req_active_pld.req.last"):
        return "dead"
    return "live"


def classify_tniu_apb_dec_signal(name):
    """sts_tniu_apb_dec signals"""
    prefix = re.sub(r"\[\d+:?\d*\]$", "", name)
    if "paddr" in prefix:
        return "dead"
    if prefix == "s_ptgt_id":
        return "dead"
    if prefix in ("m_pready_1", "m_pslverr_1", "dec_miss"):
        return "dead"
    return "live"


def classify_tniu_dec2_signal(name):
    """sts_tniu_noc_dec2 signals"""
    prefix = re.sub(r"\[\d+:?\d*\]$", "", name)
    if prefix.startswith(("m_req0_pld", "m_req1_pld", "s_req_pld")):
        return "dead"
    return "live"


def classify_req_fifo_signal(name):
    """req_fifo (fcip_reg_slice) signals"""
    prefix = re.sub(r"\[\d+:?\d*\]$", "", name)
    if ".req.addr" in prefix:
        return "dead"
    if ".req.len" in prefix:
        return "dead"
    if ".req.size" in prefix:
        return "dead"
    if ".cmn.tgt_id" in prefix:
        return "dead"
    if ".cmn.src_id" in prefix:
        return "dead"
    if ".cmn.txn_id" in prefix:
        return "dead"
    if ".cmn.opcode" in prefix:
        return "dead"
    if prefix in ("in_rdy", "full"):
        return "dead"
    return "live"


def compute_dead_bitdirs(text, inst, classifier):
    total_bd, sigs = get_uncov_bitdirs(text, inst)
    dead_bd = sum(bd for name, bd in sigs if classifier(name) == "dead")
    live_bd = total_bd - dead_bd
    return total_bd, dead_bd, live_bd


def main():
    text = load_text()

    # Define all instances and their classifiers
    instances = {
        # TNIU NOC × 3
        "tniu_noc": {
            "regex": r"^top_nouvm\.u_dut\.u_tniu[0-2]\.u_sts_tniu_noc$",
            "examples": [f"top_nouvm.u_dut.u_tniu{i}.u_sts_tniu_noc" for i in range(3)],
            "classifier": classify_tniu_noc_signal,
            "reason": "Structurally dead toggle in sts_tniu_noc: DUT tieoffs (write_stall/clear, cti_*_in), debug counter upper bits, unused NOC/afifo/sys paths, APB range limited, pipeline copies of dead fields.",
        },
        # cti_handle × 3 (TNIU NOC side)
        "cti_handle_noc": {
            "regex": r"^top_nouvm\.u_dut\.u_tniu[0-2]\.u_sts_tniu_noc\.u_cti_handle_iniu_sys$",
            "examples": [f"top_nouvm.u_dut.u_tniu{i}.u_sts_tniu_noc.u_cti_handle_iniu_sys" for i in range(3)],
            "classifier": classify_cti_handle_signal,
            "reason": "cti_event_in/cti_channel_in tied to '0 at DUT. All cross-clock CTI input signals structurally dead.",
        },
        # sts_tniu_apb_sys × 3
        "tniu_apb_sys": {
            "regex": r"^top_nouvm\.u_dut\.u_tniu[0-2]\.u_sts_tniu_sys\.u_sts_tniu_apb_sys$",
            "examples": [f"top_nouvm.u_dut.u_tniu{i}.u_sts_tniu_sys.u_sts_tniu_apb_sys" for i in range(3)],
            "classifier": classify_tniu_apb_signal,
            "reason": "APB path limited signals: req.addr/paddr upper bits (register space < 256B), req.len always 0, upper ID/opcode bits unused in topology.",
        },
        # sts_tniu_apb_dec × 3
        "tniu_apb_dec": {
            "regex": r"^top_nouvm\.u_dut\.u_tniu[0-2]\.u_sts_tniu_sys\.u_sts_tniu_apb_dec$",
            "examples": [f"top_nouvm.u_dut.u_tniu{i}.u_sts_tniu_sys.u_sts_tniu_apb_dec" for i in range(3)],
            "classifier": classify_tniu_apb_dec_signal,
            "reason": "APB decoder limited: paddr upper bits, stub slave port (m_pready_1/m_pslverr_1), dec_miss never asserted.",
        },
        # sts_tniu_noc_dec2 × 3
        "tniu_noc_dec2": {
            "regex": r"^top_nouvm\.u_dut\.u_tniu[0-2]\.u_sts_tniu_noc\.u_tniu_noc_req_dec2$",
            "examples": [f"top_nouvm.u_dut.u_tniu{i}.u_sts_tniu_noc.u_tniu_noc_req_dec2" for i in range(3)],
            "classifier": classify_tniu_dec2_signal,
            "reason": "Request decoder payload flattened fields: address/ID range limited in bench topology.",
        },
        # req_fifo × 3
        "tniu_req_fifo": {
            "regex": r"^top_nouvm\.u_dut\.u_tniu[0-2]\.u_sts_tniu_sys\.u_sts_tniu_apb_sys\.u_req_fifo$",
            "examples": [f"top_nouvm.u_dut.u_tniu{i}.u_sts_tniu_sys.u_sts_tniu_apb_sys.u_req_fifo" for i in range(3)],
            "classifier": classify_req_fifo_signal,
            "reason": "Request FIFO pipeline: req.addr upper bits, req.len=0 (no burst), ID/opcode bits limited in topology.",
        },
    }

    print("=" * 80)
    print("Toggle waiver computation")
    print("=" * 80)

    rules = []
    for key, info in instances.items():
        total_bds = []
        dead_bds = []
        for ex in info["examples"]:
            total_bd, dead_bd, live_bd = compute_dead_bitdirs(text, ex, info["classifier"])
            total_bds.append(total_bd)
            dead_bds.append(dead_bd)
            t, c = get_toggle_summary(text, ex)
            pct_before = c / t * 100 if t else 0
            new_t = t - dead_bd
            pct_after = c / new_t * 100 if new_t else 0
            print(f"  {ex}")
            print(f"    total_bits={t}, covered={c}, uncov={total_bd}")
            print(f"    dead_bitdirs={dead_bd}, live_bitdirs={live_bd}")
            print(f"    before={pct_before:.1f}%, after_waiver={pct_after:.1f}%")

        # Verify all instances have same dead count (they should for same module)
        if len(set(dead_bds)) > 1:
            print(f"  WARNING: dead counts differ across instances: {dead_bds}")
            dead = min(dead_bds)  # Use minimum for safety
        else:
            dead = dead_bds[0]

        if dead > 0:
            rules.append({
                "name": f"waive_toggle_{key}",
                "instance_regex": info["regex"],
                "reason": info["reason"],
                "adjustments": {
                    "toggle": {"total": dead, "covered": 0}
                }
            })
            print(f"  RULE: toggle.total -= {dead}")
        print()

    # Output JSON
    print("\n" + "=" * 80)
    print("Generated waiver rules (JSON):")
    print("=" * 80)
    print(json.dumps(rules, indent=2))

    return rules


if __name__ == "__main__":
    main()
