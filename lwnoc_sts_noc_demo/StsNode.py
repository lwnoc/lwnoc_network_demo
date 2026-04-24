import sys
import tempfile
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
LWNOC_TOPO_ROOT = THIS_DIR.parent / "lwnoc_topo"
if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.node.uhdlComponentNode import UhdlComponentNode
from uhdl.uhdl.core import BitXor, Component, Input, Output, UInt
from uhdl.uhdl.core.TemplateIP import TemplateComponent, TemplateIPConfig
from uhdl.uhdl.core.VComponent import VComponent

from StsTemplate import (
    TGT_ID_WIDTH,
    sts_demo_dec4_config,
    sts_demo_iniu_top_side_config,
    sts_demo_link_buf_config,
    sts_demo_link_pipe_config,
    sts_demo_req_rsp_async_config,
    sts_demo_tniu0_config,
    sts_demo_tniu1_config,
    sts_demo_tniu2_config,
    sts_demo_tniu3_config,
)


sts_demo_req_rsp_async_raw_config = TemplateIPConfig(
    name="sts_req_rsp_async_raw",
    filelist=sts_demo_req_rsp_async_config.filelist,
    prefix="",
)


def _pack_int(width: int, values: list[int]) -> int:
    result = 0
    mask = (1 << width) - 1
    for value in values:
        result = (result << width) | (value & mask)
    return result


