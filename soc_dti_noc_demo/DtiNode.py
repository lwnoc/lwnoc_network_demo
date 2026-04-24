import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parent
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.node.uhdlComponentNode import UhdlComponentNode
from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from topo_core.utils.networkHierOpt import connect
from uhdl.uhdl.core import And, BitXor, Component, Cut, Equal, Input, Not, Output, UInt, when
from uhdl.uhdl.core.TemplateIP import TemplateComponent

from DtiTemplate import (
    dti_link_buf_config,
    dti_link_pipe_config,
    dti_req_rsp_async_config,
    iniu_top_config,
    pcie_eth_iniu_sys_config,
    vpu_iniu_sys_config,
    dsp2_iniu_sys_config,
    dsp1_iniu_sys_config,
    dsp0_iniu_sys_config,
    noc_tbu1_iniu_sys_config,
    usb_ufs_iniu_sys_config,
    mipi0_iniu_sys_config,
    mipi1_iniu_sys_config,
    camera_iniu_sys_config,
    noc_tbu0_iniu_sys_config,
    tcu_tniu_sys_config,
    tniu_top_config,
)


class DtiReqRspAsyncBridgeSlvNode(UhdlComponentNode):
    def __init__(self, id: str = "dti_req_rsp_async_slv"):
        comp = TemplateComponent(config=dti_req_rsp_async_config, top="dti_async_bridge_slv")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("s_chan", r"^s_(valid|ready|payload|last|srcid|tgtid|qos|threshold)$")
        self.add_interface("sync", r"^(wptr_async|rptr_async|rptr_sync|pld_sync)$")


class DtiReqRspAsyncBridgeMstNode(UhdlComponentNode):
    def __init__(self, id: str = "dti_req_rsp_async_mst"):
        comp = TemplateComponent(config=dti_req_rsp_async_config, top="dti_async_bridge_mst")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("m_chan", r"^m_(valid|ready|payload|last|srcid|tgtid|qos|threshold)$")
        self.add_interface("sync", r"^(wptr_async|rptr_async|rptr_sync|pld_sync)$")


class DtiReqRspAsyncBridgeNode(UhdlWrapperNode):
    def __init__(self, id: str = "dti_req_rsp_async_bridge"):
        super().__init__(id=id)

        self.add_interface("clk_src")
        self.add_interface("rst_src_n")
        self.add_interface("clk_dst")
        self.add_interface("rst_dst_n")
        self.add_interface("s_chan")
        self.add_interface("m_chan")

        self.slv_side = DtiReqRspAsyncBridgeSlvNode(id=f"{id}_slv")
        self.mst_side = DtiReqRspAsyncBridgeMstNode(id=f"{id}_mst")

        connect(self.slv_side.clk, self.clk_src)
        connect(self.slv_side.rst_n, self.rst_src_n)
        connect(self.mst_side.clk, self.clk_dst)
        connect(self.mst_side.rst_n, self.rst_dst_n)
        connect(self.slv_side.s_chan, self.s_chan)
        connect(self.mst_side.m_chan, self.m_chan)
        connect(self.slv_side.sync, self.mst_side.sync)

        self.expose_unconnected_interfaces()


class DtiLinkPipeNode(UhdlComponentNode):
    def __init__(self, id: str = "dti_link_pipe"):
        comp = TemplateComponent(config=dti_link_pipe_config, top="dti_link_pipe")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("s_chan", r"^s_(valid|ready|payload|last|srcid|tgtid|qos|threshold)$")
        self.add_interface("m_chan", r"^m_(valid|ready|payload|last|srcid|tgtid|qos|threshold)$")


class DtiLinkBufNode(UhdlComponentNode):
    def __init__(self, id: str = "dti_link_buf"):
        comp = TemplateComponent(config=dti_link_buf_config, top="dti_link_buf")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("s_chan", r"^(write_req_(valid|ready|payload|last|srcid|tgtid|qos|threshold))$")
        self.add_interface("m_chan", r"^(read_resp_(valid|ready|payload|last|srcid|tgtid|qos|threshold))$")
        self.add_interface("ctrl", r"^(stall|clear|idle|almost_full|almost_empty|empty|full)$")


