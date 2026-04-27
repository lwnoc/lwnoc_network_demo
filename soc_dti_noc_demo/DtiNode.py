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
from uhdl.uhdl.core import And, Component, Cut, Equal, Input, Not, Output, UInt, when
from uhdl.uhdl.core.TemplateIP import TemplateComponent
import DtiTemplate as template


class DtiReqRspAsyncBridgeSlvNode(UhdlComponentNode):
    def __init__(self, id: str, cfg):
        params = getattr(cfg, 'param_overrides', {})
        comp = TemplateComponent(config=cfg, top="dti_async_bridge_slv", **params)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("s_chan", r"^s_(valid|ready|payload|last|srcid|tgtid|qos|threshold)$")
        self.add_interface("sync", r"^(wptr_async|rptr_async|rptr_sync|pld_sync)$")


class DtiReqRspAsyncBridgeMstNode(UhdlComponentNode):
    def __init__(self, id: str, cfg):
        params = getattr(cfg, 'param_overrides', {})
        comp = TemplateComponent(config=cfg, top="dti_async_bridge_mst", **params)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("m_chan", r"^m_(valid|ready|payload|last|srcid|tgtid|qos|threshold)$")
        self.add_interface("sync", r"^(wptr_async|rptr_async|rptr_sync|pld_sync)$")


class DtiReqRspAsyncBridgeNode(UhdlWrapperNode):
    def __init__(self, id: str, cfg):
        super().__init__(id=id)

        self.add_interface("clk_src")
        self.add_interface("rst_src_n")
        self.add_interface("clk_dst")
        self.add_interface("rst_dst_n")
        self.add_interface("s_chan")
        self.add_interface("m_chan")

        self.slv_side = DtiReqRspAsyncBridgeSlvNode(id=f"{id}_slv", cfg=cfg)
        self.mst_side = DtiReqRspAsyncBridgeMstNode(id=f"{id}_mst", cfg=cfg)

        connect(self.slv_side.clk, self.clk_src)
        connect(self.slv_side.rst_n, self.rst_src_n)
        connect(self.mst_side.clk, self.clk_dst)
        connect(self.mst_side.rst_n, self.rst_dst_n)
        connect(self.slv_side.s_chan, self.s_chan)
        connect(self.mst_side.m_chan, self.m_chan)
        connect(self.slv_side.sync, self.mst_side.sync)

        self.expose_unconnected_interfaces()


# ── Link pipe (REQ direction) ───────────────────────────────────────────
class DtiLinkPipeReqNode(UhdlComponentNode):
    """REQ-direction pipeline register. RTL: dti_link_pipe.
    s_req = s_*(in), m_req = m_*(out)."""
    def __init__(self, id: str, cfg):
        params = getattr(cfg, 'param_overrides', {})
        comp = TemplateComponent(config=cfg, top="dti_link_pipe", **params)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("s_req", r"^s_(valid|ready|payload|last|srcid|tgtid|qos|threshold)$")
        self.add_interface("m_req", r"^m_(valid|ready|payload|last|srcid|tgtid|qos|threshold)$")


# ── Link pipe (RSP direction) ───────────────────────────────────────────
class DtiLinkPipeRspNode(UhdlComponentNode):
    """RSP-direction pipeline register. RTL: dti_link_pipe.
    s_rsp = s_*(in), m_rsp = m_*(out)."""
    def __init__(self, id: str, cfg):
        params = getattr(cfg, 'param_overrides', {})
        comp = TemplateComponent(config=cfg, top="dti_link_pipe", **params)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("s_rsp", r"^s_(valid|ready|payload|last|srcid|tgtid|qos|threshold)$")
        self.add_interface("m_rsp", r"^m_(valid|ready|payload|last|srcid|tgtid|qos|threshold)$")


