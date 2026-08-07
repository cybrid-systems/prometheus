# \(S_{\mathrm{Prometheus}}\) denseness report

**Date:** 2026-08-07  
**Host:** Aura (local `aura-grok`)  
**Surface:** `prometheus-min` · `prometheus-measure` · `prometheus-scale` · `prometheus-mutate`  
**Status:** Phase 1–2 probes landed; denseness judgment **partial** (A+B+F)

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
| **A** Scale completeness | Large FlatAST mostly in \(V_A\)? | **01** ~1.4k nodes; **02** ~700–900 nodes backdrop under mutate |
| **B** Continuous mutation | High-frequency typed mutate + dirty still correct? | **02** — 30/30 rebind rounds, leaves intact, poison+restore |
| **C** Incremental performance | Cascade / re-lower / cache decision-grade at scale? | TBD (gen observed; cost envelope not yet decision-grade probe) |
| **D** LLM interaction surface | query + mutate + workspace dense enough? | TBD |
| **E** Scale boundary | True escapes isolated & metered? | TBD (H2 count-only prim note) |
| **F** Metrology | Escape rate, cost regression, dual rollback | **01**/**02** — stats, elapsed_ms, mut log, rollback_ok |

---

## Constructive evidence

| Probe | Axes | Result | Core \(E\) | Edge \(E\) |
|-------|------|--------|------------|------------|
| [01-minimal-scale](../examples/01-minimal-scale/) | A F | **PASS** (N=200 leaves + depth=80, ~1444 nodes) | 0 | 0 |
| [02-continuous-mutate](../examples/02-continuous-mutate/) | A B F | **PASS** (120 leaves, 30 rebind rounds, poison+restore) | 0 | 0 |

### 01 narrative

- Pure-Aura builders emit independent leaf defines + one deep nest  
- `set-code` + `eval-current` installs workspace FlatAST  
- Observe via `stats:get` (`ast:nodes` / `ast:defs` / `ast:generation`)  
- `ast:validate-nodes` + `ast:validate-ownership` pass  
- Closed-form samples: `(f{i} 0)=i`, `(deep 0)=depth`  

### 02 narrative

- Backdrop leaves + mutable `(define subject (lambda …))`  
- Continuous `mutate:rebind` alternating `*3` / `*5` for 30 rounds  
- Each round: subject closed form + leaf integrity  
- Poison `*99` then `ast:restore` → subject back to triple; leaves intact  
- `mutate:summary` total ≥ rounds; generation advances; core \(E=0\)  

---

## Judgment

**Partial.** On the Phase 1–2 slice of \(S_{\mathrm{Prometheus}}\) (construct large FlatAST + continuous typed rebind with restore), \(V_A\) is dense for the scale and continuous-edit paths with **core \(E=0\)**.

Incremental cost semantics (Axis C), LLM propose edge (D), and soak judgment remain open.

---

## How to reproduce

```bash
./scripts/check-structure.sh
./scripts/run-aura.sh examples/01-minimal-scale/main.aura
./scripts/run-aura.sh examples/02-continuous-mutate/main.aura
./scripts/run-all.sh
```