class DtiSharedTcuSwitchComponent(Component):
    def __init__(self, id_width: int = 6, payload_width: int = 90):
        self._id_width = id_width
        self._payload_width = payload_width
        super().__init__()

    @property
    def module_name(self):
        prefix = self.module_name_prefix
        base = "dti_shared_tcu_switch"
        if prefix:
            return f"{prefix}_{base}"
        return base

    def circuit(self):
        self.npu_req_valid = Input(UInt(1))
        self.npu_req_payload = Input(UInt(self._payload_width))
        self.npu_req_last = Input(UInt(1))
        self.npu_req_srcid = Input(UInt(self._id_width))
        self.npu_req_tgtid = Input(UInt(self._id_width))
        self.npu_req_qos = Input(UInt(1))
        self.npu_req_threshold = Output(UInt(1))
        self.npu_req_ready = Output(UInt(1))

        self.vpu_req_valid = Input(UInt(1))
        self.vpu_req_payload = Input(UInt(self._payload_width))
        self.vpu_req_last = Input(UInt(1))
        self.vpu_req_srcid = Input(UInt(self._id_width))
        self.vpu_req_tgtid = Input(UInt(self._id_width))
        self.vpu_req_qos = Input(UInt(1))
        self.vpu_req_threshold = Output(UInt(1))
        self.vpu_req_ready = Output(UInt(1))

        self.tcu_req_valid = Output(UInt(1))
        self.tcu_req_payload = Output(UInt(self._payload_width))
        self.tcu_req_last = Output(UInt(1))
        self.tcu_req_srcid = Output(UInt(self._id_width))
        self.tcu_req_tgtid = Output(UInt(self._id_width))
        self.tcu_req_qos = Output(UInt(1))
        self.tcu_req_threshold = Input(UInt(1))
        self.tcu_req_ready = Input(UInt(1))

        self.tcu_rsp_valid = Input(UInt(1))
        self.tcu_rsp_payload = Input(UInt(self._payload_width))
        self.tcu_rsp_last = Input(UInt(1))
        self.tcu_rsp_srcid = Input(UInt(self._id_width))
        self.tcu_rsp_tgtid = Input(UInt(self._id_width))
        self.tcu_rsp_qos = Input(UInt(1))
        self.tcu_rsp_threshold = Output(UInt(1))
        self.tcu_rsp_ready = Output(UInt(1))

        self.npu_rsp_valid = Output(UInt(1))
        self.npu_rsp_payload = Output(UInt(self._payload_width))
        self.npu_rsp_last = Output(UInt(1))
        self.npu_rsp_srcid = Output(UInt(self._id_width))
        self.npu_rsp_tgtid = Output(UInt(self._id_width))
        self.npu_rsp_qos = Output(UInt(1))
        self.npu_rsp_threshold = Input(UInt(1))
        self.npu_rsp_ready = Input(UInt(1))

        self.vpu_rsp_valid = Output(UInt(1))
        self.vpu_rsp_payload = Output(UInt(self._payload_width))
        self.vpu_rsp_last = Output(UInt(1))
        self.vpu_rsp_srcid = Output(UInt(self._id_width))
        self.vpu_rsp_tgtid = Output(UInt(self._id_width))
        self.vpu_rsp_qos = Output(UInt(1))
        self.vpu_rsp_threshold = Input(UInt(1))
        self.vpu_rsp_ready = Input(UInt(1))

        sel_npu = self.npu_req_valid
        sel_vpu = And(Not(self.npu_req_valid), self.vpu_req_valid)
        rsp_to_vpu = Equal(Cut(self.tcu_rsp_srcid, 2, 2), UInt(1, 1))

        self.tcu_req_valid += self.npu_req_valid | self.vpu_req_valid
        self.tcu_req_payload += when(sel_npu).then(self.npu_req_payload).otherwise(self.vpu_req_payload)
        self.tcu_req_last += when(sel_npu).then(self.npu_req_last).otherwise(self.vpu_req_last)
        self.tcu_req_srcid += when(sel_npu).then(self.npu_req_srcid).otherwise(UInt(self._id_width, 4))
        self.tcu_req_tgtid += when(sel_npu).then(self.npu_req_tgtid).otherwise(self.vpu_req_tgtid)
        self.tcu_req_qos += when(sel_npu).then(self.npu_req_qos).otherwise(self.vpu_req_qos)

        self.npu_req_ready += And(sel_npu, self.tcu_req_ready)
        self.vpu_req_ready += And(sel_vpu, self.tcu_req_ready)
        self.npu_req_threshold += And(sel_npu, self.tcu_req_threshold)
        self.vpu_req_threshold += And(sel_vpu, self.tcu_req_threshold)

        self.npu_rsp_valid += And(self.tcu_rsp_valid, Not(rsp_to_vpu))
        self.npu_rsp_payload += self.tcu_rsp_payload
        self.npu_rsp_last += self.tcu_rsp_last
        self.npu_rsp_srcid += self.tcu_rsp_srcid
        self.npu_rsp_tgtid += self.tcu_rsp_tgtid
        self.npu_rsp_qos += self.tcu_rsp_qos

        self.vpu_rsp_valid += And(self.tcu_rsp_valid, rsp_to_vpu)
        self.vpu_rsp_payload += self.tcu_rsp_payload
        self.vpu_rsp_last += self.tcu_rsp_last
        self.vpu_rsp_srcid += UInt(self._id_width, 0)
        self.vpu_rsp_tgtid += self.tcu_rsp_tgtid
        self.vpu_rsp_qos += self.tcu_rsp_qos

        self.tcu_rsp_ready += when(rsp_to_vpu).then(self.vpu_rsp_ready).otherwise(self.npu_rsp_ready)
        self.tcu_rsp_threshold += when(rsp_to_vpu).then(self.vpu_rsp_threshold).otherwise(self.npu_rsp_threshold)


