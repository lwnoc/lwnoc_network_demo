"""Filelist publication and directory management for SoC interrupt NoC generation."""

import os
import re
import shutil
import subprocess
import sys
from pathlib import Path
from typing import Optional


_TOP_SIDE_BLOCKS = {
    "intr_iniu_top_side": "INTR_INIU_TOP_OUT_DIR",
    "intr_tniu_top_side": "INTR_TNIU_TOP_OUT_DIR",
    "intr_ring_network": "INTR_RING_NETWORK_OUT_DIR",
    "intr_ring_buf": "INTR_RING_BUF_OUT_DIR",
}


# ── Endpoint ID table ──────────────────────────────────────────────────

def collect_endpoint_id_rows(ring_plan: list[tuple]) -> list[dict]:
    rows = []
    for ring_slot, entry in enumerate(ring_plan):
        _node_id, _ss_name, role, _harden = entry
        rows.append({"ring_slot": ring_slot, "kind": role, "name": _ss_name})
    return rows


def write_endpoint_id_tables(output_dir: Path, ring_plan: list[tuple]) -> None:
    rows = collect_endpoint_id_rows(ring_plan)
    output_dir.mkdir(parents=True, exist_ok=True)
    md_lines = ["# SoC Intr Endpoint ID Table\n", "| Ring Slot | Kind | Name |",
                "|---|---|---|"]
    csv_lines = ["ring_slot,kind,name"]
    for row in rows:
        md_lines.append(f"| {row['ring_slot']} | {row['kind']} | {row['name']} |")
        csv_lines.append(f"{row['ring_slot']},{row['kind']},{row['name']}")
    output_dir.joinpath("soc_intr_endpoint_id_table.md").write_text("\n".join(md_lines) + "\n")
    output_dir.joinpath("soc_intr_endpoint_id_table.csv").write_text("\n".join(csv_lines) + "\n")


# ── Directory management ───────────────────────────────────────────────

def remove_generated_entry(path: Path) -> None:
    if path.is_dir():
        shutil.rmtree(path)
    else:
        path.unlink()


def prepare_build_dir(flow: str, build_dir: Path) -> None:
    if not build_dir.exists():
        return
    removed = []
    if flow == "dv":
        for entry in sorted(build_dir.iterdir()):
            if entry.name in {"soc_intr_ring_noc_harden_top", "soc_intr_noc_wrap_pd",
                              "soc_intr_ring_noc_up_harden_wrap", "soc_intr_ring_noc_dn_harden_wrap"}:
                continue
            remove_generated_entry(entry)
            removed.append(entry.name)
    else:
        for entry_name in ("intr_ring_req_sink", "intr_ring_req_zero_source",
                           "soc_intr_ring_noc_harden_top", "soc_intr_noc_wrap_pd",
                           "soc_intr_ring_noc_up_harden_wrap", "soc_intr_ring_noc_dn_harden_wrap",
                           "soc_intr_ring_noc_harden_top",
                           "intr_iniu_top_side", "intr_tniu_top_side",
                           "intr_ring_network", "intr_ring_buf"):
            entry = build_dir / entry_name
            if entry.exists():
                remove_generated_entry(entry)
                removed.append(entry_name)
    if removed:
        print(f"[{flow}] Removed stale generated entries: {', '.join(removed)}")


def move_generated_dir(build_dir: Path, src_name: str, dst_name: str) -> None:
    src = build_dir / src_name
    dst = build_dir / dst_name
    if src == dst or not src.exists():
        return
    if dst.exists():
        shutil.rmtree(dst)
    shutil.move(str(src), str(dst))
    print(f"  [move] {src_name} -> {dst_name}")


# ── Consolidation ──────────────────────────────────────────────────────

