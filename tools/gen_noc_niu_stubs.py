#!/usr/bin/env python3

from __future__ import annotations

import argparse
import importlib
import json
import re
import sys
from dataclasses import dataclass
from pathlib import Path
from typing import Any


REPO_ROOT = Path(__file__).resolve().parent.parent
BUILD_DIR = REPO_ROOT / "build" / "niu_stub_views"
TEMP_RESOLVED_FILELIST_DIR = REPO_ROOT / "build" / "temp" / "niu_stub_views_filelists"

KNOWN_PORT_WIDTH_SUFFIXES: tuple[tuple[str, int], ...] = (
    ("pstate", 3),
    ("pactive", 2),
    ("lp_req", 7),
    ("lp_hub_rx_req", 7),
    ("lp_hub_tx_req", 7),
)


@dataclass(frozen=True)
class StubSpec:
    noc: str
    category: str
    template_module: str
    config_attr: str
    top_module: str
    extra_sys_paths: tuple[Path, ...] = ()
    fallback_build_dir: Path | None = None
    fallback_top_module: str | None = None

    @property
    def stub_module_name(self) -> str:
        return f"{self.noc}_{self.category}_stub"

    @property
    def file_name(self) -> str:
        return f"{self.stub_module_name}.sv"


SPECS: tuple[StubSpec, ...] = (
    StubSpec(
        noc="sts",
        category="iniu_sys_side",
        template_module="StsTemplate",
        config_attr="aon_ss_iniu_sys_config",
        top_module="sts_iniu_sys",
        extra_sys_paths=(REPO_ROOT / "lwnoc_sts_noc_demo",),
        fallback_build_dir=REPO_ROOT / "lwnoc_sts_noc_demo" / "build_logic" / "aon_ss_iniu_sys",
        fallback_top_module="sts_iniu_sys",
    ),
    StubSpec(
        noc="sts",
        category="iniu_top_side",
        template_module="StsTemplate",
        config_attr="aon_ss_iniu_top_side_config",
        top_module="sts_iniu_noc",
        extra_sys_paths=(REPO_ROOT / "lwnoc_sts_noc_demo",),
        fallback_build_dir=REPO_ROOT / "lwnoc_sts_noc_demo" / "build_logic" / "aon_ss_iniu_top_side",
        fallback_top_module="sts_iniu_noc",
    ),
    StubSpec(
        noc="sts",
        category="tniu_sys_side",
        template_module="StsTemplate",
        config_attr="STS_SOC_TNIU_SYS_CONFIGS.ddrss0",
        top_module="sts_tniu_sys",
        extra_sys_paths=(REPO_ROOT / "lwnoc_sts_noc_demo",),
        fallback_build_dir=REPO_ROOT / "lwnoc_sts_noc_demo" / "build_logic" / "ddrss0_tniu_sys",
        fallback_top_module="sts_tniu_sys",
    ),
    StubSpec(
        noc="sts",
        category="tniu_top_side",
        template_module="StsTemplate",
        config_attr="STS_SOC_TNIU_TOP_CONFIGS.ddrss0",
        top_module="sts_tniu_noc",
        extra_sys_paths=(REPO_ROOT / "lwnoc_sts_noc_demo",),
        fallback_build_dir=REPO_ROOT / "lwnoc_sts_noc_demo" / "build_logic" / "ddrss0_tniu_top_side",
        fallback_top_module="sts_tniu_noc",
    ),
    StubSpec(
        noc="intr",
        category="iniu_sys_side",
        template_module="SocIntrTemplate",
        config_attr="cpu_ss_iniu_cfg",
        top_module="interrupt_iniu_async_sys_side",
        extra_sys_paths=(REPO_ROOT / "lwnoc_intr_noc_demo" / "soc_intr_noc",),
        fallback_build_dir=REPO_ROOT / "lwnoc_intr_noc_demo" / "soc_intr_noc" / "build_logic" / "audio_ss_iniu_sys",
        fallback_top_module="audio_ss_iniu_interrupt_iniu_async_sys_side",
    ),
    StubSpec(
        noc="intr",
        category="iniu_top_side",
        template_module="SocIntrTemplate",
        config_attr="soc_intr_iniu_top_config",
        top_module="interrupt_iniu_async_top_side",
        extra_sys_paths=(REPO_ROOT / "lwnoc_intr_noc_demo" / "soc_intr_noc",),
        fallback_build_dir=REPO_ROOT / "lwnoc_intr_noc_demo" / "soc_intr_noc" / "build_logic" / "audio_ss_iniu_sys",
        fallback_top_module="audio_ss_iniu_interrupt_iniu_async_top_side",
    ),
    StubSpec(
        noc="intr",
        category="tniu_sys_side",
        template_module="SocIntrTemplate",
        config_attr="cpu_ss_tniu_cfg",
        top_module="interrupt_tniu_async_sys_side",
        extra_sys_paths=(REPO_ROOT / "lwnoc_intr_noc_demo" / "soc_intr_noc",),
        fallback_build_dir=REPO_ROOT / "lwnoc_intr_noc_demo" / "soc_intr_noc" / "build_logic" / "display_ss_tniu_sys",
        fallback_top_module="display_ss_tniu_interrupt_tniu_async_sys_side",
    ),
    StubSpec(
        noc="intr",
        category="tniu_top_side",
        template_module="SocIntrTemplate",
        config_attr="soc_intr_tniu_top_config",
        top_module="interrupt_tniu_async_top_side",
        extra_sys_paths=(REPO_ROOT / "lwnoc_intr_noc_demo" / "soc_intr_noc",),
        fallback_build_dir=REPO_ROOT / "lwnoc_intr_noc_demo" / "soc_intr_noc" / "build_logic" / "display_ss_tniu_sys",
        fallback_top_module="display_ss_tniu_interrupt_tniu_async_top_side",
    ),
    StubSpec(
        noc="dti",
        category="iniu_sys_side",
        template_module="DtiTemplate",
        config_attr="gpu_iniu_sys_config",
        top_module="dti_pr_iniu_async_sys_side",
        extra_sys_paths=(REPO_ROOT / "soc_dti_noc_demo",),
        fallback_build_dir=REPO_ROOT / "soc_dti_noc_demo" / "build_logic" / "pcie_eth_iniu_sys",
        fallback_top_module="pcie_eth_dti_pr_iniu_async_sys_side",
    ),
    StubSpec(
        noc="dti",
        category="iniu_top_side",
        template_module="DtiTemplate",
        config_attr="gpu_iniu_sys_config",
        top_module="dti_pr_iniu_async_top_side",
        extra_sys_paths=(REPO_ROOT / "soc_dti_noc_demo",),
        fallback_build_dir=None,
        fallback_top_module=None,
    ),
    StubSpec(
        noc="dti",
        category="tniu_sys_side",
        template_module="DtiTemplate",
        config_attr="tcu_tniu_sys_config",
        top_module="dti_tniu_async_sys_side",
        extra_sys_paths=(REPO_ROOT / "soc_dti_noc_demo",),
        fallback_build_dir=REPO_ROOT / "soc_dti_noc_demo" / "build_logic" / "sys_tcu_tniu_sys",
        fallback_top_module="sys_tcu_dti_tniu_async_sys_side",
    ),
    StubSpec(
        noc="dti",
        category="tniu_top_side",
        template_module="DtiTemplate",
        config_attr="tcu_tniu_sys_config",
        top_module="dti_tniu_async_top_side",
        extra_sys_paths=(REPO_ROOT / "soc_dti_noc_demo",),
        fallback_build_dir=None,
        fallback_top_module=None,
    ),
    StubSpec(
        noc="atb",
        category="iniu_sys_side",
        template_module="AtbTemplate",
        config_attr="aon_iniu_cfg",
        top_module="atb_iniu_sys",
        extra_sys_paths=(REPO_ROOT / "soc_atb_noc",),
        fallback_build_dir=None,
        fallback_top_module=None,
    ),
    StubSpec(
        noc="atb",
        category="iniu_top_side",
        template_module="AtbTemplate",
        config_attr="aon_iniu_noc_cfg",
        top_module="atb_iniu_noc",
        extra_sys_paths=(REPO_ROOT / "soc_atb_noc",),
        fallback_build_dir=None,
        fallback_top_module="atb_iniu_noc",
    ),
    StubSpec(
        noc="atb",
        category="tniu_sys_side",
        template_module="AtbTemplate",
        config_attr="debug_tniu_cfg",
        top_module="atb_tniu_sys",
        extra_sys_paths=(REPO_ROOT / "soc_atb_noc",),
        fallback_build_dir=None,
        fallback_top_module=None,
    ),
    StubSpec(
        noc="atb",
        category="tniu_top_side",
        template_module="AtbTemplate",
        config_attr="debug_tniu_noc_cfg",
        top_module="atb_tniu_noc",
        extra_sys_paths=(REPO_ROOT / "soc_atb_noc",),
        fallback_build_dir=None,
        fallback_top_module="atb_tniu_noc",
    ),
    # ── Top-level aggregation wrapper stubs ────────────────────────────
    StubSpec(
        noc="atb",
        category="soc_top_wrap",
        template_module="AtbTemplate",
        config_attr="atb_top_wrap_config",
        top_module="_unused_",
        extra_sys_paths=(REPO_ROOT / "soc_atb_noc",),
        fallback_build_dir=REPO_ROOT / "soc_atb_noc" / "build_logic" / "atb_soc_top_wrap",
        fallback_top_module="atb_soc_top_wrap",
    ),
    StubSpec(
        noc="sts",
        category="soc_top_wrap",
        template_module="StsTemplate",
        config_attr="aon_ss_iniu_sys_config",
        top_module="_unused_",
        extra_sys_paths=(REPO_ROOT / "lwnoc_sts_noc_demo",),
        fallback_build_dir=REPO_ROOT / "lwnoc_sts_noc_demo" / "build_logic" / "sts_soc_top_wrap",
        fallback_top_module="sts_soc_top_wrap",
    ),
    StubSpec(
        noc="intr",
        category="ring_top_wrap",
        template_module="SocIntrTemplate",
        config_attr="cpu_ss_iniu_cfg",
        top_module="_unused_",
        extra_sys_paths=(REPO_ROOT / "lwnoc_intr_noc_demo" / "soc_intr_noc",),
        fallback_build_dir=REPO_ROOT / "lwnoc_intr_noc_demo" / "soc_intr_noc" / "build_logic" / "ring_top_wrap",
        fallback_top_module="ring_top_wrap",
    ),
)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Generate review-only NIU boundary stubs with fully expanded vector widths."
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        default=BUILD_DIR,
        help=f"Output directory for generated stub views (default: {BUILD_DIR}).",
    )
    return parser.parse_args()


