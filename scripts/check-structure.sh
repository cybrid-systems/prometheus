#!/usr/bin/env bash
# Structural sanity check (no Aura binary required).
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

missing=0
for f in README.md LICENSE notes/aura-unify.md notes/denseness-report.md notes/escape-log.md notes/host-residuals.md prompts/GROK.md scripts/run-aura.sh; do
  if [[ ! -e "$f" ]]; then
    echo "MISSING: $f"
    missing=1
  fi
done

if [[ $missing -eq 0 ]]; then
  echo "OK: prometheus structure present"
else
  echo "FAIL: structure incomplete"
  exit 1
fi
