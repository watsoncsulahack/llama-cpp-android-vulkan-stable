#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

MODEL="${1:-${HOME}/models/gemma-4-E2B-it-qat-UD-Q4_K_XL.gguf}"
OUT="${2:-bench-gemma4-$(date -u +%Y%m%dT%H%M%SZ).txt}"

export LD_LIBRARY_PATH="${PWD}:/system/lib64:${PREFIX:-/data/data/com.termux/files/usr}/lib:${LD_LIBRARY_PATH:-}"

{
  date -u
  ./llama-bench \
    -m "${MODEL}" \
    -ngl 99 \
    -ctk f16 -ctv f16 \
    -b 256 -ub 32 \
    -fa off \
    -t 2 \
    -p 256 \
    -n 128 \
    -r 3
} | tee "${OUT}"
