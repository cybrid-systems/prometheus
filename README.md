# Prometheus

**Large-scale AST incremental compilation & continuous LLM mutation denseness probe on Aura — the third concrete span of Aura Unify.**

Prometheus is not a general-purpose editor framework and not a reimplementation of the Aura compiler.
It is the third **concrete span project** of [Aura Unify](notes/aura-unify.md):
an empirical test of whether Aura’s native space \(V_A\) can densely cover the
high-scale, continuous-mutation, LLM-driven editing region of practical software.

> Aura supplies a machine-friendly basis.  
> Aether showed denseness on the agent + mutation closed-loop subspace.  
> Hephaestus showed denseness on the performance / numerical / systems-kernel subspace.  
> Prometheus asks whether the same basis remains dense when the primary
> computational objects are **very large FlatASTs under continuous LLM-driven
> typed mutation, with incremental compilation performance as first-class semantics**.

**Read first (theory):** [`notes/aura-unify.md`](notes/aura-unify.md) — Aura Unify 总论（语义空间、span 程序、与 Aether / Hephaestus / 本仓的关系）。

## The subspace Prometheus claims: \(S_{\mathrm{Prometheus}}\)

Prometheus does **not** try to prove \(V_A \approx S_{\mathrm{practical}}\).
It claims only a high-leverage scale + continuous-edit subspace:

\[
S_{\mathrm{Prometheus}} \subset S_{\mathrm{practical}}
\]

**Systems whose primary computational objects are large mutable ASTs,
incremental recompilation under frequent safe mutation,
and LLM interaction patterns that keep the evolvable core inside \(V_A\)**.

A system is in \(S_{\mathrm{Prometheus}}\) when it simultaneously has:

1. **Large AST as first-class object** — tens/hundreds of thousands of nodes, deep nesting, multi-region workspace  
2. **Continuous typed mutation** — high-frequency LLM propose → typed mutate → dirty propagation → selective re-lower  
3. **Incremental performance as semantics** — dirty ratio, cascade cost, generation, cache hit rate are observable and decision-relevant  
4. **LLM interaction density** — query + mutate + workspace surfaces keep most of the “edit large program” loop in pure Aura  
5. **Controlled scale escape set \(E\)** — only when true scale limits force external help; metered and ownership-safe

### Denseness proposition (defensible form)

> On \(S_{\mathrm{Prometheus}}\), \(V_A\) is dense for the **evolvable / editable core**:  
> the majority of large-scale continuous editing logic (including incremental
> compilation decisions) stays in pure Aura; necessary escapes \(E\) are rare,
> metered, do not destroy incremental performance observability or post-mutation
> correctness/rollback.

If this subspace cannot achieve low escape rates on the continuous-edit path
while preserving incremental correctness and usable latency at scale, the broader
Unify thesis is weakened at its third highest-leverage engineering point.

### Explicitly out of scope (initial phases)

| Out of scope | Why |
|--------------|-----|
| Full IDE / language-server product surface | Later product pressure tests |
| Hard realtime / sub-ms hard latency guarantees | Different safety regime |
| Rebuilding Aura’s FlatAST / dirty / cascade machinery | Aura already provides the basis |
| Proving universal denseness of all large-program editors | Constructive measurement only |

## Canonical continuous-edit denseness loop

```
Load / Grow large AST  →  LLM Propose (schema-gated)  →  Typed Mutation  →
Dirty mark + Cascade   →  Selective re-lower / JIT    →  Observe cost metrics  →
Verify correctness + incremental envelope  →  Rollback (if needed)  →  next round
```

Invariants we care about:

- Mutation only through typed / boundary-guarded paths  
- Full observability of dirty nodes, cascade cost, generation, cache behavior  
- Rollback restores both semantic state *and* incremental performance baseline  
- Evolvable core stays in pure Aura; world / LLM I/O is thin, audited \(E\)

## Orthogonal axes inside \(S_{\mathrm{Prometheus}}\)

| Axis | Question |
|------|----------|
| **A. Scale completeness** | Can a realistic large FlatAST (node count, depth, multi-region) live mostly in \(V_A\)? |
| **B. Continuous mutation** | High-frequency typed mutate + dirty propagation still correct and usable? |
| **C. Incremental performance** | Cascade / re-lower / JIT cache deliver measurable, decision-grade latency at scale? |
| **D. LLM interaction surface** | query:* + mutate:* + workspace stay dense enough that most edit logic needs no external AST tools? |
| **E. Scale boundary** | When must we escape (extreme size / exotic analysis)? Can it stay ownership-safe and metered? |
| **F. Metrology** | Escape rate on continuous-edit path, dirty-ratio vs cost, dual rollback (state + metrics) |

## Relationship to Aura, Aether, Hephaestus

