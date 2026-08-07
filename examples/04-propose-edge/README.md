# 04-propose-edge

**Phase 4** denseness probe — LLM propose edge isolation (schema / wire / stub).

| | |
|--|--|
| **Axes** | A · B · **D** · **E** · F |
| **Live LLM API** | **Not required** for PASS |
| **Core \(E\)** | 0 on rule path |
| **Edge \(E\)** | ≥1 for stub / wire-sim (metered) |

## Do we need a live LLM API now?

**No.** Denseness for \(S_{\mathrm{Prometheus}}\) is proven by:

1. **Rule propose** (pure Aura, \(E=0\)) → schema → rebind → verify  
2. **Schema refuse** of bad kind / body / target (no silent mutate)  
3. **Wire parse** of simulated LLM text → schema → exec / refuse  
4. **Stub** propose that meters edge escape but keeps core pure  

Live HTTPS (`PROMETHEUS_LLM_PROPOSE=live` + `LLM_API_KEY`) is an **optional** product pressure test, same posture as Aether example 09 — not a gate for partial denseness.

## Claim

External proposals never reach `mutate:rebind` without schema; illegal bodies and wrong targets are refused; wire garbage does not corrupt the scale FlatAST; edge escapes are metered separately from core \(E\).

## Wire format

```
MUTATE|subject|(lambda (x) (* x N))|summary
SKIP|subject||summary
```

`N ∈ {2,3,5,7}` (plus internal poison `99` for restore tests elsewhere). Name must be `subject`.

## Expected PASS

```
PASS: propose edge isolated (rule E=0; stub/wire edge E metered)
RESULT pass example=04-propose-edge escapes=... mode=rule live_required=no
```

## Run

```bash
# Offline denseness (default)
./scripts/run-aura.sh examples/04-propose-edge/main.aura

# Optional live (not part of default suite requirements)
PROMETHEUS_LLM_PROPOSE=live LLM_API_KEY=... ./scripts/run-aura.sh examples/04-propose-edge/main.aura
```