class DtiSharedTcuSwitchNode(UhdlComponentNode):
    def __init__(self, id: str = "dti_shared_tcu_switch"):
        comp = DtiSharedTcuSwitchComponent()
        super().__init__(id=id, impl=comp)

        self.add_interface("npu_req", r"npu_req_.*")
        self.add_interface("vpu_req", r"vpu_req_.*")
        self.add_interface("tcu_req", r"tcu_req_.*")
        self.add_interface("npu_rsp", r"npu_rsp_.*")
        self.add_interface("vpu_rsp", r"vpu_rsp_.*")
        self.add_interface("tcu_rsp", r"tcu_rsp_.*")

    def clear_io_states(self):
        # This node owns handwritten internal combinational logic on its outputs.
        # Clearing generic IO states would erase that implementation before Verilog generation.
        return


# ── Protocol bridge tieoff components ────────────────────────────────────────
# INIU top-side: initiator (drives valid/payload/srcid/last; receives ready)
#   Extra signals not supported by 5-signal switch:
#     req_qos/req_tgtid : INIU outputs → sink (tieoff absorbs)
#     req_threshold     : INIU input   → drive 0 (no switch backpressure)
#     rsp_qos/rsp_tgtid : INIU inputs  → drive 0 (switch has no qos/tgtid output)
#     rsp_threshold     : INIU output  → sink (tieoff absorbs)
class DtiIniuTopExtTieoffComponent(Component):
    def circuit(self):
        self.req_qos = Input(UInt(1))           # absorb INIU req_qos output
        self.req_threshold = Output(UInt(1))    # drive 0 → INIU req_threshold input
        self.req_tgtid = Input(UInt(6))         # absorb INIU req_tgtid output
        self.rsp_qos = Output(UInt(1))          # drive 0 → INIU rsp_qos input
        self.rsp_threshold = Input(UInt(1))     # absorb INIU rsp_threshold output
        self.rsp_tgtid = Output(UInt(6))        # drive 0 → INIU rsp_tgtid input
        # UInt(w, 0) is falsy in Python; use BitXor(x,x)=0 to force constant zero
        self.req_threshold += BitXor(UInt(1, 1), UInt(1, 1))
        self.rsp_qos += BitXor(UInt(1, 1), UInt(1, 1))
        self.rsp_tgtid += BitXor(UInt(6, 63), UInt(6, 63))