| Layer | Owner | Role |
|-------|--------|------|
| Runtime, typed mutation, FlatAST, dirty/cascade, generation, JIT, ownership | Aura (`../aura-grok`) | Basis \(V_A\) |
| Thin stdlib surfaces (`mutate`, `query`, `workspace`, `hot-update`, …) | Aura | Callable operators |
| Agent closed-loop denseness evidence | [Aether](../aether) | First span — *practically dense* on \(S_{\mathrm{Aether}}\) |
| Performance / numerical / systems-kernel denseness evidence | [Hephaestus](../hephaestus) | Second span — *practically dense* on \(S_{\mathrm{Hephaestus}}\) |
| **Large-scale continuous AST mutation + incremental denseness evidence** | **Prometheus** | Third span |

Prometheus **composes** Aura surfaces. It does not fork the engine.
It **does not re-prove** Aether’s agent subspace or Hephaestus’ performance subspace;
it pressure-tests the next high-leverage region under the same Unify discipline
(escape log, denseness report, pure-Aura preference on the evolvable core).

Local development is expected against an Aura checkout (default `../aura-grok` via `scripts/run-aura.sh`):

```bash
./scripts/run-aura.sh examples/01-minimal-scale/main.aura
```

### Documents

| Doc | Purpose |
|-----|---------|
| [`notes/aura-unify.md`](notes/aura-unify.md) | Aura Unify theory + span program |
| [`notes/denseness-report.md`](notes/denseness-report.md) | Evidence & judgment on \(S_{\mathrm{Prometheus}}\) |
| [`notes/escape-log.md`](notes/escape-log.md) | Required log of leaves from \(V_A\) |
| [`notes/host-residuals.md`](notes/host-residuals.md) | Host/packaging issues (not denseness failures) |
| [`prompts/GROK.md`](prompts/GROK.md) | Living agent prompt |
| [`../aether/notes/denseness-report.md`](../aether/notes/denseness-report.md) | Prior agent span |
| [`../hephaestus/notes/denseness-report.md`](../hephaestus/notes/denseness-report.md) | Prior performance span |

## Practical denseness criteria (tunable)

| Metric | Suggested threshold | Meaning |
|--------|---------------------|---------|
| Continuous-edit escape rate | low / measurable | By critical edit path, not whole program |
| Correctness after mutation + cascade | ≈ 100% | No silent wrong answers |
| Dirty / cascade cost observability | first-class | Decision-grade metrics |
| Rollback restores state *and* incremental baseline | yes | Dual correctness |
| LLM propose edge isolation | core stays pure | Schema-gated, metered |

**Failure modes** (pre-declared):

- Continuous edit *requires* unguarded external AST tooling → denseness claim collapses  
- Mutation at scale breaks dirty tracking or introduces inconsistency → safety failure  
- Incremental performance only achievable by abandoning observability → metrology failure  

## Project structure

```
prometheus/
├── README.md
├── LICENSE
├── .github/workflows/denseness.yml
├── scripts/
│   ├── run-aura.sh
│   ├── run-all.sh
│   ├── check-structure.sh
│   └── overnight-scale.sh
├── lib/                    # prometheus-{min,measure,scale,mutate,llm,escape}
├── examples/01 …           # denseness probes (to be filled)
├── notes/                  # aura-unify, denseness-report, escape-log, host-residuals
└── prompts/GROK.md
```

## Span order (initial)

| Phase | Focus | Status |
|-------|--------|--------|
| **1** | Minimal large-AST construction + baseline metrology | **landed** (`01-minimal-scale`) |
| **2** | Continuous typed mutation + dirty cascade under controlled load | **landed** (`02-continuous-mutate`) |
| **3** | Incremental cost observability + generation / cache behavior | **landed** (`03-incremental-cost`) |
| **4** | LLM propose edge (schema / wire / stub / live) isolation | planned |
| **5** | Scale soak + denseness judgment | planned |

## Escape discipline

Every leave from pure Aura (\(V_A\)) on a continuous-edit or scale-critical path must be recorded in `notes/escape-log.md`:

- Location, reason, mechanism (FFI / external service / other)  
- Impact (correctness vs pure performance / scale)  
- Ownership / lifetime implications  
- Mitigation or future plan  

Escapes on the evolvable / editable core are treated as **evidence against** denseness until justified and isolated.

## License

Apache License 2.0 (same as Aura, Aether, Hephaestus)

## Status

**Phase 1–3 landed.** Scale FlatAST + continuous rebind + decision-grade incremental cost envelope pass with core \(E=0\). LLM propose edge (D), scale boundary (E), and soak judgment remain open.

```bash
./scripts/check-structure.sh    # no binary required
./scripts/run-all.sh
# later:
./scripts/overnight-scale.sh
```

Prometheus continues Aura Unify’s constructive measurement program after Aether’s agent-loop and Hephaestus’ performance denseness results — pressure-testing the same basis on the large-scale continuous AST mutation + incremental compilation subspace.
