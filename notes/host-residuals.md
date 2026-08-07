# Host residuals — packaging / CLI issues (not denseness failures)

Track host or packaging limitations that force workarounds.
These are **not** counted as denseness failures on \(S_{\mathrm{Prometheus}}\).

---

## H1 — Cross-define call chains after `set-code` may mis-evaluate (2026-08-07)

**Symptom:** After `(set-code …)` + `(eval-current)` of multiple interdependent defines, some call chains return the argument (or apply only one layer) instead of the nested result. Example shapes that failed in exploratory runs:

- `(define (h x) (g (g x)))` with `(define (g x) (+ x 42))` → `h(1)` sometimes `43` not `85`
- `(define (wrap x) (leaf x))` with constant `leaf` → returned `x` not leaf result

Independent leaf defines `(define (f{i} x) (+ x i))` and a single deep nested expression under one binding evaluate correctly.

**Workaround in Prometheus Phase 1:** scale subject uses independent leaves + one deep nest (no cross-define call graph). Continuous-mutation probes should prefer `mutate:rebind` on single named subjects (Aether pattern) until this is fixed or fully characterized upstream.

**Impact:** probe design constraint, not denseness failure — evolvable core still pure Aura.

**Status:** open host residual; not logged as escape.

---

## H2 — Full `ast:nodes` list for node count (noted, not blocking)

**Symptom:** Node count is `(length (stats:get "ast:nodes"))`, which materializes all node ids. Fine at ~1–3k nodes (Phase 1); may become expensive or memory-heavy at 1e5+.

**Future:** prefer a count-only host primitive if/when scale soak hits this; until then treat as potential Axis E measurement, not a denseness collapse.

**Status:** deferred.

---

## H3 — Top-level `subject` sample after rebind can be stale (2026-08-07)

**Symptom:** After `mutate:rebind` + `eval-current` on a multi-define workspace, calling `(subject n)` from a *subsequent top-level form* (stdin script REPL style) often returns the identity value (`n`) instead of the rebound body result. The **same** sample taken inside the continuous `while` body that performed rebind+eval is correct (closed forms `*3` / `*5` / `*99` all match).

**Workaround:** Phase 2 helpers (`prom:continuous-rebind!`, `prom:poison-restore!`) perform correctness samples inside the while compilation unit. Probes must not rely solely on post-loop top-level samples for denseness gates.

**Impact:** probe structure constraint; not a denseness failure — continuous path is pure Aura and verifies correctly in-loop.

**Status:** open host residual; not logged as escape.
