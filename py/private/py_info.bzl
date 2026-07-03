"""The `PyInfo` provider produced and consumed by rules_py targets.

`PyInfo` carries the information rules_py needs to assemble a target's dependency
closure: the transitive set of first-party Python sources, the import roots to
place on `sys.path`, and the virtual-dependency declarations and their
resolutions. Targets in a dependency graph aggregate these fields from their
deps to build the eventual venv or wheel.

Defined here in one module and re-exported from `//py:defs.bzl` as public API.

rules_py can *consume* deps built by `@rules_python` (e.g. a `py_proto_library`),
which expose `@rules_python`'s `PyInfo` rather than this one. Rules that ingest
`deps` handle that at the API edge by also reading `@rules_python`'s `PyInfo`.
(The reverse — a `@rules_python` rule consuming a rules_py target — is not
supported: rules_py does not emit `@rules_python`'s `PyInfo`.)
"""

PyInfo = provider(
    doc = "Python source, import-path, and virtual-dependency information for a target's dependency closure.",
    fields = {
        "transitive_sources": "depset[File] — postorder depset of first-party `.py` sources in the transitive closure.",
        "imports": "depset[str] — import roots to place on `sys.path` (rlocation-root-relative).",
        "virtual_dependencies": "depset[str] — names of required virtual dependencies, independent of their resolution status.",
        "virtual_resolutions": "depset[struct(virtual, target)] — virtual-dependency-name to concrete-target resolutions.",
    },
)