def bootstrap_paths() -> None:
    base_paths = [
        REPO_ROOT,
        REPO_ROOT / "lwnoc_topo",
        REPO_ROOT / "lwnoc_sts_noc_demo",
        REPO_ROOT / "lwnoc_intr_noc_demo",
        REPO_ROOT / "soc_dti_noc_demo",
        REPO_ROOT / "soc_atb_noc",
    ]
    for path in base_paths:
        path_str = str(path)
        if path_str not in sys.path:
            sys.path.insert(0, path_str)


def patch_port_widths() -> None:
    try:
        from lwnoc_sts_noc_demo.tools.vport_width_patch import patch_vport_width
        patch_vport_width()
    except ModuleNotFoundError:
        pass  # optional post-generation width fixup; run after adding module

def _resolve_attr(obj, part: str):
    """Resolve part from obj: dict key or attribute."""
    if isinstance(obj, dict):
        return obj[part]
    return getattr(obj, part)


def load_config(spec: StubSpec) -> Any:
    for path in spec.extra_sys_paths:
        path_str = str(path)
        if path_str not in sys.path:
            sys.path.insert(0, path_str)

    module = importlib.import_module(spec.template_module)
    attr = spec.config_attr
    if "." in attr:
        obj: Any = module
        for part in attr.split("."):
            obj = _resolve_attr(obj, part)
        return obj
    return getattr(module, attr)