class DtiIniuTopExtTieoffNode(UhdlComponentNode):
    def __init__(self, id: str):
        comp = DtiIniuTopExtTieoffComponent()
        super().__init__(id=id, impl=comp)
        self.add_interface("top_req_ext", r"req_(qos|threshold|tgtid)")
        self.add_interface("top_rsp_ext", r"rsp_(qos|threshold|tgtid)")

    def build_uhdl(self):
        # clear_io_states() (called by parent wrapper before build_uhdl) wipes
        # the _rvalue set in circuit() for constant tie-off outputs.
        # Recreate the component fresh so circuit() re-runs and restores constants.
        self.uhdl_component = DtiIniuTopExtTieoffComponent()
        return self.uhdl_component


# TNIU top-side: target (receives valid/payload/srcid/last; drives ready)
#   Extra signals mirrored:
#     req_qos/req_tgtid : TNIU inputs  → drive 0
#     req_threshold     : TNIU output  → sink
#     rsp_qos/rsp_tgtid : TNIU outputs → sink
#     rsp_threshold     : TNIU input   → drive 0
class DtiTniuTopExtTieoffComponent(Component):
    def circuit(self):
        self.req_qos = Output(UInt(1))          # drive 0 → TNIU req_qos input
        self.req_threshold = Input(UInt(1))     # absorb TNIU req_threshold output
        self.req_tgtid = Output(UInt(6))        # drive 0 → TNIU req_tgtid input
        self.rsp_qos = Input(UInt(1))           # absorb TNIU rsp_qos output
        self.rsp_threshold = Output(UInt(1))    # drive 0 → TNIU rsp_threshold input
        self.rsp_tgtid = Input(UInt(6))         # absorb TNIU rsp_tgtid output
        # UInt(w, 0) is falsy in Python; use BitXor(x,x)=0 to force constant zero
        self.req_qos += BitXor(UInt(1, 1), UInt(1, 1))
        self.req_tgtid += BitXor(UInt(6, 63), UInt(6, 63))
        self.rsp_threshold += BitXor(UInt(1, 1), UInt(1, 1))


class DtiTniuTopExtTieoffNode(UhdlComponentNode):
    def __init__(self, id: str):
        comp = DtiTniuTopExtTieoffComponent()
        super().__init__(id=id, impl=comp)
        self.add_interface("top_req_ext", r"req_(qos|threshold|tgtid)")
        self.add_interface("top_rsp_ext", r"rsp_(qos|threshold|tgtid)")

    def build_uhdl(self):
        # Same reason as DtiIniuTopExtTieoffNode: recreate to restore circuit() constants.
        self.uhdl_component = DtiTniuTopExtTieoffComponent()
        return self.uhdl_component


class DtiIniuSysNode(UhdlComponentNode):
    def __init__(self, id: str, cfg):
        params = getattr(cfg, 'param_overrides', {})
        comp = TemplateComponent(config=cfg, top="dti_pr_iniu_async_sys_side", **params)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")
        self.add_interface("dti_req", r"req_t(valid|data|keep|last|tid|ready)")
        self.add_interface("dti_rsp", r"rsp_t(valid|data|keep|last|tid|ready)")
        self.add_interface("req_twakeup", "req_twakeup")
        self.add_interface("rsp_twakeup", "rsp_twakeup")
        self.add_interface("async_fifo", r".*wptr_async|.*rptr_async|.*rptr_sync|.*pld_sync")
        self.add_interface("lp_top_tx", r"lp_hub_tx_req")
        self.add_interface("lp_top_rx", r"lp_hub_rx_req")
        self.add_interface("timeout_val", "timeout_val")
        self.add_interface("pchnl_ctrl", r"preq|pstate|pactive|paccept|pdeny")


