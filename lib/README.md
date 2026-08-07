# Prometheus lib

Composable denseness helpers. Prefer these modules from probes; do not fork Aura engine code.

| Module | Axes | Role |
|--------|------|------|
| `prometheus-measure.aura` | F | Process hash stats, wall-time, correctness checks |
| `prometheus-scale.aura` | A | Large FlatAST builders + install + observe |
| `prometheus-mutate.aura` | B | Continuous rebind, poison/restore, safety |
| `prometheus-cost.aura` | C | Incremental cost envelope (gen/relower/dirty/jit) |
| `prometheus-llm.aura` | D E | Propose edge: schema / wire / stub / live(opt) |
| `prometheus-min.aura` | A–F | Facade re-export for Phase 1–4 probes |
| `prometheus-escape.aura` | E | *(optional later)* extra escape helpers |

Host resolution: `scripts/run-aura.sh` sets `AURA_PATH` to `../aura-grok/lib:./lib`.

```scheme
(require "prometheus-min" all:)
; or thin: (require "prometheus-llm" all:)
```

## Propose edge (Phase 4)

- Wire: `MUTATE|subject|(lambda (x) (* x N))|summary` with `N∈{2,3,5,7}`
- Schema refuses bad kind / non-`subject` target / illegal body before rebind
- Modes: `PROMETHEUS_LLM_PROPOSE=rule|stub|live` (default **rule**, offline)
- Live needs `LLM_API_KEY`; denseness suite does **not** require it