def resolve_build_filelist(spec: StubSpec) -> Path:
    assert spec.fallback_build_dir is not None

    build_dir = spec.fallback_build_dir
    raw_filelist = build_dir / "expanded_filelist.f"
    if not raw_filelist.exists():
        raw_filelist = build_dir / "filelist.f"
    if not raw_filelist.exists():
        candidates = sorted(build_dir.glob("*.f"))
        candidates = [f for f in candidates if f.name != "expanded_filelist.f"]
        if candidates:
            raw_filelist = candidates[0]
    if not raw_filelist.exists():
        raise FileNotFoundError(f"No filelist.f found under {build_dir}")

    TEMP_RESOLVED_FILELIST_DIR.mkdir(parents=True, exist_ok=True)
    resolved_filelist = TEMP_RESOLVED_FILELIST_DIR / f"{spec.stub_module_name}.f"

    # build_logic root = parent of per-IP directories
    build_root = build_dir.parent
    # Build a name→path index for all build_logic subdirs
    dir_index: dict[str, Path] = {}
    for d in build_root.iterdir():
        if d.is_dir():
            dir_index[d.name.lower()] = d

    def _resolve_env_path(raw: str) -> str:
        """Resolve $SOME_VAR/rel/path to an absolute path under build_root."""
        raw = raw.strip()
        m = re.match(r"\$(\w+)/(.+)", raw)
        if not m:
            return raw
        var, rest = m.groups()
        var_lower = var.lower()
        # Direct name match
        if var_lower in dir_index:
            candidate = dir_index[var_lower] / rest
            if candidate.exists():
                return str(candidate)
        # Partial name match
        for name, path in dir_index.items():
            if var_lower in name:
                candidate = path / rest
                if candidate.exists():
                    return str(candidate)
        return raw

    resolved_lines: list[str] = []
    for raw_line in raw_filelist.read_text(encoding="utf-8").splitlines():
        line = raw_line.strip()
        if not line or line.startswith("//"):
            continue
        if line.startswith("-f "):
            ref = line[3:]
            resolved = _resolve_env_path(ref)
            resolved_lines.append(f"-f {resolved}")
        elif line.startswith("$"):
            resolved = _resolve_env_path(line)
            resolved_lines.append(resolved)
        else:
            # Relative path — make absolute under build_dir
            if not os.path.isabs(line):
                line = str((build_dir / line).resolve())
            resolved_lines.append(line)

    resolved_filelist.write_text("\n".join(resolved_lines) + "\n", encoding="utf-8")
    return resolved_filelist

    resolved_filelist.write_text("\n".join(resolved_lines) + "\n", encoding="utf-8")
    return resolved_filelist


