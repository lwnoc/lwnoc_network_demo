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

from DtiTemplate import (
    iniu_top_config,
    npu_iniu_sys_config,
    tcu_tniu_sys_config,
    tniu_top_config,
    vpu_iniu_sys_config,
)


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


class DtiIniuSysNode(UhdlComponentNode):
    def __init__(self, id: str, cfg):
        comp = TemplateComponent(config=cfg, top="dti_pr_iniu_async_sys_side")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", "clk")
        self.add_interface("rst_n", "rst_n")
        self.add_interface("dti_req", r"req_t(valid|data|keep|last|tid|ready)")
        self.add_interface("dti_rsp", r"rsp_t(valid|data|keep|last|tid|ready)")
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


class DtiIniuNode(UhdlWrapperNode):
    def __init__(self, id: str, sys_cfg, node_name: str):
        super().__init__(id=id)

        self.add_interface("clk_sys")
        self.add_interface("rst_sys_n")
        self.add_interface("clk_top", is_global=True)
        self.add_interface("rst_top_n", is_global=True)

        self.add_interface("dti_req")
        self.add_interface("dti_rsp")
        self.add_interface("timeout_val")
        self.add_interface("pchnl_ctrl")
        self.add_interface("top_req")
        self.add_interface("top_rsp")

        self.sys_side = DtiIniuSysNode(id=f"{node_name}_sys_side", cfg=sys_cfg)
        self.top_side = DtiIniuTopNode(id=f"{node_name}_top_side")

        connect(self.sys_side.clk, self.clk_sys)
        connect(self.sys_side.rst_n, self.rst_sys_n)
        connect(self.sys_side.dti_req, self.dti_req)
        connect(self.sys_side.dti_rsp, self.dti_rsp)
        connect(self.sys_side.timeout_val, self.timeout_val)
        connect(self.sys_side.pchnl_ctrl, self.pchnl_ctrl)
        connect(self.sys_side.async_fifo, self.top_side.async_fifo)
        connect(self.sys_side.lp_top_tx, self.top_side.lp_top_rx)
        connect(self.sys_side.lp_top_rx, self.top_side.lp_top_tx)

        connect(self.top_side.clk, self.clk_top)
        connect(self.top_side.rst_n, self.rst_top_n)
        connect(self.top_side.top_req, self.top_req)
        connect(self.top_side.top_rsp, self.top_rsp)

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
        self.add_interface("pchnl_ctrl")
        self.add_interface("top_req")
        self.add_interface("top_rsp")

        self.sys_side = DtiTniuSysNode(id=f"{node_name}_sys_side")
        self.top_side = DtiTniuTopNode(id=f"{node_name}_top_side")

        connect(self.sys_side.clk, self.clk_sys)
        connect(self.sys_side.rst_n, self.rst_sys_n)
        connect(self.sys_side.dti_req, self.dti_req)
        connect(self.sys_side.dti_rsp, self.dti_rsp)
        connect(self.sys_side.pchnl_ctrl, self.pchnl_ctrl)
        connect(self.sys_side.async_fifo, self.top_side.async_fifo)
        connect(self.sys_side.lp_top_tx, self.top_side.lp_top_rx)
        connect(self.sys_side.lp_top_rx, self.top_side.lp_top_tx)

        connect(self.top_side.clk, self.clk_top)
        connect(self.top_side.rst_n, self.rst_top_n)
        connect(self.top_side.top_req, self.top_req)
        connect(self.top_side.top_rsp, self.top_rsp)

        self.expose_unconnected_interfaces()


def make_npu_iniu_node(id: str = "sys_npu_iniu_node") -> DtiIniuNode:
    return DtiIniuNode(id=id, sys_cfg=npu_iniu_sys_config, node_name="sys_npu_iniu")


def make_vpu_iniu_node(id: str = "sys_vpu_iniu_node") -> DtiIniuNode:
    return DtiIniuNode(id=id, sys_cfg=vpu_iniu_sys_config, node_name="sys_vpu_iniu")


def make_tcu_tniu_node(id: str = "sys_tcu_tniu_node") -> DtiTniuNode:
    return DtiTniuNode(id=id, node_name="sys_tcu_tniu")