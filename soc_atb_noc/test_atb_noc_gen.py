from gen_soc_atb_topo import generate


def main():
    # Memnoc-aligned entrypoint: always emit DV first, then PD/harden outputs.
    generate("dv")
    generate("pd")


if __name__ == "__main__":
    main()