def instantiate_component(spec: StubSpec):
    from uhdl.uhdl.core.TemplateIP import TemplateComponent
    from uhdl.uhdl.core.TemplateIP import TemplateIPConfig

    config = load_config(spec)
    params = dict(getattr(config, "param_overrides", {}) or {})
    top_candidates = [spec.top_module]

    last_error: Exception | None = None
    for top_name in top_candidates:
        try:
            component = TemplateComponent(
                config=config,
                top=top_name,
                struct_mode="packed",
                **params,
            )
            return config, component, top_name
        except Exception as exc:  # noqa: BLE001
            last_error = exc

    if spec.fallback_build_dir is not None and spec.fallback_top_module is not None:
        # Resolve filelist env vars to absolute paths, then TemplateComponent.
        from uhdl.uhdl.core.TemplateIP import TemplateComponent
        from uhdl.uhdl.core.TemplateIP import TemplateIPConfig
        filelist = resolve_build_filelist(spec)
        fallback_cfg = TemplateIPConfig(
            name=f"{spec.stub_module_name}_fallback",
            prefix="",
            filelist=str(filelist),
            env_var=f"{spec.stub_module_name.upper()}_FALLBACK",
        )
        component = TemplateComponent(
            config=fallback_cfg,
            top=spec.fallback_top_module,
            struct_mode="packed",
        )
        return config, component, spec.fallback_top_module

    assert last_error is not None
    raise last_error


def io_direction(io: Any) -> str:
    type_name = type(io).__name__
    if type_name == "Input":
        return "input"
    if type_name == "Output":
        return "output"
    if type_name == "Inout":
        return "inout"
    raise ValueError(f"Unsupported IO type {type_name!r} for port {getattr(io, 'name', '<unknown>')}")


def port_width(io: Any) -> int:
    width = int(getattr(io, "width", 0) or 0)
    if width < 1:
        name = str(getattr(io, "name", "") or "")
        for suffix, fallback_width in KNOWN_PORT_WIDTH_SUFFIXES:
            if name == suffix or name.endswith(f"_{suffix}"):
                width = fallback_width
                break
    if width < 1:
        width = 1  # unresolved width fallback, stub output still reviewable
    return width


def port_decl(direction: str, width: int, name: str, dir_width: int, vec_width: int, name_width: int, with_comma: bool) -> str:
    vector = f"logic [{width - 1}:0]"
    comma = "," if with_comma else ""
    return f"    {direction:<{dir_width}} {vector:<{vec_width}} {name:<{name_width}}{comma}"


