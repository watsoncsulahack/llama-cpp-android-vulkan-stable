#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

MODEL="${1:-${HOME}/models/gemma-4-E2B-it-qat-UD-Q4_K_XL.gguf}"
shift || true

export LD_LIBRARY_PATH="${PWD}:/system/lib64:${PREFIX:-/data/data/com.termux/files/usr}/lib:${LD_LIBRARY_PATH:-}"

exec ./llama-server \
  -m "${MODEL}" \
  -ctk q8_0 -ctv q8_0 \
  -b 512 -ub 64 \
  -fa auto \
  -cram 800 \
  -ngl 99 \
  -t 2 \
  -np 1 \
  --jinja \
  "$@"
