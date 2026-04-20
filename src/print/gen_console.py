import os

# (short_name, event_type, fn_type)
# event_type  -> no "memory" keyword  (Solidity events don't allow it)
# fn_type     -> with "memory" for reference types (functions require it)
types = [
    ("string",  "string",  "string memory"),
    ("uint",    "uint",    "uint"),
    ("int",     "int",     "int"),
    ("address", "address", "address"),
    ("bool",    "bool",    "bool"),
    ("bytes32", "bytes32", "bytes32"),
    ("bytes",   "bytes",   "bytes memory"),
]

short = {
    "string":  "String",
    "uint":    "Uint",
    "int":     "Int",
    "address": "Address",
    "bool":    "Bool",
    "bytes32": "Bytes32",
    "bytes":   "Bytes",
}

lines = []
lines.append("// SPDX-License-Identifier: MIT")
lines.append("pragma solidity ^0.8.21;")
lines.append("")
lines.append("library console {")
lines.append("")

functions_1 = []
functions_2 = []
functions_3 = []

# 1-param
for t1, ev1, fn1 in types:
    ev = f"Log{short[t1]}"
    functions_1.append((ev, [(t1, ev1, fn1, "a")]))

# 2-param
for t1, ev1, fn1 in types:
    for t2, ev2, fn2 in types:
        ev = f"Log{short[t1]}{short[t2]}"
        functions_2.append((ev, [(t1, ev1, fn1, "a"), (t2, ev2, fn2, "b")]))

# 3-param
for t1, ev1, fn1 in types:
    for t2, ev2, fn2 in types:
        for t3, ev3, fn3 in types:
            ev = f"Log{short[t1]}{short[t2]}{short[t3]}"
            functions_3.append((ev, [(t1, ev1, fn1, "a"), (t2, ev2, fn2, "b"), (t3, ev3, fn3, "c")]))

all_functions = functions_1 + functions_2 + functions_3

# Unique events (preserve insertion order)
unique_events = {}
for ev, params in all_functions:
    if ev not in unique_events:
        unique_events[ev] = params

# Emit events (use event_type — no "memory")
lines.append("    // Events")
for ev, params in unique_events.items():
    param_str = ", ".join(ev_t for _, ev_t, _, _ in params)
    lines.append(f"    event {ev}({param_str});")

lines.append("")

# Helper: emit one function (use fn_type — with "memory")
def emit_fn(ev, params):
    sig_parts = [f"{fn_t} {name}" for _, _, fn_t, name in params]
    sig  = ", ".join(sig_parts)
    args = ", ".join(name for _, _, _, name in params)
    return [
        f"    function log({sig}) internal {{",
        f"        emit {ev}({args});",
        f"    }}",
    ]

# Single param
lines.append("    // Single param")
for ev, params in functions_1:
    lines.extend(emit_fn(ev, params))

lines.append("")

# Double params
lines.append("    // Double params")
for ev, params in functions_2:
    lines.extend(emit_fn(ev, params))

lines.append("")

# Triple params
lines.append("    // Triple params")
for ev, params in functions_3:
    lines.extend(emit_fn(ev, params))

lines.append("}")

output = "\n".join(lines)

# this will compile in console_temp.sol if the code is correct change the rename to consol.sol
out_path = os.path.join(os.path.dirname(os.path.abspath(__file__)), "console_temp.sol")
with open(out_path, "w") as f:
    f.write(output)

print(f"Output written to: {out_path}")
print(f"1-param functions : {len(functions_1)}")
print(f"2-param functions : {len(functions_2)}")
print(f"3-param functions : {len(functions_3)}")
print(f"Total functions   : {len(all_functions)}")
print(f"Unique events     : {len(unique_events)}")
print(f"Total lines       : {len(lines)}")