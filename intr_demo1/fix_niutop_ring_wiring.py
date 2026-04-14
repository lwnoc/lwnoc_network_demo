#!/usr/bin/env python3
"""Fix missing iniu_top <-> ring_wrap and tniu_top <-> ring_wrap wiring in UHDL-generated wrappers.

For INIU wrappers (iniu0-3):
  Need to wire: iniu_top.req_* outputs -> ring_wrap.local_tx_* inputs
  New intermediate wires: iniu_top_TO_ring_wrap_SIG_req_{valid,ready,payload,srcid,tgtid,qos,last}

For TNIU wrappers (tniu0-1):
  Need to wire: ring_wrap.local_rx_* outputs -> tniu_top.req_* inputs
  New intermediate wires: ring_wrap_TO_tniu_top_SIG_req_{valid,ready,payload,srcid,tgtid,qos,last}
"""
import re, os

BUILD_DIR = "/home/lgzhu/dev/noc_work/aichip_memnoc/lwnoc_intr_noc_demo/build_logic/intr_ring_noc_4i2t"

def fix_iniu(fname):
    """Wire iniu_top.req_* -> ring_wrap.local_tx_*"""
    path = os.path.join(BUILD_DIR, fname)
    with open(path) as f:
        content = f.read()

    # 1) Add intermediate wires after existing wire section
    wire_block = """\twire        iniu_top_TO_ring_wrap_SIG_req_valid     ;
\twire [39:0] iniu_top_TO_ring_wrap_SIG_req_payload   ;
\twire [7:0]  iniu_top_TO_ring_wrap_SIG_req_srcid     ;
\twire [7:0]  iniu_top_TO_ring_wrap_SIG_req_tgtid     ;
\twire [3:0]  iniu_top_TO_ring_wrap_SIG_req_qos       ;
\twire        iniu_top_TO_ring_wrap_SIG_req_last      ;
\twire        ring_wrap_TO_iniu_top_SIG_req_ready     ;
"""
    # Insert after the last existing wire line
    content = content.replace(
        "\t//Wire define for Inout.\n",
        wire_block + "\n\t//Wire define for Inout.\n"
    )

    # 2) Connect iniu_top ports to intermediate wires
    content = content.replace(
        "\t\t.req_valid(),\n"
        "\t\t.req_ready(),\n"
        "\t\t.req_payload(),\n"
        "\t\t.req_srcid(),\n"
        "\t\t.req_tgtid(),\n"
        "\t\t.req_qos(),\n"
        "\t\t.req_last(),\n"
        "\t\t.req_threshold());",
        "\t\t.req_valid(iniu_top_TO_ring_wrap_SIG_req_valid),\n"
        "\t\t.req_ready(ring_wrap_TO_iniu_top_SIG_req_ready),\n"
        "\t\t.req_payload(iniu_top_TO_ring_wrap_SIG_req_payload),\n"
        "\t\t.req_srcid(iniu_top_TO_ring_wrap_SIG_req_srcid),\n"
        "\t\t.req_tgtid(iniu_top_TO_ring_wrap_SIG_req_tgtid),\n"
        "\t\t.req_qos(iniu_top_TO_ring_wrap_SIG_req_qos),\n"
        "\t\t.req_last(iniu_top_TO_ring_wrap_SIG_req_last),\n"
        "\t\t.req_threshold());"
    )

    # 3) Connect ring_wrap local_tx ports to intermediate wires
    content = content.replace(
        "\t\t.local_tx_local_tx_last(),\n"
        "\t\t.local_tx_local_tx_payload(),\n"
        "\t\t.local_tx_local_tx_qos(),\n"
        "\t\t.local_tx_local_tx_ready(),\n"
        "\t\t.local_tx_local_tx_srcid(),\n"
        "\t\t.local_tx_local_tx_tgtid(),\n"
        "\t\t.local_tx_local_tx_valid(),",
        "\t\t.local_tx_local_tx_last(iniu_top_TO_ring_wrap_SIG_req_last),\n"
        "\t\t.local_tx_local_tx_payload(iniu_top_TO_ring_wrap_SIG_req_payload),\n"
        "\t\t.local_tx_local_tx_qos(iniu_top_TO_ring_wrap_SIG_req_qos),\n"
        "\t\t.local_tx_local_tx_ready(ring_wrap_TO_iniu_top_SIG_req_ready),\n"
        "\t\t.local_tx_local_tx_srcid(iniu_top_TO_ring_wrap_SIG_req_srcid),\n"
        "\t\t.local_tx_local_tx_tgtid(iniu_top_TO_ring_wrap_SIG_req_tgtid),\n"
        "\t\t.local_tx_local_tx_valid(iniu_top_TO_ring_wrap_SIG_req_valid),"
    )

    with open(path, 'w') as f:
        f.write(content)
    print(f"  Fixed INIU: {fname}")


