"""Compatibility shim for STS top-wrapper generation.

Some generator entrypoints import ``ensure_top_wrapper_shims`` as a hook point.
In the current flow no extra shim materialization is required, so this helper
is intentionally a no-op.
"""


def ensure_top_wrapper_shims(*_args, **_kwargs) -> None:
    """No-op compatibility hook for legacy imports."""
    return