def consolidate_top_side(build_dir: Path, combined_dir_name: str, shared_env: str) -> None:
    combined = build_dir / combined_dir_name
    for block_name, old_env in _TOP_SIDE_BLOCKS.items():
        block_dir = build_dir / block_name
        if not block_dir.exists():
            continue
        for entry in sorted(block_dir.iterdir()):
            if entry.name == "expanded_filelist.f":
                entry.unlink()
                continue
            dest = combined / entry.name
            if entry.suffix == ".f":
                content = entry.read_text().replace(f"${old_env}/", f"${shared_env}/")
                dest.write_text(content)
                entry.unlink()
            else:
                shutil.move(str(entry), str(dest))
        block_dir.rmdir()
    umbrella = combined / "filelist.f"
    if umbrella.exists():
        content = umbrella.read_text()
        for old_env in _TOP_SIDE_BLOCKS.values():
            content = content.replace(f"${old_env}/", f"${shared_env}/")
        umbrella.write_text(content)


# ── Module port extraction ─────────────────────────────────────────────

def extract_module_ports(module_text: str) -> tuple[str, list[str]]:
    m = re.search(r"module\s+[A-Za-z_][A-Za-z0-9_]*\s*\((.*?)\);", module_text, re.DOTALL)
    if not m:
        return "", []
    ports = [p.strip() for p in m.group(1).split(",") if p.strip()]
    return "", ports


# ── Wrapper / filelist publishing ──────────────────────────────────────

def is_dv_wrapper_publish_leaf(filename: str) -> bool:
    return bool(re.match(r"^.+_(?:iniu|tniu)\.v$", filename))


def dv_wrapper_publish_name(filename: str) -> str:
    return filename.replace("_node", "")


def _iter_localized_filelist_entries(filelist_path: Path, source_dir: Path):
    text = filelist_path.read_text()
    for line in text.splitlines():
        line = line.strip()
        if not line or line.startswith("#") or line.startswith("//"):
            continue
        if line.startswith("-f "):
            yield line[3:]
        elif not line.startswith("$"):
            yield str(source_dir / line)


def _iter_sys_filelist_entries(build_dir: Path):
    for sys_dir in sorted(build_dir.glob("*_sys")):
        fl = sys_dir / f"{sys_dir.name}_filelist.f"
        if fl.exists():
            yield from _iter_localized_filelist_entries(fl, sys_dir)


def sys_dir_env_var(dir_name: str) -> str:
    base = dir_name.replace("_sys", "").upper()
    return f"SOC_INTR_{base}_OUT_DIR"


def iter_sys_filelist_refs(build_dir: Path):
    for sys_dir in sorted(build_dir.glob("*_sys")):
        env = sys_dir_env_var(sys_dir.name)
        fl_name = f"{sys_dir.name}_filelist.f"
        yield f"-f ${env}/{fl_name}"


def iter_generated_component_filelist_refs(build_dir: Path):
    for comp_dir in sorted(build_dir.iterdir()):
        if not comp_dir.is_dir() or comp_dir.name.endswith("_sys"):
            continue
        fl = comp_dir / f"{comp_dir.name}_filelist.f"
        if fl.exists():
            yield f"-f $INTR_RING_NOC_DIR/{comp_dir.name}/{comp_dir.name}_filelist.f"


def collect_xbar_lut_specs(search_root: Path) -> list[tuple[int, int]]:
    specs = []
    pattern = re.compile(r"\bsoc_intr_xbar_routing_lut_w(\d+)_c(\d+)\b")
    for fpath in sorted(search_root.rglob("*.v")):
        for m in pattern.finditer(fpath.read_text()):
            specs.append((int(m.group(1)), int(m.group(2))))
    return specs


def emit_xbar_lut_modules(build_dir: Path, search_root: Path, topo) -> list[str]:
    """Generate xbar routing LUT modules with real combinational logic (memnoc-style).

    Creates SocIntrXbarRoutingLutNode, calls build_uhdl() to compute routing LUT
    from DataTopology shortest paths, then generates the Verilog file.
    The generated module contains real assign/EmptyWhen logic, not an empty shell.
    """
    specs = collect_xbar_lut_specs(search_root)
    tokens = []
    for node_id_width, num_channels in specs:
        lut_node = SocIntrXbarRoutingLutNode(
            id=f"soc_intr_xbar_lut_w{node_id_width}_c{num_channels}",
            node_id_width=node_id_width,
            num_channels=num_channels,
        )
        # Set parent's datatopo so build_uhdl() can compute shortest paths
        if hasattr(topo, "datatopo") and topo.datatopo is not None:
            lut_node._datatopo = topo.datatopo
        elif hasattr(topo, "_datatopo") and topo._datatopo is not None:
            lut_node._datatopo = topo._datatopo

        # memnoc pattern: build_uhdl() creates a NEW Component with computed lut_data
        lut_comp = lut_node.build_uhdl()
        lut_comp.output_dir = str(build_dir)
        lut_comp.generate_verilog(iteration=False)

        mod_name = f"soc_intr_xbar_routing_lut_w{node_id_width}_c{num_channels}"
        lut_path = build_dir / f"{mod_name}.v"
        if lut_path.exists():
            tokens.append(f"$INTR_RING_NOC_DIR/{mod_name}.v")
    return tokens


