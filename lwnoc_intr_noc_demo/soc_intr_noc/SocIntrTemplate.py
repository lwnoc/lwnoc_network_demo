"""TemplateIPConfig definitions for the SoC-scale interrupt ring NoC demo."""

import os
import re
import shutil
import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parents[1]
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"
INTR_NOC_ROOT = REPO_ROOT / "subs" / "lwnoc_interrupt_noc"
RING_NETWORK_ROOT = REPO_ROOT / "subs" / "lwnoc_ring_network" / "de" / "rtl"

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from uhdl.uhdl.core.TemplateIP import TemplateIPConfig


os.environ["INTR_NOC_DIR"] = str(INTR_NOC_ROOT)
os.environ["INTR_NOC_STANDALONE_DIR"] = "/home/lgzhu/dev/noc_work/lwnoc_interrupt_noc"
os.environ["INTR_NOC_DEMO_DIR"] = str(THIS_DIR)
os.environ["INTR_NOC_NETWORK_DIR"] = str(RING_NETWORK_ROOT)
os.environ["FCIP_DIR"] = str(INTR_NOC_ROOT / "fcip")
os.environ["LWNOC_LOWPOWER_COMPONENT"] = str(INTR_NOC_ROOT / "lwnoc_lowpower_component")


FILELIST_DIR = THIS_DIR / "filelist"
TEMP_MACRO_YAML_DIR = THIS_DIR / "build" / "temp" / "macro_yaml"
USE_SUBS_VC_FILELIST_MODE = os.environ.get("SOC_INTR_USE_SUBS_VC_FILELIST", "1") == "1"

INIU_SYS_MACRO_YAML = str(FILELIST_DIR / "intr_iniu_sys_macros.yaml")
TNIU_SYS_MACRO_YAML = str(FILELIST_DIR / "intr_tniu_sys_macros.yaml")
INIU_TOP_MACRO_YAML = str(FILELIST_DIR / "intr_iniu_top_macros.yaml")
TNIU_TOP_MACRO_YAML = str(FILELIST_DIR / "intr_tniu_top_macros.yaml")
RING_NETWORK_MACRO_YAML = str(FILELIST_DIR / "intr_ring_network_macros.yaml")
RING_BUF_MACRO_YAML = str(FILELIST_DIR / "intr_ring_buf_macros.yaml")
RING_REQ_SINK_MACRO_YAML = str(FILELIST_DIR / "intr_ring_req_sink_macros.yaml")
RING_REQ_ZERO_SOURCE_MACRO_YAML = str(FILELIST_DIR / "intr_ring_req_zero_source_macros.yaml")


def _macro_yaml_with_node_prefix(node_name: str, shared_macro_yaml: str) -> str:
    source = Path(shared_macro_yaml)
    macro_owner = node_name.removesuffix("_iniu").removesuffix("_tniu")
    TEMP_MACRO_YAML_DIR.mkdir(parents=True, exist_ok=True)
    prefixed = TEMP_MACRO_YAML_DIR / f"{macro_owner}_{source.name}"
    if not prefixed.exists() or prefixed.read_text(encoding="utf-8") != source.read_text(encoding="utf-8"):
        shutil.copyfile(source, prefixed)
    return str(prefixed)


def _effective_prefix(prefix: str, filelist_name: str) -> str:
    if not USE_SUBS_VC_FILELIST_MODE:
        return prefix
    plain_lists = {
        "intr_iniu_top.f",
        "intr_tniu_top.f",
        "intr_ring_network_wrap.f",
        "intr_ring_buf_wrap.f",
        "intr_ring_station.f",
        "intr_ring_link.f",
        "intr_ring_req_sink.f",
        "intr_ring_req_zero_source.f",
    }
    if filelist_name in plain_lists:
        return ""

    # Keep sys-side naming source-owned: per-ss TemplateIP prefixes should be
    # applied by ip_builder at generation time (memnoc-style flow).
    return prefix