# ── Link buffer (REQ direction) ─────────────────────────────────────────
class DtiLinkBufReqNode(UhdlComponentNode):
    """REQ-direction link buffer (FIFO). RTL: dti_link_buf.
    s_req = write_req_*(in), m_req = read_resp_*(out)."""
    def __init__(self, id: str, cfg):
        params = getattr(cfg, 'param_overrides', {})
        comp = TemplateComponent(config=cfg, top="dti_link_buf", **params)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("s_req", r"^(write_req_(valid|ready|payload|last|srcid|tgtid|qos|threshold))$")
        self.add_interface("m_req", r"^(read_resp_(valid|ready|payload|last|srcid|tgtid|qos|threshold))$")
        self.add_interface("ctrl", r"^(stall|clear|idle|almost_full|almost_empty|empty|full)$")


# ── Link buffer (RSP direction) ─────────────────────────────────────────
class DtiLinkBufRspNode(UhdlComponentNode):
    """RSP-direction link buffer (FIFO). RTL: dti_link_buf.
    s_rsp = write_req_*(in), m_rsp = read_resp_*(out).
    TieOffDoc: write_req_threshold excluded from s_rsp for the same reason as
    DtiLinkBufReqNode — the peer (switch/TNIU) already ties its output-side
    threshold internally."""
    def __init__(self, id: str, cfg):
        params = getattr(cfg, 'param_overrides', {})
        comp = TemplateComponent(config=cfg, top="dti_link_buf", **params)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("s_rsp", r"^(write_req_(valid|ready|payload|last|srcid|tgtid|qos|threshold))$")
        self.add_interface("m_rsp", r"^(read_resp_(valid|ready|payload|last|srcid|tgtid|qos|threshold))$")
        self.add_interface("ctrl", r"^(stall|clear|idle|almost_full|almost_empty|empty|full)$")


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
    def __init__(self, id: str, cfg):
        comp = TemplateComponent(config=cfg, top="dti_pr_iniu_async_top_side")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")
        self.add_interface("async_fifo", r".*wptr_async|.*rptr_async|.*rptr_sync|.*pld_sync")
        self.add_interface("lp_top_tx", r"lp_hub_tx_req")
        self.add_interface("lp_top_rx", r"lp_hub_rx_req")
        self.add_interface("top_req", r"req_(valid|payload|last|srcid|tgtid|qos|threshold|ready)")
        self.add_interface("top_rsp", r"rsp_(valid|payload|last|srcid|tgtid|qos|threshold|ready)")


class DtiTniuSysNode(UhdlComponentNode):
    def __init__(self, id: str, cfg):
        comp = TemplateComponent(config=cfg, top="dti_tniu_async_sys_side")
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
    def __init__(self, id: str, cfg):
        comp = TemplateComponent(config=cfg, top="dti_tniu_async_top_side")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")
        self.add_interface("async_fifo", r".*wptr_async|.*rptr_async|.*rptr_sync|.*pld_sync")
        self.add_interface("lp_top_tx", r"lp_hub_tx_req")
        self.add_interface("lp_top_rx", r"lp_hub_rx_req")
        self.add_interface("top_req_data", r"req_(valid|payload|last|srcid|tgtid|qos|threshold|ready)")
        self.add_interface("top_rsp", r"rsp_(valid|payload|last|srcid|tgtid|qos|threshold|ready)")


class DtiIniuTopWrapNode(UhdlWrapperNode):
    def __init__(self, id: str, top_cfg, node_name: str):
        super().__init__(id=id)

        self.add_interface("clk_top", is_global=True)
        self.add_interface("rst_top_n", is_global=True)
        self.add_interface("async_fifo")
        self.add_interface("lp_top_tx")
        self.add_interface("lp_top_rx")
        self.add_interface("top_req", r"^top_req_req_(valid|payload|last|srcid|tgtid|qos|threshold|ready)$")
        self.add_interface("top_rsp", r"^top_rsp_rsp_(valid|payload|last|srcid|tgtid|qos|threshold|ready)$")

        self.top_side = DtiIniuTopNode(id=f"{node_name}_top_side", cfg=top_cfg)

        connect(self.top_side.clk, self.clk_top)
        connect(self.top_side.rst_n, self.rst_top_n)
        connect(self.top_side.async_fifo, self.async_fifo)
        connect(self.top_side.lp_top_tx, self.lp_top_tx)
        connect(self.top_side.lp_top_rx, self.lp_top_rx)
        connect(self.top_side.top_req, self.top_req)
        connect(self.top_side.top_rsp, self.top_rsp)

        self.expose_unconnected_interfaces()


