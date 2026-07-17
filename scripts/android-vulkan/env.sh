#!/data/data/com.termux/files/usr/bin/bash
# Source from launchers to make Android/Termux Vulkan lookup deterministic.
set -euo pipefail

BINDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TERMUX_PREFIX="${PREFIX:-/data/data/com.termux/files/usr}"

if [ ! -r /system/lib64/libvulkan.so ]; then
  echo "error: /system/lib64/libvulkan.so not found; Vulkan is unavailable on this device" >&2
  exit 1
fi

# Prefer artifact-local libs, then Android's Vulkan loader, then Termux libs.
export LD_LIBRARY_PATH="${BINDIR}:/system/lib64:${TERMUX_PREFIX}/lib:${LD_LIBRARY_PATH:-}"
