#!/usr/bin/env bash
# Longer denseness soak ladder (06–08). Not required for PR CI.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

PROBES=(
  06-scale-soak
  07-long-n-50
  08-long-n-100
)

pass=0
fail=0
for p in "${PROBES[@]}"; do
  echo "======== $p ========"
  if ./scripts/run-aura.sh "examples/$p/main.aura" 2>&1 | tee "/tmp/prom-$p.log" | tail -10; then
    if rg -q "RESULT pass" "/tmp/prom-$p.log" 2>/dev/null || grep -q "RESULT pass" "/tmp/prom-$p.log"; then
      pass=$((pass + 1))
    else
      fail=$((fail + 1))
      echo "FAIL: no RESULT pass for $p" >&2
    fi
  else
    fail=$((fail + 1))
  fi
done

echo "======== overnight summary ========"
echo "pass=$pass fail=$fail total=${#PROBES[@]}"
[[ "$fail" -eq 0 ]]
