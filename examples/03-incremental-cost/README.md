# 03-incremental-cost

**Phase 3** denseness probe — decision-grade incremental cost metrology under continuous rebind.

| | |
|--|--|
| **Axes** | A · B · **C** · F |
| **Escapes** | Must be 0 |
| **Focus** | generation, partial relower, dirty ratio, per-round latency |

## Claim

On a large FlatAST under continuous typed rebind, pure-Aura composition of host metrics makes the **incremental performance envelope** observable and decision-grade:

1. Generation advances with mutations (`ast:generation-stats`)  
2. Partial relower / instruction-skip / insts-saved activity is visible  
3. Dirty block ratio denominators move (mutate group)  
4. Full fallbacks do not dominate partial hits  
5. Per-round latency is measurable; correctness remains 100%  
6. Core \(E = 0\)

## Surfaces (host, composed)

| Source | Keys used |
|--------|-----------|
| `ast:generation-stats` | `current-generation`, `bump-generation-total` |
| `query:compiler-core-incremental-stats` | `partial-relower-hits`, `full-fallbacks`, `impact-blocks` |
| `query:incremental-closure-stats` | `blocks-relowered`, `jit-sync-count` |
| `engine:metrics :group compile` | relower skip/saved/fallback, cascade counts |
| `engine:metrics :group jit` | partial recompile, cache evictions, hotswap |
| `engine:metrics :group mutate` | dirty block ratio num/den, hold duration |

## Knobs

| Knob | Default |
|------|---------|
| `N-LEAVES` | 100 |
| `ROUNDS` | 25 |

## Expected PASS

```
PASS: incremental cost envelope decision-grade (escapes=0)
RESULT pass example=03-incremental-cost escapes=0 rounds=25 ...
```

## Run

```bash
./scripts/run-aura.sh examples/03-incremental-cost/main.aura
```
