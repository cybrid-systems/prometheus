# Prometheus lib

Composable denseness helpers. Prefer these modules from probes; do not fork Aura engine code.

| Module | Axes | Role |
|--------|------|------|
| `prometheus-measure.aura` | F | Process hash stats, wall-time, correctness checks |
| `prometheus-scale.aura` | A | Large FlatAST builders + install + observe |
| `prometheus-mutate.aura` | B | Continuous rebind, poison/restore, safety |
| `prometheus-min.aura` | A B F | Facade re-export for Phase 1–2 probes |
| `prometheus-llm.aura` | D | *(planned)* propose-edge schema / wire helpers |
| `prometheus-escape.aura` | E | *(planned)* escape metering helpers |

Host resolution: `scripts/run-aura.sh` sets `AURA_PATH` to `../aura-grok/lib:./lib`.

```scheme
(require "prometheus-min" all:)
```

## Scale subject shape (Phase 1)

- **Wide:** N independent leaves `(define (f{i} x) (+ x i))` — closed form `(f{i} 0) = i`
- **Deep:** one nest `(define (deep x) (+ 1 (+ 1 ... x)))` — closed form `(deep 0) = depth`
- Installed via pure-Aura `set-code` + `eval-current` into workspace FlatAST
- Observed via host `stats:get` (`ast:nodes`, `ast:defs`, `ast:generation`) and `ast:validate-*`

## Mutation subject shape (Phase 2)

- Backdrop leaves + `(define subject (lambda (x) (* x 2)))`
- Continuous path: `mutate:safe-yield` → `mutate:rebind` → `eval-current`
- Alternating bodies `*3` / `*5`; poison `*99` + `ast:restore`
- Correctness samples taken **inside** continuous helpers (see host residual H3)

Timing uses host `(monotonic-ms)`.
