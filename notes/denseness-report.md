# \(S_{\mathrm{Prometheus}}\) denseness report

**Date:** 2026-08-07  
**Host:** Aura (local `aura-grok`)  
**Surface:** measure · scale · mutate · cost · llm  
**Status:** Phase 1–4 probes landed; denseness judgment **partial** (A–F except soak)

---

## Claim under test

On \(S_{\mathrm{Prometheus}}\) (large-scale FlatAST under continuous LLM-driven typed mutation with incremental compilation as first-class semantics), the **evolvable / editable core** can stay in pure Aura (\(V_A\)) with controlled, metered escapes \(E\) confined to the world / propose edge or true scale limits.

\[
P \approx A \oplus E,\quad A \in V_A
\]

---

## Live LLM API?

**Not required for denseness Phase 1–4.**

| Path | Role | Core \(E\) | Edge \(E\) |
|------|------|------------|------------|
| rule propose | pure-Aura policy | 0 | 0 |
| schema refuse | gate before rebind | 0 | 0 |
| wire parse (sim text) | external text → schema | 0 | ≥1 metered |
| stub propose | simulated LLM edge | 0 | ≥1 metered |
| live HTTPS | optional product pressure | 0 | ≥1 if used |

Offline suite proves the **isolation architecture**. Live MiniMax/OpenAI-style calls are opt-in (`PROMETHEUS_LLM_PROPOSE=live` + `LLM_API_KEY`), same posture as Aether 09.

---

## Axis coverage

| Axis | Evidence |
|------|----------|
| **A** Scale | 01–04 |
| **B** Continuous mutation | 02–04 |
| **C** Incremental cost | 03 |
| **D** LLM interaction surface | **04** — schema + wire + stub + prompt |
| **E** Scale / world boundary | **04** — edge escape metering; live optional |
| **F** Metrology | 01–04 |

---

## Constructive evidence

| Probe | Axes | Result | Core \(E\) | Edge \(E\) |
|-------|------|--------|------------|------------|
| [01](../examples/01-minimal-scale/) | A F | **PASS** | 0 | 0 |
| [02](../examples/02-continuous-mutate/) | A B F | **PASS** | 0 | 0 |
| [03](../examples/03-incremental-cost/) | A B C F | **PASS** | 0 | 0 |
| [04](../examples/04-propose-edge/) | A B D E F | **PASS** (rule/schema/wire/stub) | 0 | ≥1 (stub/wire) |

### 04 narrative

- Rule auto-triple from double → commit, `escapes=0`  
- Schema refuse: bad kind, `rm -rf` body, wrong name `f0`  
- Wire: good `MUTATE|subject|*5` commits; garbage parse-fail; hack body refuse  
- Stub: `source=llm-stub`, edge escape bumped, subject still verifies  
- `live_required=no`  

---

## Judgment

**Partial / near-complete on scoped paths.** Axes A–F each have constructive evidence with **core \(E=0\)**. Remaining: multi-N soak + formal denseness write-up (Phase 5), optional live propose smoke.

---

## How to reproduce

```bash
./scripts/check-structure.sh
./scripts/run-all.sh   # offline; no API key
```
