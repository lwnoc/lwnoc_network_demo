import sys
from pathlib import Path


THIS_DIR = Path(__file__).resolve().parent
REPO_ROOT = THIS_DIR.parent
LWNOC_TOPO_ROOT = REPO_ROOT / "lwnoc_topo"

if str(LWNOC_TOPO_ROOT) not in sys.path:
    sys.path.insert(0, str(LWNOC_TOPO_ROOT))

from topo_core.node.uhdlComponentNode import UhdlComponentNode
from uhdl.uhdl.core.TemplateIP import TemplateComponent


class DtiSwitchNode(UhdlComponentNode):
    def __init__(self, id: str, cfg, top: str, input_count: int):
        params = getattr(cfg, 'param_overrides', {})
        comp = TemplateComponent(config=cfg, top=top, **params)
        super().__init__(id=id, impl=comp)

        self.add_interface("clk", r"^clk$")
        self.add_interface("rst_n", r"^rst_n$")
        self.add_interface("tniu_req", r"^tniu_req_.*")
        self.add_interface("tniu_rsp", r"^tniu_rsp_.*")

        for idx in range(input_count):
            self.add_interface(f"iniu{idx}_req", rf"^iniu{idx}_req_.*")
            self.add_interface(f"iniu{idx}_rsp", rf"^iniu{idx}_rsp_.*")