class DtiIniuTopNode(UhdlComponentNode):
    def __init__(self, id: str):
        comp = TemplateComponent(config=iniu_top_config, top="dti_pr_iniu_async_top_side")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")
        self.add_interface("async_fifo", r".*wptr_async|.*rptr_async|.*rptr_sync|.*pld_sync")
        self.add_interface("lp_top_tx", r"lp_hub_tx_req")
        self.add_interface("lp_top_rx", r"lp_hub_rx_req")
        self.add_interface("top_req", r"req_(valid|payload|last|srcid|tgtid|qos|threshold|ready)")
        self.add_interface("top_rsp", r"rsp_(valid|payload|last|srcid|tgtid|qos|threshold|ready)")


class DtiTniuSysNode(UhdlComponentNode):
    def __init__(self, id: str):
        comp = TemplateComponent(config=tcu_tniu_sys_config, top="dti_tniu_async_sys_side")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")
        self.add_interface("dti_req", r"req_t(valid|data|keep|last|tid|ready)")
        self.add_interface("dti_rsp", r"rsp_t(valid|data|keep|last|tid|ready)")
        self.add_interface("req_twakeup", "req_twakeup")
        self.add_interface("rsp_twakeup", "rsp_twakeup")
        self.add_interface("async_fifo", r".*wptr_async|.*rptr_async|.*rptr_sync|.*pld_sync")
        self.add_interface("lp_top_tx", r"lp_hub_tx_req")
        self.add_interface("lp_top_rx", r"lp_hub_rx_req")
        self.add_interface("pchnl_ctrl", r"preq|pstate|pactive|paccept|pdeny")


class DtiTniuTopNode(UhdlComponentNode):
    def __init__(self, id: str):
        comp = TemplateComponent(config=tniu_top_config, top="dti_tniu_async_top_side")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")
        self.add_interface("async_fifo", r".*wptr_async|.*rptr_async|.*rptr_sync|.*pld_sync")
        self.add_interface("lp_top_tx", r"lp_hub_tx_req")
        self.add_interface("lp_top_rx", r"lp_hub_rx_req")
        self.add_interface("top_req", r"req_(valid|payload|last|srcid|tgtid|qos|threshold|ready)")
        self.add_interface("top_rsp", r"rsp_(valid|payload|last|srcid|tgtid|qos|threshold|ready)")


class DtiIniuTopWrapNode(UhdlWrapperNode):
    def __init__(self, id: str, node_name: str):
        super().__init__(id=id)

        self.add_interface("clk_top", is_global=True)
        self.add_interface("rst_top_n", is_global=True)
        self.add_interface("async_fifo")
        self.add_interface("lp_top_tx")
        self.add_interface("lp_top_rx")
        self.add_interface("top_req", r"^top_req_req_(valid|payload|last|srcid|tgtid|qos|threshold|ready)$")
        self.add_interface("top_rsp", r"^top_rsp_rsp_(valid|payload|last|srcid|tgtid|qos|threshold|ready)$")

        self.top_side = DtiIniuTopNode(id=f"{node_name}_top_side")

        connect(self.top_side.clk, self.clk_top)
        connect(self.top_side.rst_n, self.rst_top_n)
        connect(self.top_side.async_fifo, self.async_fifo)
        connect(self.top_side.lp_top_tx, self.lp_top_tx)
        connect(self.top_side.lp_top_rx, self.lp_top_rx)
        connect(self.top_side.top_req, self.top_req)
        connect(self.top_side.top_rsp, self.top_rsp)

        self.expose_unconnected_interfaces()


