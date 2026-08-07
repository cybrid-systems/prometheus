# Host residuals — packaging / CLI issues (not denseness failures)

Track host or packaging limitations that force workarounds.
These are **not** counted as denseness failures on \(S_{\mathrm{Prometheus}}\).

Upstream tracking (cybrid-systems/aura):

| Residual | Aura issue |
|----------|------------|
| H1 cross-define after set-code | [#2732](https://github.com/cybrid-systems/aura/issues/2732) |
| H2 count-only node metric | [#2733](https://github.com/cybrid-systems/aura/issues/2733) |
| H3 post-rebind top-level sample stale | [#2734](https://github.com/cybrid-systems/aura/issues/2734) |
| H4 aura-llm-call recursion after heavy require | [#2735](https://github.com/cybrid-systems/aura/issues/2735) |
| set!/top-level define after set-code | [#2736](https://github.com/cybrid-systems/aura/issues/2736) |
| ast:* stats surface / pipeline docs | [#2737](https://github.com/cybrid-systems/aura/issues/2737) |

---

## H1 — Cross-define call chains after `set-code` may mis-evaluate (2026-08-07)

**Upstream:** [aura#2732](https://github.com/cybrid-systems/aura/issues/2732)

**Symptom:** After `(set-code …)` + `(eval-current)` of multiple interdependent defines, some call chains return the argument (or apply only one layer) instead of the nested result.

**Workaround:** independent leaves + single deep nest; mutation via single named lambda rebind (Aether pattern).

**Status:** open; filed upstream.

---

## H2 — Full `ast:nodes` list for node count (noted, not blocking)

**Upstream:** [aura#2733](https://github.com/cybrid-systems/aura/issues/2733)

**Symptom:** Node count is `(length (stats:get "ast:nodes"))`. Fine at ~1–3k; expensive at 1e5+.

**Status:** deferred; enhancement filed.

---

## H3 — Top-level `subject` sample after rebind can be stale (2026-08-07)

**Upstream:** [aura#2734](https://github.com/cybrid-systems/aura/issues/2734)

**Symptom:** After `mutate:rebind` + `eval-current`, top-level `(subject n)` often identity/stale; in-`while` sample correct.

**Workaround:** sample inside continuous while / module helpers; literals for knobs after set-code.

**Status:** open; filed upstream.

---

## H4 — `aura-llm-call` recursion after heavy module load (2026-08-07)

**Upstream:** [aura#2735](https://github.com/cybrid-systems/aura/issues/2735)

**Symptom:** After heavy `require` (e.g. prometheus-min), in-process `llm:chat` / `aura-llm-call` can recurse (>700) or empty-fail in ms.

**Workaround:** curl harness (`scripts/live-chat.sh`) + `PROMETHEUS_LLM_WIRE`.

**Status:** open; filed upstream.

---

## Related (filed together)

- [aura#2736](https://github.com/cybrid-systems/aura/issues/2736) — `set!` on let locals / top-level define stale / while spin after set-code  
- [aura#2737](https://github.com/cybrid-systems/aura/issues/2737) — `ast:*` via stats:get vs prims; pipeline strict documentation  