def _iter_dv_combined_core_entries(source_dir: Path):
    seen = set()
    for f in sorted(source_dir.iterdir()):
        if f.is_dir() or f.suffix not in (".sv", ".v"):
            continue
        if f.name in seen:
            continue
        seen.add(f.name)
        yield f.name


def _sys_dir_leaf_filenames(build_dir: Path) -> set[str]:
    names = set()
    for sys_dir in sorted(build_dir.glob("*_sys")):
        for f in sorted(sys_dir.iterdir()):
            if f.suffix in (".sv", ".v"):
                names.add(f.name)
    return names


def rewrite_dv_logic_filelist(
    build_dir: Path,
    combined_dir_name: str,
    include_sys_refs: bool = False,
    extra_rtl_tokens: tuple[str, ...] = (),
) -> None:
    combined_dir = build_dir / combined_dir_name
    union_dir = build_dir / combined_dir_name
    if not union_dir.exists():
        return
    lines = []
    lines.append("// Auto-generated by gen_soc_intr_topo.py (DV combined logic)\n")
    seen_sys_dirs = set()
    for entry in sorted(union_dir.iterdir()):
        if entry.is_dir() and entry.name.endswith("_sys"):
            seen_sys_dirs.add(entry.name)
            lines.append(f"-f $INTR_RING_NOC_DIR/{combined_dir_name}/{entry.name}/{entry.name}_filelist.f\n")
    for token in extra_rtl_tokens:
        lines.append(f"$INTR_RING_NOC_DIR/{combined_dir_name}/{token}.v\n")
    (union_dir / "filelist.f").write_text("".join(lines))


def publish_top_filelist(build_dir: Path, combined_dir_name: str, topo_id: str) -> None:
    union_dir = build_dir / combined_dir_name
    lines = ["// Auto-generated top filelist\n"]
    lines.append(f"-f $INTR_RING_NOC_DIR/{combined_dir_name}/{combined_dir_name}_filelist.f\n")
    (union_dir / "filelist.f").write_text("".join(lines))