class DtiTniuTopWrapNode(UhdlWrapperNode):
    def __init__(self, id: str, node_name: str):
        super().__init__(id=id)

        self.add_interface("clk_top", is_global=True)
        self.add_interface("rst_top_n", is_global=True)
        self.add_interface("async_fifo")
        self.add_interface("lp_top_tx")
        self.add_interface("lp_top_rx")
        self.add_interface("top_req", r"^top_req_req_(valid|payload|last|srcid|tgtid|qos|threshold|ready)$")
        self.add_interface("top_rsp", r"^top_rsp_rsp_(valid|payload|last|srcid|tgtid|qos|threshold|ready)$")

        self.top_side = DtiTniuTopNode(id=f"{node_name}_top_side")

        connect(self.top_side.clk, self.clk_top)
        connect(self.top_side.rst_n, self.rst_top_n)
        connect(self.top_side.async_fifo, self.async_fifo)
        connect(self.top_side.lp_top_tx, self.lp_top_tx)
        connect(self.top_side.lp_top_rx, self.lp_top_rx)
        connect(self.top_side.top_req, self.top_req)
        connect(self.top_side.top_rsp, self.top_rsp)

        self.expose_unconnected_interfaces()


class DtiIniuSysWrapNode(UhdlWrapperNode):
    def __init__(self, id: str, cfg, node_name: str):
        super().__init__(id=id, module_name=f"{cfg.name}_wrap")

        self.add_interface("clk_sys")
        self.add_interface("rst_sys_n")
        self.add_interface("dti_req")
        self.add_interface("dti_rsp")
        self.add_interface("req_twakeup")
        self.add_interface("rsp_twakeup")
        self.add_interface("timeout_val")
        self.add_interface("pchnl_ctrl")
        self.add_interface("async_fifo")
        self.add_interface("lp_top_tx")
        self.add_interface("lp_top_rx")

        self.sys_side = DtiIniuSysNode(id=f"{node_name}_sys_side", cfg=cfg)

        connect(self.sys_side.clk, self.clk_sys)
        connect(self.sys_side.rst_n, self.rst_sys_n)
        connect(self.sys_side.dti_req, self.dti_req)
        connect(self.sys_side.dti_rsp, self.dti_rsp)
        connect(self.sys_side.req_twakeup, self.req_twakeup)
        connect(self.sys_side.rsp_twakeup, self.rsp_twakeup)
        connect(self.sys_side.timeout_val, self.timeout_val)
        connect(self.sys_side.pchnl_ctrl, self.pchnl_ctrl)
        connect(self.sys_side.async_fifo, self.async_fifo)
        connect(self.sys_side.lp_top_tx, self.lp_top_tx)
        connect(self.sys_side.lp_top_rx, self.lp_top_rx)

        self.expose_unconnected_interfaces()


class DtiTniuSysWrapNode(UhdlWrapperNode):
    def __init__(self, id: str, node_name: str):
        super().__init__(id=id, module_name="sys_tcu_tniu_sys_wrap")

        self.add_interface("clk_sys")
        self.add_interface("rst_sys_n")
        self.add_interface("dti_req")
        self.add_interface("dti_rsp")
        self.add_interface("req_twakeup")
        self.add_interface("rsp_twakeup")
        self.add_interface("pchnl_ctrl")
        self.add_interface("async_fifo")
        self.add_interface("lp_top_tx")
        self.add_interface("lp_top_rx")

        self.sys_side = DtiTniuSysNode(id=f"{node_name}_sys_side")

        connect(self.sys_side.clk, self.clk_sys)
        connect(self.sys_side.rst_n, self.rst_sys_n)
        connect(self.sys_side.dti_req, self.dti_req)
        connect(self.sys_side.dti_rsp, self.dti_rsp)
        connect(self.sys_side.req_twakeup, self.req_twakeup)
        connect(self.sys_side.rsp_twakeup, self.rsp_twakeup)
        connect(self.sys_side.pchnl_ctrl, self.pchnl_ctrl)
        connect(self.sys_side.async_fifo, self.async_fifo)
        connect(self.sys_side.lp_top_tx, self.lp_top_tx)
        connect(self.sys_side.lp_top_rx, self.lp_top_rx)

        self.expose_unconnected_interfaces()


