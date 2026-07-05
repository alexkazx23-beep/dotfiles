#!/usr/bin/env python3

from pathlib import Path
from datetime import datetime
import argparse
import shutil
import re
import sys

NORMAL = Path("/etc/pacman.d/cachyos-mirrorlist")
V4 = Path("/etc/pacman.d/cachyos-v4-mirrorlist")


def die(msg):
    print(f"Error: {msg}", file=sys.stderr)
    sys.exit(1)


parser = argparse.ArgumentParser(
    description="Sync CachyOS v4 mirrorlist order with cachyos-mirrorlist"
)
parser.add_argument(
    "--apply",
    action="store_true",
    help="Write changes to cachyos-v4-mirrorlist"
)

args = parser.parse_args()

if not NORMAL.exists():
    die(f"{NORMAL} not found")

if not V4.exists():
    die(f"{V4} not found")

normal_lines = NORMAL.read_text(encoding="utf-8").splitlines()
v4_lines = V4.read_text(encoding="utf-8").splitlines()

# ----------------------------
# Read ordered hosts
# ----------------------------

ordered_hosts = []

for line in normal_lines:
    if line.startswith("Server"):
        url = line.split("=", 1)[1].strip()
        host = re.sub(r"/repo/\$arch/\$repo$", "", url)
        ordered_hosts.append(host)

if not ordered_hosts:
    die("No Server entries found in cachyos-mirrorlist")

# ----------------------------
# Parse v4 mirror blocks
# ----------------------------

entries = []
pending = []

for line in v4_lines:

    if line.startswith("Server"):
        server = line.split("=", 1)[1].strip()
        host = re.sub(r"/repo/\$arch_v4/\$repo$", "", server)

        pending.append(line)

        entries.append({
            "host": host,
            "block": pending
        })

        pending = []

    else:
        pending.append(line)

tail = pending

host_map = {e["host"]: e for e in entries}

result = []
used = set()

missing = []

for host in ordered_hosts:
    if host in host_map:
        result.extend(host_map[host]["block"])
        used.add(host)
    else:
        missing.append(host)

remaining = 0

for e in entries:
    if e["host"] not in used:
        remaining += 1
        result.extend(e["block"])

result.extend(tail)

if not result:
    die("Generated mirrorlist is empty!")

text = "\n".join(result).rstrip() + "\n"

print(f"Matched mirrors : {len(used)}")
print(f"Remaining       : {remaining}")
print(f"Missing         : {len(missing)}")

if missing:
    print("\nThese mirrors were not found in v4 mirrorlist:")
    for m in missing:
        print("  -", m)

if not args.apply:
    print("\nDry run complete.")
    print("Nothing was written.")
    sys.exit(0)

backup = V4.with_suffix(
    V4.suffix + ".bak." + datetime.now().strftime("%Y%m%d-%H%M%S")
)

shutil.copy2(V4, backup)
V4.write_text(text, encoding="utf-8")

print(f"\nBackup created: {backup}")
print(f"Updated: {V4}")