def write_filelist(path: Path, lines: list[str]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("".join(lines))


def iter_ring_plan_entries(ring_plan: list, side: str | None = None):
    for entry in ring_plan:
        if side is None or entry[3] == side:
            yield entry


def iter_ring_plan_nodes(ring_plan: list, side: str | None = None):
    for entry in ring_plan:
        _node_id, ss_name, role, harden = entry
        if side is None or harden == side:
            yield _node_id, ss_name, role, harden


def collect_generated_filelist_includes(source_dir: Path) -> list[str]:
    includes = []
    for fpath in sorted(source_dir.iterdir()):
        if fpath.is_dir():
            fl = fpath / f"{fpath.name}_filelist.f"
            if fl.exists():
                includes.append(f"-f $INTR_RING_NOC_DIR/{source_dir.name}/{fpath.name}/{fpath.name}_filelist.f")
    return includes


def iter_filtered_pd_shared_entries(source_dir: Path):
    for f in sorted(source_dir.iterdir()):
        if f.suffix in (".sv", ".v"):
            yield f.name


def publish_harden_partition_dir(source_dir: Path, target_dir: Path, partition_id: str) -> None:
    target_dir.mkdir(parents=True, exist_ok=True)
    for entry in sorted(source_dir.iterdir()):
        if entry.name == "expanded_filelist.f":
            continue
        dest = target_dir / entry.name
        if entry.is_dir():
            if not dest.exists():
                shutil.copytree(entry, dest)
        else:
            shutil.copy2(entry, dest)
    if (target_dir / "filelist.f").exists():
        content = (target_dir / "filelist.f").read_text()
        (target_dir / "filelist.f").write_text(content)


def rewrite_harden_top_filelist(harden_dir: Path, extra_rtl_tokens: tuple[str, ...] = ()) -> None:
    fl = harden_dir / "filelist.f"
    if not fl.exists():
        return
    lines = ["// Auto-generated harden top filelist\n"]
    for token in extra_rtl_tokens:
        lines.append(f"$INTR_RING_NOC_DIR/{harden_dir.name}/{token}.v\n")
    fl.write_text("".join(lines))


def publish_named_top_wrapper(build_dir: Path, combined_dir: str, wrap_name: str) -> None:
    src = build_dir / combined_dir
    dst = build_dir / wrap_name
    dst.mkdir(parents=True, exist_ok=True)
    for f in sorted(src.iterdir()):
        if f.name in ("filelist.f",):
            continue
        dest = dst / f.name
        if f.is_dir():
            shutil.copytree(f, dest, dirs_exist_ok=True)
        else:
            shutil.copy2(f, dest)
    fl_content = f"-f $INTR_RING_NOC_DIR/{combined_dir}/filelist.f\n"
    (dst / "filelist.f").write_text(fl_content)
    print(f"  [wrap] {wrap_name} -> -f $INTR_RING_NOC_DIR/{combined_dir}/filelist.f")


def publish_dv_ring_top_dir(
    build_dir: Path,
    combined_dir_name: str,
    topo_id: str,
    extra_rtl_tokens: tuple[str, ...] = (),
    ring_plan: list = None,
) -> None:
    combined_dir = build_dir / combined_dir_name
    combined_dir.mkdir(parents=True, exist_ok=True)
    for sys_dir in sorted(build_dir.glob("*_sys")):
        dest = combined_dir / sys_dir.name
        shutil.copytree(sys_dir, dest, dirs_exist_ok=True)

    fl_lines = ["// Auto-generated combined filelist\n"]
    for sys_dir in sorted(combined_dir.glob("*_sys")):
        env_var = f"SOC_INTR_{sys_dir.name.upper()}_OUT_DIR"
        fl_lines.append(f"-f ${env_var}/{sys_dir.name}_filelist.f\n")
    for token in extra_rtl_tokens:
        fl_lines.append(f"$INTR_RING_NOC_DIR/{combined_dir_name}/{token}.v\n")

    fl_path = combined_dir / "filelist.f"
    fl_path.write_text("".join(fl_lines))
    print(f"  [top] {combined_dir_name}/filelist.f")


def run_top_io_boundary_check(top_file: Path, checker_path: Path) -> None:
    if not checker_path.exists() or not top_file.exists():
        return
    cmd = [sys.executable, str(checker_path), "--top-file", str(top_file)]
    print(f"  [boundary_check] running: {' '.join(cmd)}")
    result = subprocess.run(cmd, cwd=checker_path.parent)
    if result.returncode != 0:
        raise RuntimeError(f"Top-IO boundary check failed (rc={result.returncode}).")


def as_demo_token(path: Path) -> str:
    return f"$INTR_RING_NOC_DIR/{path.parent.name}/{path.name}"


def publish_harden_filelist(harden_dir: Path, dst_path: Path) -> None:
    lines = [f"-f $INTR_RING_NOC_DIR/{harden_dir.name}/{harden_dir.name}.v\n"]
    for entry in sorted(harden_dir.iterdir()):
        if entry.suffix in (".sv", ".v") and entry.name != f"{harden_dir.name}.v":
            lines.append(f"$INTR_RING_NOC_DIR/{harden_dir.name}/{entry.name}\n")
    dst_path.write_text("".join(lines))


def stitch_pd_compile_entry(publish_dir: Path) -> None:
    fl = publish_dir / "filelist.f"
    lines = []
    for fpath in sorted(publish_dir.rglob("*.v")) + sorted(publish_dir.rglob("*.sv")):
        rel = fpath.relative_to(publish_dir)
        lines.append(f"$INTR_RING_NOC_DIR/{publish_dir.name}/{rel}\n")
    fl.write_text("".join(lines))
