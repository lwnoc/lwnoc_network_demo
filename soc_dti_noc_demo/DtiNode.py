import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parent
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.node.uhdlComponentNode import UhdlComponentNode
from topo_core.node.uhdlWrapperNode import UhdlWrapperNode
from topo_core.edge import Edge
from topo_core.utils.edgeManager import EdgeManager
from topo_core.utils.networkHierOpt import connect
from uhdl.uhdl.core.TemplateIP import TemplateComponent
import DtiTemplate as template


def _get_dti_param_width(cfg, param_name: str, default: int) -> int:
    params = getattr(cfg, 'param_overrides', {}) or {}
    if param_name in params:
        return int(params[param_name])

    async_cfg = getattr(template, 'dti_req_rsp_async_config', None)
    async_params = getattr(async_cfg, 'param_overrides', {}) or {}
    return int(async_params.get(param_name, default))


def safe_connect(owner, interface1, interface2, edge_id: str | None = None) -> bool:
    node1 = getattr(interface1, 'node', None)
    node2 = getattr(interface2, 'node', None)
    local_nodes = {owner}
    local_nodes.update(getattr(owner, 'sub_nodes', {}).values())

    if node1 not in local_nodes or node2 not in local_nodes:
        return connect(interface1, interface2, edge_id)

    manager = EdgeManager.get_instance()
    if not manager.validate_interface(interface1, interface2):
        return False

    edge1 = interface1.edge
    edge2 = interface2.edge

    if edge1 and edge2 and edge1 is edge2:
        return True

    if not edge1 and not edge2:
        if not edge_id:
            edge_id = manager.generate_edge_id(
                f"{interface1.node.id}_{interface2.node.id}_{interface1.id}_{interface2.id}"
            )
        new_edge = Edge(edge_id)
        new_edge.add_pair(interface1, interface2)
        interface1.set_edge(new_edge)
        interface2.set_edge(new_edge)
        manager.add_edge(new_edge)
        return True

    if edge1 and not edge2:
        edge1.add_single(interface2)
        interface2.set_edge(edge1)
        return True

    if edge2 and not edge1:
        edge2.add_single(interface1)
        interface1.set_edge(edge2)
        return True

    if edge1 and edge2 and edge1 is not edge2:
        if not edge_id:
            edge_id = manager.generate_edge_id(f"merged_{edge1.id}_{edge2.id}")

        new_edge = Edge(edge_id)
        all_interfaces = set(edge1.endpoints)
        all_interfaces.update(edge2.endpoints)

        for interface in all_interfaces:
            new_edge.add_single(interface)
            interface.set_edge(new_edge)

        edge1.endpoints.clear()
        edge2.endpoints.clear()
        manager.remove_edge(edge1.id)
        manager.remove_edge(edge2.id)
        manager.add_edge(new_edge)
        return True

    return False


class DtiReqRspAsyncBridgeSlvNode(UhdlComponentNode):
    def __init__(self, id: str, cfg, clk_name="clk_noc", rst_name="rst_noc_n"):
        params = getattr(cfg, 'param_overrides', {})
        comp = TemplateComponent(config=cfg, top="dti_async_bridge_slv", **params)
        super().__init__(id=id, impl=comp)

        self.add_interface(clk_name, r"^clk$")
        self.add_interface(rst_name, r"^rst_n$")
        self.add_interface("s_chan", r"^s_(valid|ready|payload|last|srcid|tgtid|qos|threshold)$")
        self.add_interface("sync", r"^(wptr_async|rptr_async|rptr_sync|pld_sync)$")


class DtiReqRspAsyncBridgeMstNode(UhdlComponentNode):
    def __init__(self, id: str, cfg, clk_name="clk_noc_up", rst_name="rst_noc_up_n"):
        params = getattr(cfg, 'param_overrides', {})
        comp = TemplateComponent(config=cfg, top="dti_async_bridge_mst", **params)
        super().__init__(id=id, impl=comp)

        self.add_interface(clk_name, r"^clk$")
        self.add_interface(rst_name, r"^rst_n$")
        self.add_interface("m_chan", r"^m_(valid|ready|payload|last|srcid|tgtid|qos|threshold)$")
        self.add_interface("sync", r"^(wptr_async|rptr_async|rptr_sync|pld_sync)$")
        self.add_interface("afifo_sb_err", r"^afifo_sb_err$")
        self.add_interface("afifo_db_err", r"^afifo_db_err$")