# ── Port category comments (pattern → description) ─────────────────────
_PORT_COMMENT_RULES: tuple[tuple[str, str], ...] = (
    # Clock & Reset
    ("clk", "clock input"),
    ("rst_n|rstn|reset_n", "active-low reset"),
    # AXI4 channels
    ("_awvalid$|_awready$", "AXI write address valid/ready"),
    ("_awaddr$", "AXI write address"),
    ("_awid$", "AXI write address ID"),
    ("_awlen$", "AXI write burst length"),
    ("_awsize$", "AXI write burst size"),
    ("_awburst$", "AXI write burst type"),
    ("_awlock$", "AXI write lock"),
    ("_awcache$", "AXI write cache"),
    ("_awprot$", "AXI write protection"),
    ("_awqos$", "AXI write QoS"),
    ("_awuser$", "AXI write user"),
    ("_wvalid$|_wready$", "AXI write data valid/ready"),
    ("_wdata$", "AXI write data"),
    ("_wstrb$", "AXI write strobe"),
    ("_wlast$", "AXI write last"),
    ("_bvalid$|_bready$", "AXI write response valid/ready"),
    ("_bid$", "AXI write response ID"),
    ("_bresp$", "AXI write response"),
    ("_arvalid$|_arready$", "AXI read address valid/ready"),
    ("_araddr$", "AXI read address"),
    ("_arid$", "AXI read address ID"),
    ("_arlen$", "AXI read burst length"),
    ("_arsize$", "AXI read burst size"),
    ("_arburst$", "AXI read burst type"),
    ("_arlock$", "AXI read lock"),
    ("_arcache$", "AXI read cache"),
    ("_arprot$", "AXI read protection"),
    ("_arqos$", "AXI read QoS"),
    ("_aruser$", "AXI read user"),
    ("_rvalid$|_rready$", "AXI read data valid/ready"),
    ("_rid$", "AXI read data ID"),
    ("_rdata$", "AXI read data"),
    ("_rresp$", "AXI read response"),
    ("_rlast$", "AXI read last"),
    # APB
    ("p_addr$|_paddr$", "APB address"),
    ("p_wdata$|_pwdata$", "APB write data"),
    ("p_rdata$|_prdata$", "APB read data"),
    ("p_write$|_pwrite$", "APB write enable"),
    ("p_sel$|_psel$", "APB select"),
    ("p_enable$|_penable$", "APB enable"),
    ("p_ready$|_pready$", "APB ready"),
    ("p_slverr$|_pslverr$", "APB slave error"),
    # ATB
    ("_atvalid$", "ATB trace valid"),
    ("_atready$", "ATB trace ready"),
    ("_atbytes$", "ATB trace byte count"),
    ("_atdata$", "ATB trace data"),
    ("_atid$", "ATB trace ID"),
    ("_afvalid$", "ATB flush valid"),
    ("_afready$", "ATB flush ready"),
    ("_syncreq$", "ATB sync request"),
    ("_atwakeup$", "ATB wakeup"),
    # Interrupt
    ("_v_interrupt", "interrupt vector"),
    ("_v_merge_interrupt", "merged interrupt output"),
    # NoC flow control
    ("_req_valid|_req_ready", "request valid/ready"),
    ("_req_payload", "request payload"),
    ("_req_srcid", "request source ID"),
    ("_req_tgtid", "request target ID"),
    ("_req_qos", "request QoS"),
    ("_req_last", "request last beat"),
    ("_rsp_valid|_rsp_ready", "response valid/ready"),
    ("_rsp_payload", "response payload"),
    # CDC / async FIFO
    ("wptr_async", "async FIFO write pointer"),
    ("rptr_async", "async FIFO read pointer (async)"),
    ("rptr_sync", "async FIFO read pointer (sync)"),
    ("pld_sync", "async FIFO payload sync"),
    # Low power
    ("pchannel_paccept|pchannel_pdeny", "power channel accept/deny"),
    ("pchannel_pactive", "power channel active state"),
    ("pchannel_preq", "power channel request"),
    ("pchannel_pstate", "power channel state"),
    ("lp_", "low-power interface"),
    # ID / node
    ("node_id$", "node identifier"),
    ("src_id$", "source ID"),
    ("tgt_id$", "target ID"),
    # Error / safety
    ("_sb_err|_db_err", "ECC error flag (single/double bit)"),
    ("regbank_parity_err", "register bank parity error"),
    ("safety", "safety/fault output"),
    # Timeout
    ("timeout", "timeout value"),
    # Debug
    ("dbg_", "debug interface"),
    # Generic ring
    ("pring_in_if|pring_out_if|nring_in_if|nring_out_if", "ring link interface"),
    ("local_tx|local_rx", "local endpoint interface"),
)


