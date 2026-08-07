#!/usr/bin/env bash
# Source MiniMax credentials for Prometheus live propose edge.
#
# Usage:
#   source ./scripts/env-minimax.sh
#   PROMETHEUS_LLM_PROPOSE=live ./scripts/run-aura.sh examples/05-live-propose/main.aura
#
# Key file: ~/code/keys/minimax
# Endpoint: https://api.minimaxi.com/v1  (OpenAI-compatible; M3 model)

set -euo pipefail

KEY_FILE="${MINIMAX_KEY_FILE:-$HOME/code/keys/minimax}"
if [[ ! -f "$KEY_FILE" ]]; then
  echo "error: MiniMax key file not found: $KEY_FILE" >&2
  return 1 2>/dev/null || exit 1
fi

_raw="$(tr -d '\r\n' < "$KEY_FILE" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')"
if [[ "$_raw" == *=* ]]; then
  export LLM_API_KEY="${_raw#*=}"
else
  export LLM_API_KEY="$_raw"
fi
unset _raw

# Force provider defaults (do not inherit a previous provider's MODEL/BASE).
export LLM_BASE_URL="https://api.minimaxi.com/v1"
export LLM_MODEL="MiniMax-M3"
export PROMETHEUS_LLM_PROPOSE=live
export PROMETHEUS_LLM_PROVIDER=minimax

echo "env-minimax: LLM_MODEL=$LLM_MODEL LLM_BASE_URL=$LLM_BASE_URL PROMETHEUS_LLM_PROPOSE=$PROMETHEUS_LLM_PROPOSE key=set"