class DtiReqRspAsyncBridgeNode(UhdlWrapperNode):
    def __init__(self, id: str, cfg):
        super().__init__(id=id)

        self.add_interface("clk_src")
        self.add_interface("rst_src_n")
        self.add_interface("clk_dst")
        self.add_interface("rst_dst_n")
        self.add_interface("s_chan")
        self.add_interface("m_chan")

        self.slv_side = DtiReqRspAsyncBridgeSlvNode(id=f"{id}_slv", cfg=cfg, clk_name="clk_noc", rst_name="rst_noc_n")
        self.mst_side = DtiReqRspAsyncBridgeMstNode(id=f"{id}_mst", cfg=cfg, clk_name="clk_noc_up", rst_name="rst_noc_up_n")

        safe_connect(self, self.slv_side.clk_noc, self.clk_src)
        safe_connect(self, self.slv_side.rst_noc_n, self.rst_src_n)
        safe_connect(self, self.mst_side.clk_noc_up, self.clk_dst)
        safe_connect(self, self.mst_side.rst_noc_up_n, self.rst_dst_n)
        safe_connect(self, self.slv_side.s_chan, self.s_chan)
        safe_connect(self, self.mst_side.m_chan, self.m_chan)
        safe_connect(self, self.slv_side.sync, self.mst_side.sync)

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

        self.add_interface("clk_noc", r"^clk$")
        self.add_interface("rst_noc_n", r"^rst_n$")
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
        comp = TemplateComponent(config=cfg, top="dti_pr_iniu_async_sys_side", struct_mode="packed", **params)
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
        self.add_interface("rsp_afifo_sb_err", r"^rsp_afifo_sb_err$")
        self.add_interface("rsp_afifo_db_err", r"^rsp_afifo_db_err$")


class DtiIniuTopNode(UhdlComponentNode):
    def __init__(self, id: str, cfg, node_name: str, route_base: int = 0, clk_name="clk_noc", rst_name="rst_noc_n"):
        leaf_cfg = template.make_iniu_top_leaf_config(cfg, node_name, route_base)
        comp = TemplateComponent(
            config=leaf_cfg,
            top="dti_pr_iniu_async_top_side",
            struct_mode="packed",
        )
        super().__init__(id=id, impl=comp)

        self.add_interface(clk_name, "clk")
        self.add_interface(rst_name, "rst_n")
        self.add_interface("async_fifo", r".*wptr_async|.*rptr_async|.*rptr_sync|.*pld_sync")
        self.add_interface("lp_top_tx", r"lp_hub_tx_req")
        self.add_interface("lp_top_rx", r"lp_hub_rx_req")
        self.add_interface("top_req", r"req_(valid|payload|last|srcid|tgtid|qos|threshold|ready)")
        self.add_interface("top_rsp", r"rsp_(valid|payload|last|srcid|tgtid|qos|threshold|ready)")
        self.add_interface("afifo_sb_err", r"^req_afifo_sb_err$")
        self.add_interface("afifo_db_err", r"^req_afifo_db_err$")


class DtiTniuSysNode(UhdlComponentNode):
    def __init__(self, id: str, cfg):
        comp = TemplateComponent(config=cfg, top="dti_tniu_async_sys_side", struct_mode="packed")
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
        self.add_interface("req_afifo_sb_err", r"^req_afifo_sb_err$")
        self.add_interface("req_afifo_db_err", r"^req_afifo_db_err$")


class DtiTniuTopNode(UhdlComponentNode):
    def __init__(self, id: str, cfg, clk_name="clk_noc_up", rst_name="rst_noc_up_n"):
        comp = TemplateComponent(config=cfg, top="dti_tniu_async_top_side", struct_mode="packed")
        super().__init__(id=id, impl=comp)

        self.add_interface(clk_name, "clk")
        self.add_interface(rst_name, "rst_n")
        self.add_interface("async_fifo", r".*wptr_async|.*rptr_async|.*rptr_sync|.*pld_sync")
        self.add_interface("lp_top_tx", r"lp_hub_tx_req")
        self.add_interface("lp_top_rx", r"lp_hub_rx_req")
        self.add_interface("top_req_data", r"req_(valid|payload|last|srcid|tgtid|qos|threshold|ready)")
        self.add_interface("top_rsp", r"rsp_(valid|payload|last|srcid|tgtid|qos|threshold|ready)")
        self.add_interface("rsp_afifo_sb_err", r"^rsp_afifo_sb_err$")
        self.add_interface("rsp_afifo_db_err", r"^rsp_afifo_db_err$")