def fix_tniu(fname):
    """Wire ring_wrap.local_rx_* -> tniu_top.req_*"""
    path = os.path.join(BUILD_DIR, fname)
    with open(path) as f:
        content = f.read()

    # 1) Add intermediate wires
    wire_block = """\twire        ring_wrap_TO_tniu_top_SIG_req_valid     ;
\twire [39:0] ring_wrap_TO_tniu_top_SIG_req_payload   ;
\twire [7:0]  ring_wrap_TO_tniu_top_SIG_req_srcid     ;
\twire [7:0]  ring_wrap_TO_tniu_top_SIG_req_tgtid     ;
\twire [3:0]  ring_wrap_TO_tniu_top_SIG_req_qos       ;
\twire        ring_wrap_TO_tniu_top_SIG_req_last      ;
\twire        tniu_top_TO_ring_wrap_SIG_req_ready     ;
"""
    content = content.replace(
        "\t//Wire define for Inout.\n",
        wire_block + "\n\t//Wire define for Inout.\n"
    )

    # 2) Connect tniu_top ports to intermediate wires
    content = content.replace(
        "\t\t.req_valid(),\n"
        "\t\t.req_ready(),\n"
        "\t\t.req_payload(),\n"
        "\t\t.req_srcid(),\n"
        "\t\t.req_tgtid(),\n"
        "\t\t.req_qos(),\n"
        "\t\t.req_last(),\n"
        "\t\t.req_threshold());",
        "\t\t.req_valid(ring_wrap_TO_tniu_top_SIG_req_valid),\n"
        "\t\t.req_ready(tniu_top_TO_ring_wrap_SIG_req_ready),\n"
        "\t\t.req_payload(ring_wrap_TO_tniu_top_SIG_req_payload),\n"
        "\t\t.req_srcid(ring_wrap_TO_tniu_top_SIG_req_srcid),\n"
        "\t\t.req_tgtid(ring_wrap_TO_tniu_top_SIG_req_tgtid),\n"
        "\t\t.req_qos(ring_wrap_TO_tniu_top_SIG_req_qos),\n"
        "\t\t.req_last(ring_wrap_TO_tniu_top_SIG_req_last),\n"
        "\t\t.req_threshold());"
    )

    # 3) Connect ring_wrap local_rx ports to intermediate wires
    content = content.replace(
        "\t\t.local_rx_local_rx_last(),\n"
        "\t\t.local_rx_local_rx_payload(),\n"
        "\t\t.local_rx_local_rx_qos(),\n"
        "\t\t.local_rx_local_rx_ready(),\n"
        "\t\t.local_rx_local_rx_srcid(),\n"
        "\t\t.local_rx_local_rx_tgtid(),\n"
        "\t\t.local_rx_local_rx_valid());",
        "\t\t.local_rx_local_rx_last(ring_wrap_TO_tniu_top_SIG_req_last),\n"
        "\t\t.local_rx_local_rx_payload(ring_wrap_TO_tniu_top_SIG_req_payload),\n"
        "\t\t.local_rx_local_rx_qos(ring_wrap_TO_tniu_top_SIG_req_qos),\n"
        "\t\t.local_rx_local_rx_ready(tniu_top_TO_ring_wrap_SIG_req_ready),\n"
        "\t\t.local_rx_local_rx_srcid(ring_wrap_TO_tniu_top_SIG_req_srcid),\n"
        "\t\t.local_rx_local_rx_tgtid(ring_wrap_TO_tniu_top_SIG_req_tgtid),\n"
        "\t\t.local_rx_local_rx_valid(ring_wrap_TO_tniu_top_SIG_req_valid));"
    )

    with open(path, 'w') as f:
        f.write(content)
    print(f"  Fixed TNIU: {fname}")


if __name__ == "__main__":
    for i in range(4):
        fix_iniu(f"iniu{i}.v")
    for i in range(2):
        fix_tniu(f"tniu{i}.v")
    print("Done.")