class DtiTniuTopWrapNode(UhdlWrapperNode):
    def __init__(self, id: str, top_cfg, node_name: str):
        super().__init__(id=id)

        self.add_interface("clk_top", is_global=True)
        self.add_interface("rst_top_n", is_global=True)
        self.add_interface("async_fifo")
        self.add_interface("lp_top_tx")
        self.add_interface("lp_top_rx")
        self.add_interface("top_req_data", r"^top_req_req_(valid|payload|last|srcid|tgtid|qos|threshold|ready)$")
        self.add_interface("top_rsp", r"^top_rsp_rsp_(valid|payload|last|srcid|tgtid|qos|threshold|ready)$")

        self.top_side = DtiTniuTopNode(id=f"{node_name}_top_side", cfg=top_cfg)

        connect(self.top_side.clk, self.clk_top)
        connect(self.top_side.rst_n, self.rst_top_n)
        connect(self.top_side.async_fifo, self.async_fifo)
        connect(self.top_side.lp_top_tx, self.lp_top_tx)
        connect(self.top_side.lp_top_rx, self.lp_top_rx)
        connect(self.top_side.top_req_data, self.top_req_data)
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
    def __init__(self, id: str, sys_cfg, node_name: str):
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

        self.sys_side = DtiTniuSysNode(id=f"{node_name}_sys_side", cfg=sys_cfg)

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
    def __init__(self, id: str, sys_cfg, top_cfg, node_name: str):
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
        self.top_wrap = DtiIniuTopWrapNode(id=f"{node_name}_top_wrap", top_cfg=top_cfg, node_name=node_name)

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
    def __init__(self, id: str, sys_cfg, top_cfg, node_name: str):
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
        self.add_interface("top_req_data", r"^top_req_top_req_req_(valid|payload|last|srcid|tgtid|qos|threshold|ready)$")
        self.add_interface("top_rsp", r"^top_rsp_rsp_(valid|payload|last|srcid|tgtid|qos|threshold|ready)$")

        self.sys_wrap = DtiTniuSysWrapNode(id=f"{node_name}_sys_wrap", sys_cfg=sys_cfg, node_name=node_name)
        self.top_wrap = DtiTniuTopWrapNode(id=f"{node_name}_top_wrap", top_cfg=top_cfg, node_name=node_name)

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
        connect(self.top_wrap.top_req_data, self.top_req_data)
        connect(self.top_wrap.top_rsp, self.top_rsp)

        self.expose_unconnected_interfaces()


# ── Switch nodes ─────────────────────────────────────────────────────────

class DtiSwitchNode(UhdlComponentNode):
    # Per-N wrapper modules only accept these params (NUM_INIU/NUM_TNIU baked in)
    _WRAPPER_PARAMS = frozenset({'TID_WIDTH', 'PAYLOAD_WIDTH',
                                  'TNIU_DECMIN', 'TNIU_DECMAX',
                                  'INIU_DECMIN', 'INIU_DECMAX'})

    def __init__(self, id: str, cfg, top: str, input_count: int):
        # For 2..10 INIUs, use the per-N wrapper with per-channel port names
        if 2 <= input_count <= 10:
            top = f"dti_noc_switch_{input_count}to1_wrap"
            params = dict(getattr(cfg, 'param_overrides', {}))
            # Filter: wrapper doesn't have NUM_INIU/NUM_TNIU params
            params = {k: v for k, v in params.items() if k in self._WRAPPER_PARAMS}
        else:
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