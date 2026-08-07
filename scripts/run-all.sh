#!/usr/bin/env bash
# Run offline denseness suite. Requires Aura binary.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

PROBES=(
  01-minimal-scale
  02-continuous-mutate
  03-incremental-cost
  04-propose-edge
  06-scale-soak
  07-long-n-50
  08-long-n-100
  09-propose-under-soak
  10-dual-subject
)

pass=0
fail=0
failed_list=()

for p in "${PROBES[@]}"; do
  echo "======== $p ========"
  if ./scripts/run-aura.sh "examples/$p/main.aura" 2>&1 | tee "/tmp/prom-$p.log" | tail -8; then
    if rg -q "RESULT pass" "/tmp/prom-$p.log" 2>/dev/null || grep -q "RESULT pass" "/tmp/prom-$p.log"; then
      pass=$((pass + 1))
    else
      fail=$((fail + 1))
      failed_list+=("$p")
      echo "FAIL: no RESULT pass line for $p" >&2
    fi
  else
    fail=$((fail + 1))
    failed_list+=("$p")
  fi
done

echo "======== summary ========"
echo "pass=$pass fail=$fail total=${#PROBES[@]}"
if [[ "$fail" -ne 0 ]]; then
  echo "failed: ${failed_list[*]}" >&2
  exit 1
fi
echo "ALL PASS"
