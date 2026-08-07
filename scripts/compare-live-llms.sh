#!/usr/bin/env bash
# Compare live propose edge: MiniMax-M3 vs deepseek-v4-flash.
#
# Uses curl (scripts/live-chat.sh) for HTTPS to avoid Aura host residual H4
# (aura-llm-call recursion after heavy module load). Probe then schema-gates
# and executes the wire on a real scale FlatAST.
#
# Usage (from repo root):
#   ./scripts/compare-live-llms.sh

set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

run_one() {
  local name="$1"
  local env_script="$2"
  local log="/tmp/prom-live-${name}.log"
  local wire="/tmp/prom-wire-${name}.txt"
  local meta="/tmp/prom-meta-${name}.txt"
  echo "======== $name ========"
  set +e
  (
    # shellcheck disable=SC1090
    source "$env_script"
    export PROMETHEUS_LLM_PROPOSE=live
    echo "[chat] model=$LLM_MODEL base=$LLM_BASE_URL"
    t0=$(python3 -c 'import time; print(int(time.time()*1000))')
    if ./scripts/live-chat.sh >"$wire" 2>"$meta"; then
      t1=$(python3 -c 'import time; print(int(time.time()*1000))')
      chat_ms=$((t1 - t0))
      # single line only; base64 avoids shell metachar issues in env
      wire_text=$(tr -d '\r' <"$wire" | head -n 1)
      echo "[chat] ok ms=$chat_ms wire=$wire_text"
      cat "$meta" || true
      export PROMETHEUS_LLM_WIRE="$wire_text"
      export PROMETHEUS_LLM_CHAT_MS="$chat_ms"
      ./scripts/run-aura.sh examples/05-live-propose/main.aura
    else
      t1=$(python3 -c 'import time; print(int(time.time()*1000))')
      chat_ms=$((t1 - t0))
      echo "[chat] FAIL ms=$chat_ms"
      cat "$meta" || true
      unset PROMETHEUS_LLM_WIRE || true
      export PROMETHEUS_LLM_CHAT_MS="$chat_ms"
      ./scripts/run-aura.sh examples/05-live-propose/main.aura
    fi
  ) >"$log" 2>&1
  ec=$?
  set -e
  echo "exit=$ec log=$log"
  rg -n "RESULT |PASS|FAIL|chat |P1-src|P1-exec|model=|parsed=|provider=|LIVE_META|wire=" "$log" | head -50 || true
  echo
}

run_one "minimax-m3" "$ROOT/scripts/env-minimax.sh"
run_one "deepseek-v4-flash" "$ROOT/scripts/env-deepseek.sh"

echo "======== comparison summary ========"
printf "%-22s | %-12s | %-10s | %s\n" "provider" "result" "chat_ms" "detail"
for name in minimax-m3 deepseek-v4-flash; do
  log="/tmp/prom-live-${name}.log"
  res=$(rg -o "RESULT (pass_soft|pass|fail)[^\n]*" "$log" | tail -1 || echo "RESULT missing")
  # compact
  echo "$name | $res"
done
