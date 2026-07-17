#!/data/data/com.termux/files/usr/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

MODEL="${1:-${HOME}/models/gemma-4-E2B-it-qat-UD-Q4_K_XL.gguf}"
shift || true

source ./env.sh
export GGML_VK_DISABLE_FUSION="${GGML_VK_DISABLE_FUSION:-1}"
export GGML_VK_DISABLE_GRAPH_OPTIMIZE="${GGML_VK_DISABLE_GRAPH_OPTIMIZE:-1}"
export GGML_VK_DISABLE_INTEGER_DOT_PRODUCT="${GGML_VK_DISABLE_INTEGER_DOT_PRODUCT:-1}"

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
  --spec-type none \
  --jinja \
  "$@"