class DtiIniuNode(UhdlWrapperNode):
    def __init__(self, id: str, sys_cfg, node_name: str):
        super().__init__(id=id)

        self.add_interface("clk_sys")
        self.add_interface("rst_sys_n")
        self.add_interface("clk_top", is_global=True)
        self.add_interface("rst_top_n", is_global=True)

        self.add_interface("dti_req")
        self.add_interface("dti_rsp")
        self.add_interface("req_twakeup")
        self.add_interface("rsp_twakeup")
        self.add_interface("timeout_val")
        self.add_interface("pchnl_ctrl")
        self.add_interface("top_req", r"^top_req_req_(valid|payload|last|srcid|tgtid|qos|threshold|ready)$")
        self.add_interface("top_rsp", r"^top_rsp_rsp_(valid|payload|last|srcid|tgtid|qos|threshold|ready)$")

        self.sys_wrap = DtiIniuSysWrapNode(id=f"{node_name}_sys_wrap", cfg=sys_cfg, node_name=node_name)
        self.top_wrap = DtiIniuTopWrapNode(id=f"{node_name}_top_wrap", node_name=node_name)

        connect(self.sys_wrap.clk_sys, self.clk_sys)
        connect(self.sys_wrap.rst_sys_n, self.rst_sys_n)
        connect(self.sys_wrap.dti_req, self.dti_req)
        connect(self.sys_wrap.dti_rsp, self.dti_rsp)
        connect(self.sys_wrap.req_twakeup, self.req_twakeup)
        connect(self.sys_wrap.rsp_twakeup, self.rsp_twakeup)
        connect(self.sys_wrap.timeout_val, self.timeout_val)
        connect(self.sys_wrap.pchnl_ctrl, self.pchnl_ctrl)
        connect(self.sys_wrap.async_fifo, self.top_wrap.async_fifo)
        connect(self.sys_wrap.lp_top_tx, self.top_wrap.lp_top_rx)
        connect(self.sys_wrap.lp_top_rx, self.top_wrap.lp_top_tx)

        connect(self.top_wrap.clk_top, self.clk_top)
        connect(self.top_wrap.rst_top_n, self.rst_top_n)
        connect(self.top_wrap.top_req, self.top_req)
        connect(self.top_wrap.top_rsp, self.top_rsp)

        self.expose_unconnected_interfaces()


class DtiTniuNode(UhdlWrapperNode):
    def __init__(self, id: str, node_name: str):
        super().__init__(id=id)

        self.add_interface("clk_sys")
        self.add_interface("rst_sys_n")
        self.add_interface("clk_top", is_global=True)
        self.add_interface("rst_top_n", is_global=True)

        self.add_interface("dti_req")
        self.add_interface("dti_rsp")
        self.add_interface("req_twakeup")
        self.add_interface("rsp_twakeup")
        self.add_interface("pchnl_ctrl")
        self.add_interface("top_req", r"^top_req_req_(valid|payload|last|srcid|tgtid|qos|threshold|ready)$")
        self.add_interface("top_rsp", r"^top_rsp_rsp_(valid|payload|last|srcid|tgtid|qos|threshold|ready)$")

        self.sys_wrap = DtiTniuSysWrapNode(id=f"{node_name}_sys_wrap", node_name=node_name)
        self.top_wrap = DtiTniuTopWrapNode(id=f"{node_name}_top_wrap", node_name=node_name)

        connect(self.sys_wrap.clk_sys, self.clk_sys)
        connect(self.sys_wrap.rst_sys_n, self.rst_sys_n)
        connect(self.sys_wrap.dti_req, self.dti_req)
        connect(self.sys_wrap.dti_rsp, self.dti_rsp)
        connect(self.sys_wrap.req_twakeup, self.req_twakeup)
        connect(self.sys_wrap.rsp_twakeup, self.rsp_twakeup)
        connect(self.sys_wrap.pchnl_ctrl, self.pchnl_ctrl)
        connect(self.sys_wrap.async_fifo, self.top_wrap.async_fifo)
        connect(self.sys_wrap.lp_top_tx, self.top_wrap.lp_top_rx)
        connect(self.sys_wrap.lp_top_rx, self.top_wrap.lp_top_tx)

        connect(self.top_wrap.clk_top, self.clk_top)
        connect(self.top_wrap.rst_top_n, self.rst_top_n)
        connect(self.top_wrap.top_req, self.top_req)
        connect(self.top_wrap.top_rsp, self.top_rsp)

        self.expose_unconnected_interfaces()


