import re
from pathlib import Path


DECL_RE = re.compile(r"^\s*(?:module|package|interface)\s+(\w+)", re.MULTILINE)


def collect_decl_names(file_path: Path) -> list[str]:
    try:
        text = file_path.read_text()
    except UnicodeDecodeError:
        text = file_path.read_text(encoding="utf-8", errors="ignore")
    return DECL_RE.findall(text)


def main():
    build_root = Path(__file__).resolve().parent / "build_logic"
    input_filelist = build_root / "dti_logic_topo" / "expanded_filelist.f"
    output_filelist = build_root / "dti_logic_topo" / "review_filelist.f"
    report_file = build_root / "dti_logic_topo" / "review_filelist.report.txt"

    seen_decl_to_file: dict[str, Path] = {}
    kept_files: list[Path] = []
    skipped_files: list[tuple[Path, list[str], Path]] = []

    for raw_line in input_filelist.read_text().splitlines():
        line = raw_line.strip()
        if not line or line.startswith("//"):
            continue

        file_path = Path(line)
        if not file_path.is_absolute():
            file_path = (build_root / file_path).resolve()

        decl_names = collect_decl_names(file_path)
        duplicate_hits = []
        for name in decl_names:
            if name in seen_decl_to_file:
                duplicate_hits.append((name, seen_decl_to_file[name]))

        if duplicate_hits and len(duplicate_hits) == len(decl_names):
            skipped_files.append((file_path, [name for name, _ in duplicate_hits], duplicate_hits[0][1]))
            continue

        kept_files.append(file_path)
        for name in decl_names:
            seen_decl_to_file.setdefault(name, file_path)

    output_filelist.write_text("\n".join(str(path) for path in kept_files) + "\n")

    report_lines = [
        f"input_filelist={input_filelist}",
        f"output_filelist={output_filelist}",
        f"kept_files={len(kept_files)}",
        f"skipped_files={len(skipped_files)}",
        "",
        "Skipped duplicates:",
    ]
    for file_path, names, original in skipped_files:
        report_lines.append(f"- {file_path}")
        report_lines.append(f"  duplicate_names={','.join(names)}")
        report_lines.append(f"  kept_from={original}")

    report_file.write_text("\n".join(report_lines) + "\n")


if __name__ == "__main__":
    main()