def port_comment(name: str) -> str:
    """Return a //-style comment for a port based on its name pattern."""
    import re
    for pattern, desc in _PORT_COMMENT_RULES:
        if re.search(pattern, name):
            return f"// {desc}"
    return ""


def render_stub(spec: StubSpec, config: Any, component: Any, resolved_top_name: str) -> str:
    ports: list[dict[str, Any]] = []
    for io in component.io_list:
        direction = io_direction(io)
        width = port_width(io)
        ports.append({"name": io.name, "direction": direction, "width": width})

    dir_width = max(len(port["direction"]) for port in ports)
    vec_width = max(len(f"logic [{port['width'] - 1}:0]") for port in ports)
    name_width = max(len(port["name"]) for port in ports)

    lines = [
        "// Auto-generated by tools/gen_noc_niu_stubs.py.",
        "// Review-only boundary stub with fully expanded vector widths.",
        "// All outputs are tied to '0 so reviewers can focus on interface shape and bit width.",
        "// Future extension: FUSA error related ports will be added on this boundary in a later revision.",
        f"// Requested source top module: {spec.top_module}",
        f"// Resolved source top module: {resolved_top_name}",
        f"// Representative config: {spec.config_attr} (TemplateIPConfig name={getattr(config, 'name', '<unknown>')})",
        f"module {spec.stub_module_name} (",
    ]

    for index, port in enumerate(ports):
        decl = port_decl(
            direction=port["direction"],
            width=port["width"],
            name=port["name"],
            dir_width=dir_width,
            vec_width=vec_width,
            name_width=name_width,
            with_comma=index != len(ports) - 1,
        )
        comment = port_comment(port["name"])
        if comment:
            decl += f"  {comment}"
        lines.append(decl)

    lines.extend(
        [
            ");",
            "",
            "    // Future boundary note:",
            "    // FUSA error reporting ports are intentionally omitted in this review stub today,",
            "    // but this boundary is expected to grow dedicated FUSA error signaling later.",
            "",
            "    // Review-only stub behavior: tie every output low.",
        ]
    )

    output_ports = [port for port in ports if port["direction"] == "output"]
    if output_ports:
        for port in output_ports:
            lines.append(f"    assign {port['name']} = '0;")
    else:
        lines.append("    // This boundary has no output ports to tie off.")

    lines.extend(["", "endmodule"])
    return "\n".join(lines) + "\n"


def write_stub(output_dir: Path, spec: StubSpec, content: str) -> Path:
    noc_dir = output_dir / spec.noc
    noc_dir.mkdir(parents=True, exist_ok=True)
    stub_path = noc_dir / spec.file_name
    stub_path.write_text(content, encoding="utf-8")
    return stub_path


def write_manifest(output_dir: Path, entries: list[dict[str, Any]]) -> Path:
    manifest_path = output_dir / "manifest.json"
    manifest_path.write_text(json.dumps({"generated_stubs": entries}, indent=2) + "\n", encoding="utf-8")
    return manifest_path


def main() -> int:
    args = parse_args()
    bootstrap_paths()
    patch_port_widths()

    manifest_entries: list[dict[str, Any]] = []
    for spec in SPECS:
        try:
            config, component, resolved_top_name = instantiate_component(spec)
        except Exception as exc:
            print(f"[SKIP] {spec.noc}/{spec.category}: {exc}", file=sys.stderr)
            continue
        content = render_stub(spec, config, component, resolved_top_name)
        stub_path = write_stub(args.output_dir, spec, content)
        manifest_entries.append(
            {
                "noc": spec.noc,
                "category": spec.category,
                "top_module": spec.top_module,
                "resolved_top_module": resolved_top_name,
                "config_attr": spec.config_attr,
                "config_name": getattr(config, "name", None),
                "stub_module": spec.stub_module_name,
                "path": str(stub_path),
                "port_count": len(component.io_list),
            }
        )

    manifest_path = write_manifest(args.output_dir, manifest_entries)
    print(f"output_dir: {args.output_dir}")
    print(f"manifest: {manifest_path}")
    for entry in manifest_entries:
        print(f"stub: {entry['path']}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())