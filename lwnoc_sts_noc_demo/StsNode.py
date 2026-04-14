import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
LWNOC_TOPO_ROOT = THIS_DIR.parent / "lwnoc_topo"
if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.node.uhdlComponentNode import UhdlComponentNode
from uhdl.uhdl.core.TemplateIP import TemplateComponent

from StsTemplate import (
    sts_demo_dec4_config,
    sts_demo_iniu_config,
    sts_demo_tniu0_config,
    sts_demo_tniu1_config,
    sts_demo_tniu2_config,
    sts_demo_tniu3_config,
)


class StsIniuNode(UhdlComponentNode):
    def __init__(self, id: str = "iniu0"):
        comp = TemplateComponent(config=sts_demo_iniu_config, top="sts_demo_iniu_wrap")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk_src", r"^clk_src$")
        self.add_interface("clk_dst", r"^clk_dst$")
        self.add_interface("rstn_src", r"^rstn_src$")
        self.add_interface("rstn_dst", r"^rstn_dst$")
        self.add_interface("node_id", r"^node_id$")
        self.add_interface("axi", r"^s_.*")
        self.add_interface("req", r"^out_req_.*")
        self.add_interface("rsp", r"^in_rsp_.*")


class StsDec4Node(UhdlComponentNode):
    def __init__(self, id: str = "noc_dec"):
        comp = TemplateComponent(config=sts_demo_dec4_config, top="sts_demo_dec4_wrap")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("mst_req", r"^mst_req_.*")
        self.add_interface("mst_rsp", r"^mst_rsp_.*")
        self.add_interface("slv0_req", r"^slv0_req_.*")
        self.add_interface("slv0_rsp", r"^slv0_rsp_.*")
        self.add_interface("slv1_req", r"^slv1_req_.*")
        self.add_interface("slv1_rsp", r"^slv1_rsp_.*")
        self.add_interface("slv2_req", r"^slv2_req_.*")
        self.add_interface("slv2_rsp", r"^slv2_rsp_.*")
        self.add_interface("slv3_req", r"^slv3_req_.*")
        self.add_interface("slv3_rsp", r"^slv3_rsp_.*")


class _BaseStsTniuNode(UhdlComponentNode):
    def __init__(self, id: str, cfg, top: str):
        comp = TemplateComponent(config=cfg, top=top)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk_src", r"^clk_src$")
        self.add_interface("clk_dst", r"^clk_dst$")
        self.add_interface("clk_dbg_timer", r"^clk_dbg_timer$")
        self.add_interface("rstn_src", r"^rstn_src$")
        self.add_interface("rstn_dst", r"^rstn_dst$")
        self.add_interface("rstn_dbg_timer", r"^rstn_dbg_timer$")
        self.add_interface("req", r"^in_req_.*")
        self.add_interface("rsp", r"^out_rsp_.*")
        self.add_interface("pmc_apb", r"^pmc_.*")
        self.add_interface("sys_apb", r"^m_.*")
        self.add_interface("dbg_data", r"^dbg_data_.*")
        self.add_interface("dbg_timestamp", r"^dbg_timestamp_.*")
        self.add_interface("sys_cti_event", r"^sys_cti_event_.*")
        self.add_interface("noc_cti_event", r"^noc_cti_event_.*")
        self.add_interface("sys_cti_channel", r"^sys_cti_channel_.*")
        self.add_interface("noc_cti_channel", r"^noc_cti_channel_.*")


class StsTniu0Node(_BaseStsTniuNode):
    def __init__(self, id: str = "tniu0"):
        super().__init__(id=id, cfg=sts_demo_tniu0_config, top="sts_demo_tniu0_wrap")


class StsTniu1Node(_BaseStsTniuNode):
    def __init__(self, id: str = "tniu1"):
        super().__init__(id=id, cfg=sts_demo_tniu1_config, top="sts_demo_tniu1_wrap")


class StsTniu2Node(_BaseStsTniuNode):
    def __init__(self, id: str = "tniu2"):
        super().__init__(id=id, cfg=sts_demo_tniu2_config, top="sts_demo_tniu2_wrap")


class StsTniu3Node(_BaseStsTniuNode):
    def __init__(self, id: str = "tniu3"):
        super().__init__(id=id, cfg=sts_demo_tniu3_config, top="sts_demo_tniu3_wrap")