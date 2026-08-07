# \(S_{\mathrm{Prometheus}}\) denseness report

**Date:** 2026-08-07  
**Host:** Aura (local `aura-grok`)  
**Surface:** `prometheus-min` · measure · scale · mutate · cost  
**Status:** Phase 1–3 probes landed; denseness judgment **partial** (A+B+C+F)

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
| **A** Scale completeness | Large FlatAST mostly in \(V_A\)? | **01–03** |
| **B** Continuous mutation | High-frequency typed mutate still correct? | **02–03** — 25–30/30 rebind rounds |
| **C** Incremental performance | Cascade / re-lower / cache decision-grade? | **03** — partial-relower Δ, dirty ratio, gen bump, latency |
| **D** LLM interaction surface | query + mutate + workspace dense enough? | TBD |
| **E** Scale boundary | True escapes isolated & metered? | TBD |
| **F** Metrology | Escape rate, cost regression, dual rollback | **01–03** |

---

## Constructive evidence

| Probe | Axes | Result | Core \(E\) | Edge \(E\) |
|-------|------|--------|------------|------------|
| [01-minimal-scale](../examples/01-minimal-scale/) | A F | **PASS** (~1444 nodes) | 0 | 0 |
| [02-continuous-mutate](../examples/02-continuous-mutate/) | A B F | **PASS** (30 rounds + poison/restore) | 0 | 0 |
| [03-incremental-cost](../examples/03-incremental-cost/) | A B C F | **PASS** (25 rounds; envelope decision-grade) | 0 | 0 |

### 03 narrative (Axis C)

Representative deltas under 25 rebind rounds (N=100 leaves):

| Metric Δ | Example | Meaning |
|----------|---------|---------|
| `partial_relower_hits` | +2500 | Incremental path active |
| `full_fallbacks` | +50 | Present but not dominating partial |
| `gen_bump_total` | +25 | Generation tracks rounds |
| `relower_instr_skip` / `insts_saved` | +16800 | Clean-path savings visible |
| `dirty_ratio_den` | +10050 | Dirty metrology first-class |
| `cascade_body_only` | +25 | Body-scoped cascade |
| `cascade_full` | 0 | No full cascade storm |
| avg ms/round | ~43 | Latency envelope measurable |

Correctness 25/25; validate nodes/ownership pass; core \(E=0\).

---

## Judgment

**Partial.** On the Phase 1–3 slice of \(S_{\mathrm{Prometheus}}\) (scale FlatAST + continuous typed rebind + observable incremental envelope), \(V_A\) is dense for the evolvable core with **core \(E=0\)**.

LLM propose edge (D), scale-boundary metering (E), and multi-N soak judgment remain open.

---

## How to reproduce

```bash
./scripts/check-structure.sh
./scripts/run-all.sh
```