class DtiIniuTopWrapNode(UhdlWrapperNode):
    def __init__(self, id: str, top_cfg, node_name: str, route_base: int = 0, clk_name="clk_noc", rst_name="rst_noc_n"):
        super().__init__(id=id)

        self.add_interface(clk_name, is_global=True)
        self.add_interface(rst_name, is_global=True)
        self.add_interface("async_fifo")
        self.add_interface("lp_top_tx")
        self.add_interface("lp_top_rx")
        self.add_interface("top_req", r"^top_req_req_(valid|payload|last|srcid|tgtid|qos|threshold|ready)$")
        self.add_interface("top_rsp", r"^top_rsp_rsp_(valid|payload|last|srcid|tgtid|qos|threshold|ready)$")
        self.add_interface("afifo_sb_err")
        self.add_interface("afifo_db_err")

        self.top_side = DtiIniuTopNode(
            id=f"{node_name}_top_side",
            cfg=top_cfg,
            node_name=node_name,
            route_base=route_base,
            clk_name=clk_name,
            rst_name=rst_name,
        )

        safe_connect(self, getattr(self.top_side, clk_name), getattr(self, clk_name))
        safe_connect(self, getattr(self.top_side, rst_name), getattr(self, rst_name))
        safe_connect(self, self.top_side.async_fifo, self.async_fifo)
        safe_connect(self, self.top_side.lp_top_tx, self.lp_top_tx)
        safe_connect(self, self.top_side.lp_top_rx, self.lp_top_rx)
        safe_connect(self, self.top_side.top_req, self.top_req)
        safe_connect(self, self.top_side.top_rsp, self.top_rsp)
        safe_connect(self, self.top_side.afifo_sb_err, self.afifo_sb_err)
        safe_connect(self, self.top_side.afifo_db_err, self.afifo_db_err)

        self.expose_unconnected_interfaces()


class DtiTniuTopWrapNode(UhdlWrapperNode):
    def __init__(self, id: str, top_cfg, node_name: str, clk_name="clk_noc", rst_name="rst_noc_n"):
        super().__init__(id=id)

        self.add_interface(clk_name, is_global=True)
        self.add_interface(rst_name, is_global=True)
        self.add_interface("async_fifo")
        self.add_interface("lp_top_tx")
        self.add_interface("lp_top_rx")
        self.add_interface("top_req_data", r"^top_req_req_(valid|payload|last|srcid|tgtid|qos|threshold|ready)$")
        self.add_interface("top_rsp", r"^top_rsp_rsp_(valid|payload|last|srcid|tgtid|qos|threshold|ready)$")

        self.top_side = DtiTniuTopNode(id=f"{node_name}_top_side", cfg=top_cfg, clk_name=clk_name, rst_name=rst_name)

        safe_connect(self, getattr(self.top_side, clk_name), getattr(self, clk_name))
        safe_connect(self, getattr(self.top_side, rst_name), getattr(self, rst_name))
        safe_connect(self, self.top_side.async_fifo, self.async_fifo)
        safe_connect(self, self.top_side.lp_top_tx, self.lp_top_tx)
        safe_connect(self, self.top_side.lp_top_rx, self.lp_top_rx)
        safe_connect(self, self.top_side.top_req_data, self.top_req_data)
        safe_connect(self, self.top_side.top_rsp, self.top_rsp)

        self.expose_unconnected_interfaces()


class DtiIniuSysWrapNode(UhdlWrapperNode):
    def __init__(self, id: str, cfg, node_name: str):
        super().__init__(id=id, module_name=f"{node_name}_sys_wrap")

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

        safe_connect(self, self.sys_side.clk, self.clk_sys)
        safe_connect(self, self.sys_side.rst_n, self.rst_sys_n)
        safe_connect(self, self.sys_side.dti_req, self.dti_req)
        safe_connect(self, self.sys_side.dti_rsp, self.dti_rsp)
        safe_connect(self, self.sys_side.req_twakeup, self.req_twakeup)
        safe_connect(self, self.sys_side.rsp_twakeup, self.rsp_twakeup)
        safe_connect(self, self.sys_side.timeout_val, self.timeout_val)
        safe_connect(self, self.sys_side.pchnl_ctrl, self.pchnl_ctrl)
        safe_connect(self, self.sys_side.async_fifo, self.async_fifo)
        safe_connect(self, self.sys_side.lp_top_tx, self.lp_top_tx)
        safe_connect(self, self.sys_side.lp_top_rx, self.lp_top_rx)

        self.expose_unconnected_interfaces()