INIU_NODE_NAMES = [
    "cpu_ss_iniu",
    "ucie_ss0_iniu",
    "audio_ss_iniu",
    "gpu_ss1_iniu",
    "dp_ss_iniu",
    "ddr6_iniu",
    "ddr7_iniu",
    "ddr8_iniu",
    "ddr9_iniu",
    "ddr10_iniu",
    "mipi_ss_iniu",
    "ufs_ss_iniu",
    "camera_ss_iniu",
    "vpu_ss_iniu",
    "debug_ss_iniu",
    "aon_ss_iniu",
    "ucie_ss1_iniu",
    "dspss5_iniu",
    "dspss3_iniu",
    "dspss1_iniu",
    "ddr0_iniu",
    "ddr1_iniu",
    "ddr2_iniu",
    "ddr3_iniu",
    "ddr4_iniu",
    "ddr5_iniu",
    "pcie_eth_ss_iniu",
]

TNIU_NODE_NAMES = [
    "cpu_ss_tniu",
    "ucie_ss0_tniu",
    "peri_ss_tniu",
    "gpu_ss0_tniu",
    "display_ss_tniu",
    "ddr11_tniu",
    "camera_ss_tniu",
    "aon_ss_tniu",
    "ucie_ss1_tniu",
    "dspss0_tniu",
    "dspss2_tniu",
    "dspss4_tniu",
]

INIU_ASYNC_FIFO_DEPTH = 16
TNIU_ASYNC_FIFO_DEPTH = 10
SOC_INTR_RING_NODE_NUM = len(INIU_NODE_NAMES) + len(TNIU_NODE_NAMES)
SOC_INTR_REQ_PLD_WIDTH = 40
SOC_INTR_REQ_ID_WIDTH = 8
SOC_INTR_REQ_QOS_WIDTH = 4


def _new_cfg(name: str, prefix: str, filelist_name: str, env_var: str) -> TemplateIPConfig:
    return TemplateIPConfig(
        name=name,
        prefix=_effective_prefix(prefix, filelist_name),
        filelist=str(FILELIST_DIR / filelist_name),
        env_var=env_var,
    )


def _to_env_token(node_name: str) -> str:
    return node_name.upper().replace("-", "_")


def _shared_sys_name(node_name: str) -> str:
    for suffix in ("_iniu", "_tniu"):
        if node_name.endswith(suffix):
            stem = node_name[: -len(suffix)]
            if "_" in stem:
                head, tail = stem.rsplit("_", 1)
                tail = re.sub(r"\d+$", "", tail)
                stem = f"{head}_{tail}"
            else:
                stem = re.sub(r"\d+$", "", stem)
            return f"{stem}{suffix}"
    return node_name


def _new_shared_sys_cfg(shared_name: str, filelist_name: str, macro_yaml: str, async_fifo_depth: int) -> TemplateIPConfig:
    cfg = _new_cfg(
        name=f"{shared_name}_sys",
        prefix=f"{shared_name}_",
        filelist_name=filelist_name,
        env_var=f"SOC_INTR_{_to_env_token(shared_name)}_SYS_OUT_DIR",
    )
    cfg.set_macro("ASYNC_FIFO_DEPTH", async_fifo_depth)
    cfg.macro_yaml = _macro_yaml_with_node_prefix(shared_name, macro_yaml)
    return cfg


INIU_SYS_CONFIGS: dict[str, TemplateIPConfig] = {}
_shared_iniu_sys_cfgs: dict[str, TemplateIPConfig] = {}
for node_name in INIU_NODE_NAMES:
    shared_name = _shared_sys_name(node_name)
    cfg = _shared_iniu_sys_cfgs.get(shared_name)
    if cfg is None:
        cfg = _new_shared_sys_cfg(
            shared_name=shared_name,
            filelist_name="intr_iniu_sys.f",
            macro_yaml=INIU_SYS_MACRO_YAML,
            async_fifo_depth=INIU_ASYNC_FIFO_DEPTH,
        )
        _shared_iniu_sys_cfgs[shared_name] = cfg
    INIU_SYS_CONFIGS[node_name] = cfg


