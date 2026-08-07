# \(S_{\mathrm{Prometheus}}\) denseness report

**Date:** 2026-08-07  
**Host:** Aura (local `aura-grok`)  
**Surface:** measure · scale · mutate · cost · llm  
**Status:** Phase 1–5 complete  
**Judgment:** on scoped \(S_{\mathrm{Prometheus}}\), \(V_A\) is **practically dense** for the evolvable / editable core, with controlled metered edge \(E\).

---

## Claim under test

On \(S_{\mathrm{Prometheus}}\) (large-scale FlatAST under continuous LLM-driven typed mutation with incremental compilation as first-class semantics), the **evolvable / editable core** can stay in pure Aura (\(V_A\)) with controlled, metered escapes \(E\) confined to the world / propose edge or true scale limits.

\[
P \approx A \oplus E,\quad A \in V_A
\]

Prometheus does **not** claim denseness over all of \(S_{\mathrm{practical}}\).

---

## Axis coverage

| Axis | Question | Evidence |
|------|----------|----------|
| **A** Scale completeness | Large FlatAST mostly in \(V_A\)? | **01**, **06–08** — up to ~1.4k nodes under soak |
| **B** Continuous mutation | High-frequency typed mutate still correct? | **02**, **06–08** — 25/50/**100**/100 rebind rounds |
| **C** Incremental performance | Cascade / re-lower decision-grade? | **03**, **06–08** — partial relower, gen bump, latency |
| **D** LLM interaction surface | query + mutate + workspace dense enough? | **04** schema/wire/stub; **05** live MiniMax + DeepSeek |
| **E** Scale / world boundary | Escapes isolated & metered? | **04–05** edge \(E\); core soak \(E=0\) |
| **F** Metrology | Escape rate, cost, dual rollback | all probes + stats alists |

---

## Constructive evidence

| Probe | Axes | Result | Core \(E\) | Edge \(E\) |
|-------|------|--------|------------|------------|
| [01-minimal-scale](../examples/01-minimal-scale/) | A F | **PASS** ~1444 nodes | 0 | 0 |
| [02-continuous-mutate](../examples/02-continuous-mutate/) | A B F | **PASS** 30 rounds + poison/restore | 0 | 0 |
| [03-incremental-cost](../examples/03-incremental-cost/) | A B C F | **PASS** envelope decision-grade | 0 | 0 |
| [04-propose-edge](../examples/04-propose-edge/) | A B D E F | **PASS** rule/schema/wire/stub | 0 | ≥1 stub/wire |
| [05-live-propose](../examples/05-live-propose/) | A B D E F | **PASS** MiniMax-M3 + deepseek-v4-flash *(opt-in)* | 0 | ≥1 HTTPS |
| [06-scale-soak](../examples/06-scale-soak/) | A B C F | **PASS** N=25, avg ~28ms/round | 0 | 0 |
| [07-long-n-50](../examples/07-long-n-50/) | A B C F | **PASS** N=50, avg ~44ms/round | 0 | 0 |
| [08-long-n-100](../examples/08-long-n-100/) | A B C F | **PASS** N=100, avg ~105ms/round | 0 | 0 |
| [09-propose-under-soak](../examples/09-propose-under-soak/) | A B D F | **PASS** rule propose × 20 soak rounds | 0 | 0 |
| [10-dual-subject](../examples/10-dual-subject/) | A B F | **PASS** dual-name isolation + 16 alt rebinds | 0 | 0 |

### Soak ladder

| Rung | Leaves | Rounds | elapsed_ms | avg_ms | Core \(E\) |
|------|--------|--------|------------|--------|------------|
| 06 | 100 | 25 | ~700 | ~28 | 0 |
| 07 | 120 | 50 | ~2200 | ~44 | 0 |
| 08 | 150 | 100 | ~10600 | ~105 | 0 |

All rungs: continuous closed-form verify, incremental envelope active, poison+restore, validate nodes/ownership, **escapes=0**.

### Live propose (opt-in)

| Provider | Model | chat_ms | Result |
|----------|-------|---------|--------|
| MiniMax | MiniMax-M3 | ~3.9s | PASS commit got=21 |
| DeepSeek | deepseek-v4-flash | ~2.4s | PASS commit got=21 |

HTTPS via curl harness (H4); schema/execute pure Aura.

---

## Judgment

> On scoped \(S_{\mathrm{Prometheus}}\), \(V_A\) is **practically dense** for the evolvable / editable core.  
> Scale FlatAST construction, continuous typed rebind through **N=100**, dual-subject isolation, propose-under-soak, decision-grade incremental metrology, propose-edge isolation (offline + live), and dual rollback all hold with **core \(E=0\)**.  
> World / LLM edges are **metered and schema-gated**.

Constructive denseness only — not a proof over all large-program editors or hard realtime IDEs.

### Failure modes checked

| Pre-declared failure | Status |
|----------------------|--------|
| Continuous edit requires unguarded external AST tools | **Not observed** on core path |
| Mutation at scale breaks dirty / correctness | **Not observed** through N=100 |
| Incremental perf only by abandoning observability | **Not observed** — envelope first-class |

---

## How to reproduce

```bash
./scripts/check-structure.sh
./scripts/run-all.sh              # offline 01–04, 06–08
./scripts/overnight-scale.sh      # soak ladder only
./scripts/compare-live-llms.sh    # opt-in live MiniMax + DeepSeek
```
