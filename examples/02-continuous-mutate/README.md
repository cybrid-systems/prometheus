# 02-continuous-mutate

**Phase 2** denseness probe — continuous typed mutation on a large FlatAST backdrop.

| | |
|--|--|
| **Axes** | A (scale backdrop) · B (continuous mutation) · F (metrology) |
| **Escapes** | Must be 0 on the continuous-edit path |
| **LLM** | Out of scope (later probes) |

## Claim

Under a multi-define workspace FlatAST (≈100+ leaves + mutable `subject`):

1. High-frequency `mutate:rebind` + `eval-current` keeps `subject` closed-form correct  
2. Backdrop leaves stay intact each round  
3. Poison rebind + `ast:restore` recovers the known-good subject body  
4. Generation / mutation-log metrology remains observable  
5. Core \(E = 0\)

## Scale knobs (defaults)

| Knob | Default | Meaning |
|------|---------|---------|
| `N-LEAVES` | 120 | Independent leaf defines (backdrop) |
| `ROUNDS` | 30 | Alternating `*3` / `*5` rebind rounds |
| `SAMPLE-ARG` | 7 | Argument for closed-form checks |

## Expected PASS shape

```
=== Prometheus 02-continuous-mutate: typed rebind on large FlatAST ===
...
PASS: continuous typed mutate on large FlatAST (escapes=0)
RESULT pass example=02-continuous-mutate escapes=0 rounds=30 nodes=... gen=... elapsed_ms=...
```

## Run

```bash
./scripts/run-aura.sh examples/02-continuous-mutate/main.aura
```

## Notes

- Mutable target is a single lambda value binding `(define subject (lambda ...))` — Aether/Hephaestus rebind pattern; avoids cross-define call residual (H1).  
- Correctness samples for rebind are taken **inside** the continuous/poison while helpers (host residual H3: top-level forms after rebind can see stale `subject`).  
- Snapshots are used for poison/restore, not every continuous round (cost).