TNIU_SYS_CONFIGS: dict[str, TemplateIPConfig] = {}
_shared_tniu_sys_cfgs: dict[str, TemplateIPConfig] = {}
for node_name in TNIU_NODE_NAMES:
    shared_name = _shared_sys_name(node_name)
    cfg = _shared_tniu_sys_cfgs.get(shared_name)
    if cfg is None:
        cfg = _new_shared_sys_cfg(
            shared_name=shared_name,
            filelist_name="intr_tniu_sys.f",
            macro_yaml=TNIU_SYS_MACRO_YAML,
            async_fifo_depth=TNIU_ASYNC_FIFO_DEPTH,
        )
        _shared_tniu_sys_cfgs[shared_name] = cfg
    TNIU_SYS_CONFIGS[node_name] = cfg


soc_intr_iniu_top_config = _new_cfg(
    name="intr_iniu_top_side",
    prefix="intr_iniu_top_",
    filelist_name="intr_iniu_top.f",
    env_var="INTR_INIU_TOP_OUT_DIR",
)
soc_intr_iniu_top_config.set_macro("ASYNC_FIFO_DEPTH", INIU_ASYNC_FIFO_DEPTH)
soc_intr_iniu_top_config.macro_yaml = INIU_TOP_MACRO_YAML

soc_intr_tniu_top_config = _new_cfg(
    name="intr_tniu_top_side",
    prefix="intr_tniu_top_",
    filelist_name="intr_tniu_top.f",
    env_var="INTR_TNIU_TOP_OUT_DIR",
)
soc_intr_tniu_top_config.set_macro("ASYNC_FIFO_DEPTH", TNIU_ASYNC_FIFO_DEPTH)
soc_intr_tniu_top_config.macro_yaml = TNIU_TOP_MACRO_YAML

soc_intr_ring_network_config = _new_cfg(
    name="intr_ring_network",
    prefix="intr_ring_network_",
    filelist_name="intr_ring_network_wrap.f",
    env_var="INTR_RING_NETWORK_OUT_DIR",
)
soc_intr_ring_network_config.set_macro("PLD_WIDTH", SOC_INTR_REQ_PLD_WIDTH)
soc_intr_ring_network_config.set_macro("ID_WIDTH", SOC_INTR_REQ_ID_WIDTH)
soc_intr_ring_network_config.set_macro("QOS_WIDTH", SOC_INTR_REQ_QOS_WIDTH)
soc_intr_ring_network_config.set_macro("NODE_NUM", SOC_INTR_RING_NODE_NUM)
soc_intr_ring_network_config.macro_yaml = RING_NETWORK_MACRO_YAML

soc_intr_ring_buf_config = _new_cfg(
    name="intr_ring_buf",
    prefix="",
    filelist_name="intr_ring_buf_wrap.f",
    env_var="INTR_RING_BUF_OUT_DIR",
)
soc_intr_ring_buf_config.set_macro("NODE_NUM", SOC_INTR_RING_NODE_NUM)
soc_intr_ring_buf_config.macro_yaml = RING_BUF_MACRO_YAML

soc_intr_ring_station_config = _new_cfg(
    name="intr_ring_station",
    prefix="intr_ring_station_",
    filelist_name="intr_ring_station.f",
    env_var="INTR_RING_STATION_OUT_DIR",
)

soc_intr_ring_link_config = _new_cfg(
    name="intr_ring_link",
    prefix="intr_ring_link_",
    filelist_name="intr_ring_link.f",
    env_var="INTR_RING_LINK_OUT_DIR",
)

soc_intr_ring_req_sink_config = _new_cfg(
    name="intr_ring_req_sink",
    prefix="",
    filelist_name="intr_ring_req_sink.f",
    env_var="INTR_RING_REQ_SINK_OUT_DIR",
)
soc_intr_ring_req_sink_config.set_macro("NODE_NUM", SOC_INTR_RING_NODE_NUM)
soc_intr_ring_req_sink_config.macro_yaml = RING_REQ_SINK_MACRO_YAML

soc_intr_ring_req_zero_source_config = _new_cfg(
    name="intr_ring_req_zero_source",
    prefix="",
    filelist_name="intr_ring_req_zero_source.f",
    env_var="INTR_RING_REQ_ZERO_SOURCE_OUT_DIR",
)
soc_intr_ring_req_zero_source_config.set_macro("NODE_NUM", SOC_INTR_RING_NODE_NUM)
soc_intr_ring_req_zero_source_config.macro_yaml = RING_REQ_ZERO_SOURCE_MACRO_YAML