# ── Per-endpoint TBU INIU factory functions ───────────────────────────────────
def make_pcie_eth_iniu_node(id: str = "pcie_eth_iniu_node") -> DtiIniuNode:
    return DtiIniuNode(id=id, sys_cfg=pcie_eth_iniu_sys_config, node_name="pcie_eth")


def make_vpu_iniu_node(id: str = "vpu_iniu_node") -> DtiIniuNode:
    return DtiIniuNode(id=id, sys_cfg=vpu_iniu_sys_config, node_name="vpu")


def make_dsp2_iniu_node(id: str = "dsp2_iniu_node") -> DtiIniuNode:
    return DtiIniuNode(id=id, sys_cfg=dsp2_iniu_sys_config, node_name="dsp2")


def make_dsp1_iniu_node(id: str = "dsp1_iniu_node") -> DtiIniuNode:
    return DtiIniuNode(id=id, sys_cfg=dsp1_iniu_sys_config, node_name="dsp1")


def make_dsp0_iniu_node(id: str = "dsp0_iniu_node") -> DtiIniuNode:
    return DtiIniuNode(id=id, sys_cfg=dsp0_iniu_sys_config, node_name="dsp0")


def make_noc_tbu1_iniu_node(id: str = "noc_tbu1_iniu_node") -> DtiIniuNode:
    return DtiIniuNode(id=id, sys_cfg=noc_tbu1_iniu_sys_config, node_name="noc_tbu1")


def make_usb_ufs_iniu_node(id: str = "usb_ufs_iniu_node") -> DtiIniuNode:
    return DtiIniuNode(id=id, sys_cfg=usb_ufs_iniu_sys_config, node_name="usb_ufs")


def make_mipi0_iniu_node(id: str = "mipi0_iniu_node") -> DtiIniuNode:
    return DtiIniuNode(id=id, sys_cfg=mipi0_iniu_sys_config, node_name="mipi0")


def make_mipi1_iniu_node(id: str = "mipi1_iniu_node") -> DtiIniuNode:
    return DtiIniuNode(id=id, sys_cfg=mipi1_iniu_sys_config, node_name="mipi1")


def make_camera_iniu_node(id: str = "camera_iniu_node") -> DtiIniuNode:
    return DtiIniuNode(id=id, sys_cfg=camera_iniu_sys_config, node_name="camera")


def make_noc_tbu0_iniu_node(id: str = "noc_tbu0_iniu_node") -> DtiIniuNode:
    return DtiIniuNode(id=id, sys_cfg=noc_tbu0_iniu_sys_config, node_name="noc_tbu0")


def make_tcu_tniu_node(id: str = "tcu_tniu_node") -> DtiTniuNode:
    return DtiTniuNode(id=id, node_name="sys_tcu_tniu")


# ── Switch nodes (moved from DtiTreeNode.py) ────────────────────────────────

class DtiSwitchNode(UhdlComponentNode):
    def __init__(self, id: str, cfg, top: str, input_count: int):
        params = getattr(cfg, 'param_overrides', {})
        comp = TemplateComponent(config=cfg, top=top, **params)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("tniu_req", r"^tniu_req_.*")
        self.add_interface("tniu_rsp", r"^tniu_rsp_.*")

        for idx in range(input_count):
            self.add_interface(f"iniu{idx}_req", rf"^iniu{idx}_req_.*")
            self.add_interface(f"iniu{idx}_rsp", rf"^iniu{idx}_rsp_.*")