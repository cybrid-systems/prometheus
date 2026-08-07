# Prometheus lib

Composable denseness helpers. Prefer these modules from probes; do not fork Aura engine code.

| Module | Axes | Role |
|--------|------|------|
| `prometheus-measure.aura` | F | Process hash stats, wall-time, correctness checks |
| `prometheus-scale.aura` | A | Large FlatAST builders + install + observe |
| `prometheus-mutate.aura` | B | Continuous rebind, poison/restore, safety |
| `prometheus-cost.aura` | C | Incremental cost envelope (gen/relower/dirty/jit) |
| `prometheus-min.aura` | A–C F | Facade re-export for Phase 1–3 probes |
| `prometheus-llm.aura` | D | *(planned)* propose-edge schema / wire helpers |
| `prometheus-escape.aura` | E | *(planned)* escape metering helpers |

Host resolution: `scripts/run-aura.sh` sets `AURA_PATH` to `../aura-grok/lib:./lib`.

```scheme
(require "prometheus-min" all:)
```

## Surfaces by phase

- **Phase 1:** leaves + deep nest → `set-code` FlatAST; `stats:get` node/def/gen  
- **Phase 2:** backdrop + `subject` lambda; continuous `mutate:rebind`; poison/`ast:restore`  
- **Phase 3:** before/after cost snapshot + deltas; partial relower, dirty ratio, gen bump, latency  

Timing uses host `(monotonic-ms)`. Sample rebind results inside continuous helpers (H3).