class DtiTniuSysWrapNode(UhdlWrapperNode):
    def __init__(self, id: str, sys_cfg, node_name: str):
        super().__init__(id=id, module_name=f"{node_name}_sys_wrap")

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

        safe_connect(self, self.sys_side.clk, self.clk_sys)
        safe_connect(self, self.sys_side.rst_n, self.rst_sys_n)
        safe_connect(self, self.sys_side.dti_req, self.dti_req)
        safe_connect(self, self.sys_side.dti_rsp, self.dti_rsp)
        safe_connect(self, self.sys_side.req_twakeup, self.req_twakeup)
        safe_connect(self, self.sys_side.rsp_twakeup, self.rsp_twakeup)
        safe_connect(self, self.sys_side.pchnl_ctrl, self.pchnl_ctrl)
        safe_connect(self, self.sys_side.async_fifo, self.async_fifo)
        safe_connect(self, self.sys_side.lp_top_tx, self.lp_top_tx)
        safe_connect(self, self.sys_side.lp_top_rx, self.lp_top_rx)

        self.expose_unconnected_interfaces()

class DtiIniuNode(UhdlWrapperNode):
    def __init__(self, id: str, sys_cfg, top_cfg, node_name: str, route_base: int = 0,
                 clk_name="clk_noc", rst_name="rst_noc_n"):
        super().__init__(id=id)

        self.add_interface("clk_sys")
        self.add_interface("rst_sys_n")
        self.add_interface(clk_name, is_global=True)
        self.add_interface(rst_name, is_global=True)

        self.add_interface("dti_req")
        self.add_interface("dti_rsp")
        self.add_interface("req_twakeup")
        self.add_interface("rsp_twakeup")
        self.add_interface("timeout_val")
        self.add_interface("pchnl_ctrl")
        self.add_interface("top_req", r"^top_req_req_(valid|payload|last|srcid|tgtid|qos|threshold|ready)$")
        self.add_interface("top_rsp", r"^top_rsp_rsp_(valid|payload|last|srcid|tgtid|qos|threshold|ready)$")

        self.route_base = int(route_base)
        tid_width = _get_dti_param_width(top_cfg, "TID_WIDTH", 6)
        if self.route_base < 0:
            raise ValueError(f"route_base must be non-negative, got {self.route_base}")
        if self.route_base >= (1 << tid_width):
            raise ValueError(
                f"route_base {self.route_base} exceeds TID width {tid_width}; "
                "update the topology ID plan or widen the DTI route ID width first"
            )

        self.sys_wrap = DtiIniuSysWrapNode(id=f"{node_name}_sys_wrap", cfg=sys_cfg, node_name=node_name)
        self.top_wrap = DtiIniuTopWrapNode(
            id=f"{node_name}_top_wrap",
            top_cfg=top_cfg,
            node_name=node_name,
            route_base=self.route_base,
            clk_name=clk_name,
            rst_name=rst_name,
        )

        safe_connect(self, self.sys_wrap.clk_sys, self.clk_sys)
        safe_connect(self, self.sys_wrap.rst_sys_n, self.rst_sys_n)
        safe_connect(self, self.sys_wrap.dti_req, self.dti_req)
        safe_connect(self, self.sys_wrap.dti_rsp, self.dti_rsp)
        safe_connect(self, self.sys_wrap.req_twakeup, self.req_twakeup)
        safe_connect(self, self.sys_wrap.rsp_twakeup, self.rsp_twakeup)
        safe_connect(self, self.sys_wrap.timeout_val, self.timeout_val)
        safe_connect(self, self.sys_wrap.pchnl_ctrl, self.pchnl_ctrl)
        safe_connect(self, self.sys_wrap.async_fifo, self.top_wrap.async_fifo)
        safe_connect(self, self.sys_wrap.lp_top_tx, self.top_wrap.lp_top_rx)
        safe_connect(self, self.sys_wrap.lp_top_rx, self.top_wrap.lp_top_tx)

        safe_connect(self, getattr(self.top_wrap, clk_name), getattr(self, clk_name))
        safe_connect(self, getattr(self.top_wrap, rst_name), getattr(self, rst_name))

        safe_connect(self, self.top_wrap.top_req, self.top_req)
        safe_connect(self, self.top_wrap.top_rsp, self.top_rsp)

        self.expose_unconnected_interfaces()


