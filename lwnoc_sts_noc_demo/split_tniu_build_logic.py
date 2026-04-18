"""
split_tniu_build_logic.py — Split 4 monolithic sts_demo_tniu<N>/ dirs into
sts_demo_tniu<N>_sys/ + sts_demo_tniu<N>_top_side/ (parallel to INIU split).

For each TNIU instance:
  - sys dir : all files EXCEPT sts_tniu_top.sv and wrap.sv
              filelist: first 12 entries (macros → sts_tniu_sys), env var = STS_DEMO_TNIU<N>_SYS_OUT_DIR
  - top_side: sts_tniu_top.sv + wrap.sv
              filelist: last 2 entries, env var = STS_DEMO_TNIU<N>_OUT_DIR
Old monolithic dirs are deleted after split.
"""
import os
import shutil
from pathlib import Path

BUILD = Path(__file__).parent / "build_logic"

def split_one(n: int):
    prefix = f"sts_demo_tniu{n}"
    src_dir = BUILD / prefix

    if not src_dir.exists():
        print(f"  SKIP: {src_dir} not found")
        return

    # Read existing filelist to identify compile-order
    orig_fl = src_dir / f"{prefix}_filelist.f"
    fl_lines = [l for l in orig_fl.read_text().splitlines() if l.strip()]

    # Split: last 2 = top_side (sts_tniu_top + wrap); rest = sys
    top_lines = fl_lines[-2:]   # sts_tniu_top.sv + wrap.sv
    sys_lines  = fl_lines[:-2]  # everything before them

    # Identify top file basenames
    top_basenames = set()
    for line in top_lines:
        top_basenames.add(Path(line.split("/")[-1]).name)

    sys_dir  = BUILD / f"{prefix}_sys"
    top_dir  = BUILD / f"{prefix}_top_side"
    sys_dir.mkdir(exist_ok=True)
    top_dir.mkdir(exist_ok=True)

    # Copy files to their target dirs
    sys_env  = f"STS_DEMO_TNIU{n}_SYS_OUT_DIR"
    top_env  = f"STS_DEMO_TNIU{n}_OUT_DIR"   # keep existing env var for top_side

    for f in src_dir.iterdir():
        fn = f.name
        if fn.endswith("_filelist.f") or fn == "expanded_filelist.f":
            continue   # handle separately
        if fn in top_basenames:
            shutil.copy2(f, top_dir / fn)
        else:
            shutil.copy2(f, sys_dir / fn)

    # Write sys_filelist.f
    sys_fl_lines = [
        l.replace(f"${top_env}/", f"${sys_env}/") for l in sys_lines
    ]
    (sys_dir / f"{prefix}_sys_filelist.f").write_text(
        "\n".join(sys_fl_lines) + "\n"
    )

    # Write top_side_filelist.f
    top_fl_lines = [
        l.replace(f"${top_env}/{prefix}_", f"${top_env}/{prefix}_") for l in top_lines
    ]
    (top_dir / f"{prefix}_top_side_filelist.f").write_text(
        "\n".join(top_fl_lines) + "\n"
    )

    # Copy expanded_filelist.f to both (reference only)
    exp_fl = src_dir / "expanded_filelist.f"
    if exp_fl.exists():
        shutil.copy2(exp_fl, sys_dir / "expanded_filelist.f")
        shutil.copy2(exp_fl, top_dir / "expanded_filelist.f")

    # Remove old monolithic dir
    shutil.rmtree(src_dir)
    print(f"  tniu{n}: {len(sys_lines)} sys entries, {len(top_lines)} top_side entries → DONE")

for n in range(4):
    split_one(n)

print("All 4 TNIU instances split.")
