# 01-minimal-scale

**Phase 1** denseness probe — pure-Aura large FlatAST construction + baseline metrology.

| | |
|--|--|
| **Axes** | A (scale completeness) · F (metrology) |
| **Escapes** | Must be 0 on the scale path |
| **Mutation / LLM** | Out of scope (later probes) |

## Claim

A realistic multi-define FlatAST (wide leaves + deep nest) can be:

1. Built as pure-Aura source text  
2. Installed into the workspace FlatAST via `set-code` + `eval-current`  
3. Observed (`ast:nodes`, `ast:defs`, `ast:generation`) and validated  
4. Sampled for closed-form correctness  

— all with **core \(E = 0\)**.

## Scale knobs (defaults)

| Knob | Default | Meaning |
|------|---------|---------|
| `N-LEAVES` | 200 | Independent `(define (f{i} x) (+ x i))` |
| `DEPTH` | 80 | Nested `(+ 1 …)` under `deep` |
| `MIN-NODES` | 1000 | Gate on FlatAST node count |

Empirically ≈ 1.4k nodes and ~1–2s install on current `aura-grok` host.

## Expected PASS shape

```
=== Prometheus 01-minimal-scale: pure-Aura FlatAST denseness ===
...
PASS: pure-Aura large FlatAST + metrology (escapes=0)
RESULT pass example=01-minimal-scale escapes=0 nodes=... defs=201 elapsed_ms=...
```

## Run

```bash
./scripts/run-aura.sh examples/01-minimal-scale/main.aura
```

## Notes

- Independent leaves avoid a host residual where some cross-define call chains after `set-code` mis-evaluate; depth stress uses a single nested expression instead.  
- Full `ast:nodes` list materialization is fine at this size; a count-only primitive may become a metered escape target at 1e5+ nodes (Axis E later).