class DtiTniuNode(UhdlWrapperNode):
    def __init__(self, id: str, sys_cfg, top_cfg, node_name: str, clk_name="clk_noc_up", rst_name="rst_noc_up_n"):
        super().__init__(id=id)

        self.add_interface("clk_sys")
        self.add_interface("rst_sys_n")
        self.add_interface(clk_name, is_global=True)
        self.add_interface(rst_name, is_global=True)

        self.add_interface("dti_req")
        self.add_interface("dti_rsp")
        self.add_interface("req_twakeup")
        self.add_interface("rsp_twakeup")
        self.add_interface("pchnl_ctrl")
        self.add_interface("top_req_data", r"^top_req_top_req_req_(valid|payload|last|srcid|tgtid|qos|threshold|ready)$")
        self.add_interface("top_rsp", r"^top_rsp_rsp_(valid|payload|last|srcid|tgtid|qos|threshold|ready)$")

        self.sys_wrap = DtiTniuSysWrapNode(id=f"{node_name}_sys_wrap", sys_cfg=sys_cfg, node_name=node_name)
        self.top_wrap = DtiTniuTopWrapNode(id=f"{node_name}_top_wrap", top_cfg=top_cfg, node_name=node_name, clk_name=clk_name, rst_name=rst_name)

        safe_connect(self, self.sys_wrap.clk_sys, self.clk_sys)
        safe_connect(self, self.sys_wrap.rst_sys_n, self.rst_sys_n)
        safe_connect(self, self.sys_wrap.dti_req, self.dti_req)
        safe_connect(self, self.sys_wrap.dti_rsp, self.dti_rsp)
        safe_connect(self, self.sys_wrap.req_twakeup, self.req_twakeup)
        safe_connect(self, self.sys_wrap.rsp_twakeup, self.rsp_twakeup)
        safe_connect(self, self.sys_wrap.pchnl_ctrl, self.pchnl_ctrl)
        safe_connect(self, self.sys_wrap.async_fifo, self.top_wrap.async_fifo)
        safe_connect(self, self.sys_wrap.lp_top_tx, self.top_wrap.lp_top_rx)
        safe_connect(self, self.sys_wrap.lp_top_rx, self.top_wrap.lp_top_tx)

        safe_connect(self, getattr(self.top_wrap, clk_name), getattr(self, clk_name))
        safe_connect(self, getattr(self.top_wrap, rst_name), getattr(self, rst_name))
        safe_connect(self, self.top_wrap.top_req_data, self.top_req_data)
        safe_connect(self, self.top_wrap.top_rsp, self.top_rsp)

        self.expose_unconnected_interfaces()


# ── Switch nodes ─────────────────────────────────────────────────────────

class DtiSwitchNode(UhdlComponentNode):
    # Per-N wrapper modules only accept these params (NUM_INIU/NUM_TNIU baked in)
    _WRAPPER_PARAMS = frozenset({'TID_WIDTH', 'PAYLOAD_WIDTH',
                                  'TNIU_DECMIN', 'TNIU_DECMAX',
                                  'INIU_DECMIN', 'INIU_DECMAX'})

    def __init__(self, id: str, cfg, top: str, input_count: int, clk_name="clk_noc", rst_name="rst_noc_n"):
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

        self.add_interface(clk_name, r"^clk$")
        self.add_interface(rst_name, r"^rst_n$")
        self.add_interface("tniu_req", r"^tniu_req_.*")
        self.add_interface("tniu_rsp", r"^tniu_rsp_.*")

        for idx in range(input_count):
            self.add_interface(f"iniu{idx}_req", rf"^iniu{idx}_req_.*")
            self.add_interface(f"iniu{idx}_rsp", rf"^iniu{idx}_rsp_.*")