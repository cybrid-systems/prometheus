#!/usr/bin/env bash
# Run all offline denseness probes (to be filled as examples land).
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

echo "[prometheus] no probes landed yet — skeleton only"
echo "Add examples/NN-*/main.aura and list them here."
