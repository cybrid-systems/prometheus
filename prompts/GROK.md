# GROK — Living prompt for Prometheus

You are helping advance **Prometheus**, the third concrete denseness probe of **Aura Unify**.

## Read first

1. [`notes/aura-unify.md`](../notes/aura-unify.md) — theory: unified semantic basis, span program, success conditions  
2. [`README.md`](../README.md) — \(S_{\mathrm{Prometheus}}\), axes A–F, phase plan  
3. Prior spans: `../aether/` and `../hephaestus/` denseness reports  
4. Host basis: `../aura-grok` (binary + `lib/std`)

Keep this prompt aligned with those docs when scope or phase changes.

---

## Context

- **Aura** (`../aura-grok`) is the AI-native Lisp runtime — basis \(V_A\).
- **Aether** already established practical denseness on agent + safe-mutation closed-loop \(S_{\mathrm{Aether}}\).
- **Hephaestus** already established practical denseness on performance / numerical / systems-kernel \(S_{\mathrm{Hephaestus}}\).
- **Prometheus** (this repo) pressure-tests the same basis on the **large-scale AST incremental compilation + continuous LLM mutation** subspace \(S_{\mathrm{Prometheus}}\).

You are **not** re-proving Aether or Hephaestus. You **may cite** their patterns (escape discipline, denseness metrics, probe layout) when they transfer.

---

## Core question

Can the evolvable / editable core of large FlatASTs under continuous LLM-driven typed mutation stay mostly inside \(V_A\), with only rare, metered escapes \(E\), while incremental compilation performance remains first-class and observable?

\[
P \approx A \oplus E,\quad A \in V_A
\]

Focus: scale, continuous mutation, dirty/cascade/generation, LLM interaction surface density, incremental cost metrology.

---

## Canonical loop

```
Load / Grow large AST  →  LLM Propose (schema-gated)  →  Typed Mutation  →
Dirty mark + Cascade   →  Selective re-lower / JIT    →  Observe cost metrics  →
Verify correctness + incremental envelope  →  Rollback (if needed)  →  next round
```

---

## Working rules

1. Prefer pure Aura on critical paths. Compose Aura stdlib/engine surfaces; **do not fork** engine sources into this repo.  
2. Every escape on a continuous-edit or scale-critical path must be logged in `notes/escape-log.md`.  
3. Mutation at scale must preserve correctness **and** a measurable incremental performance envelope.  
4. Metrology is first-class: dirty ratio, cascade cost, generation, cache hit, escape rate.  
5. Host/packaging blockers go to `notes/host-residuals.md` — do not confuse them with denseness failures.  
6. Update `notes/denseness-report.md` when probes land; do not invent a denseness “pass” without runnable evidence.  
7. Theory changes → update `notes/aura-unify.md` (and cross-links); probe work alone does not rewrite the manifesto.

---

## Axes (inside \(S_{\mathrm{Prometheus}}\) only)

| Axis | Span target |
|------|-------------|
| **A. Scale completeness** | Realistic large FlatAST mostly in \(V_A\) |
| **B. Continuous mutation** | High-frequency typed mutate + dirty still correct |
| **C. Incremental performance** | Cascade / re-lower / cache decision-grade at scale |
| **D. LLM interaction surface** | query + mutate + workspace dense enough |
| **E. Scale boundary** | True escapes isolated & metered |
| **F. Metrology** | Escape rate, cost regression, dual rollback |

---

## Current phase goal

**Phase 1–3 landed:**
- `01-minimal-scale` — large FlatAST construct + metrology (A+F, \(E=0\))
- `02-continuous-mutate` — continuous typed rebind + poison/restore (A+B+F, \(E=0\))
- `03-incremental-cost` — generation / partial relower / dirty ratio / latency envelope (A+B+C+F, \(E=0\))

**Next:** Phase 4 LLM propose edge isolation (schema / wire / stub / live) — axes D+E.

When generating code or probes, keep the denseness claim **testable** and the escape discipline **strict**.

**Host residuals to respect:** H1 (no cross-define call chains after set-code), H3 (sample rebind results inside continuous while, not only top-level after).

### After generating

Briefly state:

- Which axes (A–F) this advances  
- Which part of the continuous-edit denseness loop it implements  
- Escapes remaining and open questions  
- How to run: `./scripts/run-aura.sh examples/NN-name/main.aura` (expects `../aura-grok` or `AURA_PATH`)

---

## Success metric (near-term)

A **runnable** pure-Aura large-AST construction + baseline incremental metrology probe, structured so later phases can add continuous mutation and LLM propose edge without rewriting the metrology story.

Longer-term success is a denseness report for \(S_{\mathrm{Prometheus}}\), not a pile of unrelated microbenchmarks.

---

Update this prompt when architecture, phase, or denseness thresholds evolve.
