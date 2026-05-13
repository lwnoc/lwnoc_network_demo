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
        config_attr="aon_ss_iniu_noc_side_config",
        top_module="sts_iniu_noc",
        extra_sys_paths=(REPO_ROOT / "lwnoc_sts_noc_demo",),
        fallback_build_dir=REPO_ROOT / "lwnoc_sts_noc_demo" / "build_logic" / "aon_ss_iniu_noc_side",
        fallback_top_module="sts_iniu_noc",
    ),
    StubSpec(
        noc="sts",
        category="tniu_sys_side",
        template_module="StsTemplate",
        config_attr="STS_SOC_TNIU_SYS_CONFIGS[ddrss0]",
        top_module="sts_tniu_sys",
        extra_sys_paths=(REPO_ROOT / "lwnoc_sts_noc_demo",),
        fallback_build_dir=REPO_ROOT / "lwnoc_sts_noc_demo" / "build_logic" / "ddrss_tniu_sys",
        fallback_top_module="sts_tniu_sys",
    ),
    StubSpec(
        noc="sts",
        category="tniu_top_side",
        template_module="StsTemplate",
        config_attr="STS_SOC_TNIU_TOP_CONFIGS[ddrss0]",
        top_module="sts_tniu_noc",
        extra_sys_paths=(REPO_ROOT / "lwnoc_sts_noc_demo",),
        fallback_build_dir=REPO_ROOT / "lwnoc_sts_noc_demo" / "build_logic" / "ddrss_tniu_noc_side",
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
        config_attr="display_ss_tniu_cfg",
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
        config_attr="pcie_eth_iniu_sys_config",
        top_module="dti_pr_iniu_async_sys_side",
        extra_sys_paths=(REPO_ROOT / "soc_dti_noc_demo",),
        fallback_build_dir=REPO_ROOT / "soc_dti_noc_demo" / "build_logic" / "pcie_eth_iniu_sys",
        fallback_top_module="pcie_eth_dti_pr_iniu_async_sys_side",
    ),
    StubSpec(
        noc="dti",
        category="iniu_top_side",
        template_module="DtiTemplate",
        config_attr="iniu_top_config",
        top_module="dti_pr_iniu_async_top_side",
        extra_sys_paths=(REPO_ROOT / "soc_dti_noc_demo",),
        fallback_build_dir=REPO_ROOT / "soc_dti_noc_demo" / "build_logic" / "dti_iniu_top_side",
        fallback_top_module="dti_iniu_top_dti_pr_iniu_async_top_side",
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
        config_attr="tniu_top_config",
        top_module="dti_tniu_async_top_side",
        extra_sys_paths=(REPO_ROOT / "soc_dti_noc_demo",),
        fallback_build_dir=REPO_ROOT / "soc_dti_noc_demo" / "build_logic" / "dti_tniu_top_side",
        fallback_top_module="dti_tniu_top_dti_tniu_async_top_side",
    ),
    StubSpec(
        noc="atb",
        category="iniu_sys_side",
        template_module="AtbTemplate",
        config_attr="_atb_iniu_sys_cfg",
        top_module="atb_iniu_sys",
        extra_sys_paths=(REPO_ROOT / "soc_atb_noc",),
        fallback_build_dir=REPO_ROOT / "soc_atb_noc" / "build_logic" / "camera_iniu_sys",
        fallback_top_module="cam_atb_iniu_sys",
    ),
    StubSpec(
        noc="atb",
        category="iniu_top_side",
        template_module="AtbTemplate",
        config_attr="_atb_iniu_noc_cfg",
        top_module="atb_iniu_noc",
        extra_sys_paths=(REPO_ROOT / "soc_atb_noc",),
        fallback_build_dir=REPO_ROOT / "soc_atb_noc" / "build_logic" / "atb_iniu_noc",
        fallback_top_module="atb_iniu_noc",
    ),
    StubSpec(
        noc="atb",
        category="tniu_sys_side",
        template_module="AtbTemplate",
        config_attr="_atb_tniu_sys_cfg",
        top_module="atb_tniu_sys",
        extra_sys_paths=(REPO_ROOT / "soc_atb_noc",),
        fallback_build_dir=REPO_ROOT / "soc_atb_noc" / "build_logic" / "debug_tniu_sys",
        fallback_top_module="dbg_atb_tniu_sys",
    ),
    StubSpec(
        noc="atb",
        category="tniu_top_side",
        template_module="AtbTemplate",
        config_attr="_atb_tniu_noc_cfg",
        top_module="atb_tniu_noc",
        extra_sys_paths=(REPO_ROOT / "soc_atb_noc",),
        fallback_build_dir=REPO_ROOT / "soc_atb_noc" / "build_logic" / "atb_tniu_noc",
        fallback_top_module="atb_tniu_noc",
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
    from lwnoc_sts_noc_demo.tools.vport_width_patch import patch_vport_width

    patch_vport_width()


def load_config(spec: StubSpec) -> Any:
    for path in spec.extra_sys_paths:
        path_str = str(path)
        if path_str not in sys.path:
            sys.path.insert(0, path_str)

    module = importlib.import_module(spec.template_module)
    parts = spec.config_attr.split(".")
    obj: Any = module
    for part in parts:
        if part.endswith("]") and "[" in part:
            name, key = part.split("[", 1)
            key = key.rstrip("]").strip("\"'")
            obj = getattr(obj, name)[key]
        else:
            obj = getattr(obj, part)
    return obj


def resolve_build_filelist(spec: StubSpec) -> Path:
    assert spec.fallback_build_dir is not None

    build_dir = spec.fallback_build_dir
    preferred = sorted(path for path in build_dir.glob("*.f") if path.name != "expanded_filelist.f")
    source_filelist = preferred[0] if preferred else build_dir / "expanded_filelist.f"
    if not source_filelist.exists():
        raise FileNotFoundError(f"No build filelist found under {build_dir}")

    TEMP_RESOLVED_FILELIST_DIR.mkdir(parents=True, exist_ok=True)
    resolved_filelist = TEMP_RESOLVED_FILELIST_DIR / f"{spec.stub_module_name}.f"

    resolved_lines: list[str] = []
    for raw_line in source_filelist.read_text(encoding="utf-8").splitlines():
        line = raw_line.strip()
        if not line:
            continue

        line = re.sub(r"\$\{?[A-Z0-9_]+\}?", str(build_dir), line)
        if not line.startswith("/") and not line.startswith("+") and not line.startswith("-"):
            line = str((build_dir / line).resolve())
        resolved_lines.append(line)

    resolved_filelist.write_text("\n".join(resolved_lines) + "\n", encoding="utf-8")
    return resolved_filelist


def instantiate_component(spec: StubSpec):
    from uhdl.uhdl.core.TemplateIP import TemplateComponent
    from uhdl.uhdl.core.TemplateIP import TemplateIPConfig

    config = load_config(spec)
    params = dict(getattr(config, "param_overrides", {}) or {})
    top_candidates = [spec.top_module]
    prefix = str(getattr(config, "prefix", "") or "")
    if prefix:
        top_candidates.append(f"{prefix}{spec.top_module}")

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
        filelist = resolve_build_filelist(spec)
        build_cfg = TemplateIPConfig(
            name=f"{spec.stub_module_name}_build_fallback",
            prefix="",
            filelist=str(filelist),
            env_var=f"{spec.stub_module_name.upper()}_BUILD_FALLBACK",
        )
        component = TemplateComponent(
            config=build_cfg,
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
        raise ValueError(f"Port {io.name} has unresolved width {width}")
    return width


def port_decl(direction: str, width: int, name: str, dir_width: int, vec_width: int, name_width: int, with_comma: bool) -> str:
    vector = f"logic [{width - 1}:0]"
    comma = "," if with_comma else ""
    return f"    {direction:<{dir_width}} {vector:<{vec_width}} {name:<{name_width}}{comma}"


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
        lines.append(
            port_decl(
                direction=port["direction"],
                width=port["width"],
                name=port["name"],
                dir_width=dir_width,
                vec_width=vec_width,
                name_width=name_width,
                with_comma=index != len(ports) - 1,
            )
        )

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
        config, component, resolved_top_name = instantiate_component(spec)
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