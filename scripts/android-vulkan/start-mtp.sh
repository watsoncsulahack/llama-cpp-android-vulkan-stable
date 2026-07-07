#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

MODEL="${1:-${HOME}/models/gemma-4-E2B-it-qat-UD-Q4_K_XL.gguf}"
shift || true

export LD_LIBRARY_PATH="${PWD}:/system/lib64:${PREFIX:-/data/data/com.termux/files/usr}/lib:${LD_LIBRARY_PATH:-}"

exec ./llama-server \
  -m "${MODEL}" \
  -ctk f16 -ctv f16 \
  -b 256 -ub 32 \
  -fa off \
  -cram 0 \
  -ngl 99 \
  -t 2 \
  -np 1 \
  --no-cont-batching \
  --spec-type draft-mtp \
  --spec-draft-n-max 2 \
  --jinja \
  "$@"
