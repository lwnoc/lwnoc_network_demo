"""Runtime monkey-patch: fix [-1:0] width for struct ports with struct_mode='packed'.

Root cause 1 (STS): pyslang `port_type.canonicalType` returns ErrorType for nested
struct aliases (e.g., sts_req_typ → sts_cmn_typ). The alias chain is broken, so
isStruct=False and bitWidth=0.

Root cause 2 (ATB/DTI): LP struct packages (lwnoc_lp_struct_package) not in filelist.
pyslang can't resolve lwnoc_lp_req_signal_t → bitWidth=0.

This patch uses a hardcoded width table for known struct types whose width is
known from their package definitions. When struct_mode='packed' and the port is
a known struct type, we write the correct width directly.
"""

# Hardcoded width table for known struct types that pyslang fails to resolve.
# Values verified by manual pyslang test with package-only compilation.
_STRUCT_WIDTH_TABLE: dict[str, int] = {
    # STS data structs (lwnoc_sts_pack)
    "lwnoc_sts_pack::sts_req_typ": 119,
    "sts_req_typ": 119,
    "lwnoc_sts_pack::sts_rsp_typ": 65,
    "sts_rsp_typ": 65,
    # LP structs (lwnoc_lp_struct_package / lwnoc_lp_define_package)
    "lwnoc_lp_struct_package::lwnoc_lp_req_signal_t": 7,
    "lwnoc_lp_define_package::lwnoc_pchannel_state_t": 3,
    "lwnoc_lp_define_package::lwnoc_pchannel_active_t": 2,
    # ATB data structs (lw_atb_noc_pack)
    "lw_atb_noc_pack::atb_trans_typ": 142,
    "atb_trans_typ": 142,
}


def _patch_vport_init():
    from uhdl.uhdl.core.VComponent import VPort

    _orig_init = VPort.__init__

    def _patched_init(self, name, direction, port_type, struct_mode='auto'):
        _orig_init(self, name, direction, port_type, struct_mode)

        if self._struct_mode != 'packed':
            return
        if self.width != 0:
            return
        if not getattr(port_type, 'isAlias', False):
            return

        # Check if the port type is a known unresolvable struct
        hier = getattr(port_type, 'hierarchicalPath', None)
        if hier and hier in _STRUCT_WIDTH_TABLE:
            self.width = _STRUCT_WIDTH_TABLE[hier]
            # Mark as struct so create_uhdl_port takes the packed branch
            self.is_struct = True

    VPort.__init__ = _patched_init


def patch_vport_width():
    _patch_vport_init()