def _sv_param(total_bits: int, value: int) -> str:
    hex_digits = max(1, (total_bits + 3) // 4)
    return f"{total_bits}'h{value:0{hex_digits}X}"


class StsTopSideTemplateComponent(TemplateComponent):
    _pending_init: dict | None = None

    @classmethod
    def build(cls, config: TemplateIPConfig, top: str, instance: str | None = None, **kwargs):
        cls._pending_init = {
            "config": config,
            "top": top,
            "instance": instance,
            "kwargs": kwargs,
        }
        try:
            return cls()
        finally:
            cls._pending_init = None

    def __init__(self):
        pending = self.__class__._pending_init
        if pending is None:
            raise RuntimeError("StsTopSideTemplateComponent.build() must be used")

        config: TemplateIPConfig = pending["config"]
        top: str = pending["top"]
        instance: str | None = pending["instance"]
        kwargs = dict(pending["kwargs"])

        self._parent_template = config.get_or_create_ip()
        self._parent_template.temp_build()

        if instance is None:
            instance = top

        unity_wrapper_path = self._build_parse_unity_wrapper(config=config, top=top)
        prefixed_top = config.prefix + top

        VComponent.__init__(
            self,
            file=unity_wrapper_path,
            top=prefixed_top,
            instance=instance,
            struct_mode="packed",
            **kwargs,
        )

    def _build_parse_unity_wrapper(self, config: TemplateIPConfig, top: str) -> str:
        top_side_dir = Path(self._parent_template.temp_output_dir)
        wrapper_file = top_side_dir / f"{config.prefix}{top}.sv"

        top_side_name = config.name
        pack_dir_name = top_side_name.removesuffix("_top_side")
        pack_dir = top_side_dir.parent / pack_dir_name
        pack_file = pack_dir / f"{config.prefix}lwnoc_sts_pack.sv"

        if not wrapper_file.exists() or not pack_file.exists():
            return self._parent_template.get_unity_wrapper()

        scratch_dir = Path(tempfile.mkdtemp(prefix=f"{config.name}_parse_"))
        unity_wrapper = scratch_dir / f"{config.prefix}manual_unity_wrapper.sv"
        unity_wrapper.write_text(
            "\n".join(
                [
                    f'`include "{pack_file}"',
                    f'`include "{wrapper_file}"',
                    "",
                ]
            )
        )
        return str(unity_wrapper)


class StsReqSinkComponent(Component):
    def __init__(self, payload_width: int = 119):
        self._payload_width = payload_width
        super().__init__()

    def circuit(self):
        self.req_vld = Input(UInt(1))
        self.req_rdy = Output(UInt(1))
        self.req_pld = Input(UInt(self._payload_width))
        self.req_rdy += UInt(1, 1)


class StsReqSinkNode(UhdlComponentNode):
    def __init__(self, id: str = "sts_req_sink", payload_width: int = 119):
        comp = StsReqSinkComponent(payload_width=payload_width)
        super().__init__(id=id, impl=comp)

        self.add_interface("req", r"^req_(vld|rdy|pld)$")


class StsReqZeroSourceComponent(Component):
    def __init__(self, payload_width: int = 119):
        self._payload_width = payload_width
        super().__init__()

    def circuit(self):
        self.req_vld = Output(UInt(1))
        self.req_rdy = Input(UInt(1))
        self.req_pld = Output(UInt(self._payload_width))
        self.req_vld += BitXor(UInt(1, 1), UInt(1, 1))
        self.req_pld += BitXor(UInt(self._payload_width, 1), UInt(self._payload_width, 1))


class StsReqZeroSourceNode(UhdlComponentNode):
    def __init__(self, id: str = "sts_req_zero_source", payload_width: int = 119):
        comp = StsReqZeroSourceComponent(payload_width=payload_width)
        super().__init__(id=id, impl=comp)

        self.add_interface("req", r"^req_(vld|rdy|pld)$")


class StsReqRspAsyncBridgeSlvNode(UhdlComponentNode):
    def __init__(self, id: str = "sts_req_rsp_async_slv"):
        comp = TemplateComponent(
            config=sts_demo_req_rsp_async_raw_config,
            top="sts_async_bridge_slv",
            DATA_WIDTH=119,
        )
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("s_chan", r"^in_req_(vld|rdy|pld)$")
        self.add_interface("sync", r"^(wptr_async|rptr_async|rptr_sync|pld_sync)$")


class StsReqRspAsyncBridgeMstNode(UhdlComponentNode):
    def __init__(self, id: str = "sts_req_rsp_async_mst"):
        comp = TemplateComponent(
            config=sts_demo_req_rsp_async_raw_config,
            top="sts_async_bridge_mst",
            DATA_WIDTH=119,
        )
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("m_chan", r"^out_rsp_(vld|rdy|pld)$")
        self.add_interface("sync", r"^(wptr_async|rptr_async|rptr_sync|pld_sync)$")


class StsLinkPipeNode(UhdlComponentNode):
    def __init__(self, id: str = "sts_link_pipe"):
        comp = TemplateComponent(config=sts_demo_link_pipe_config, top="sts_link_pipe")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("s_chan", r"^in_req_(vld|rdy|pld)$")
        self.add_interface("m_chan", r"^out_req_(vld|rdy|pld)$")


class StsLinkBufNode(UhdlComponentNode):
    def __init__(self, id: str = "sts_link_buf"):
        comp = TemplateComponent(config=sts_demo_link_buf_config, top="sts_link_buf")
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("s_chan", r"^in_req_(vld|rdy|pld)$")
        self.add_interface("m_chan", r"^out_req_(vld|rdy|pld)$")
        self.add_interface("ctrl", r"^(stall|clear|idle|almost_full|almost_empty|empty|full)$")


class StsIniuNode(UhdlComponentNode):
    def __init__(self, id: str = "iniu0"):
        params = getattr(sts_demo_iniu_top_side_config, 'param_overrides', {})
        comp = StsTopSideTemplateComponent.build(config=sts_demo_iniu_top_side_config, top="sts_demo_iniu_wrap", **params)
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
    def __init__(self, id: str = "noc_dec", slave_num: int = 4):
        if slave_num < 1 or slave_num > 4:
            raise ValueError(f"slave_num must be in [1, 4], got {slave_num}")

        params = dict(getattr(sts_demo_dec4_config, 'param_overrides', {}))
        # Keep decode policy consistent with existing 4-way table while allowing
        # fewer active slave channels for leaf-count-matched dec instances.
        route_base_values = [0x30, 0x20, 0x10, 0x00][-slave_num:]
        route_mask_values = [0xB0] * slave_num
        route_base_int = _pack_int(TGT_ID_WIDTH, route_base_values)
        route_mask_int = _pack_int(TGT_ID_WIDTH, route_mask_values)
        params.update(
            {
                "STS_DEMO_DEC_SLAVE_NUM": slave_num,
                "STS_DEMO_ROUTE_BASE": _sv_param(slave_num * TGT_ID_WIDTH, route_base_int),
                "STS_DEMO_ROUTE_MASK": _sv_param(slave_num * TGT_ID_WIDTH, route_mask_int),
            }
        )

        comp = TemplateComponent(config=sts_demo_dec4_config, top="sts_demo_dec4_wrap", struct_mode="packed", **params)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("mst_req", r"^mst_req_.*")
        self.add_interface("mst_rsp", r"^mst_rsp_.*")
        if slave_num >= 1:
            self.add_interface("slv0_req", r"^slv0_req_.*")
            self.add_interface("slv0_rsp", r"^slv0_rsp_.*")
        if slave_num >= 2:
            self.add_interface("slv1_req", r"^slv1_req_.*")
            self.add_interface("slv1_rsp", r"^slv1_rsp_.*")
        if slave_num >= 3:
            self.add_interface("slv2_req", r"^slv2_req_.*")
            self.add_interface("slv2_rsp", r"^slv2_rsp_.*")
        if slave_num >= 4:
            self.add_interface("slv3_req", r"^slv3_req_.*")
            self.add_interface("slv3_rsp", r"^slv3_rsp_.*")


class _BaseStsTniuNode(UhdlComponentNode):
    def __init__(self, id: str, cfg, top: str):
        params = getattr(cfg, 'param_overrides', {})
        comp = StsTopSideTemplateComponent.build(config=cfg, top=top, **params)
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


STS_TNIU_NODE_TYPES = (
    StsTniu0Node,
    StsTniu1Node,
    StsTniu2Node,
    StsTniu3Node,
)


def make_sts_tniu_node(tniu_idx: int, id: str | None = None) -> _BaseStsTniuNode:
    node_type = STS_TNIU_NODE_TYPES[tniu_idx]
    return node_type(id=id or f"tniu{tniu_idx}")