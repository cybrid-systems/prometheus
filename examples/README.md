# Prometheus denseness probes

Copy `_template` to start a new probe.

| # | Probe | Axes | Status |
|---|-------|------|--------|
| 01 | [minimal-scale](01-minimal-scale/) | A F | landed |
| 02 | [continuous-mutate](02-continuous-mutate/) | A B F | landed |
| 03 | incremental cost / generation / cache | C F | planned |
| 04 | LLM propose edge isolation | D E | planned |
| 05 | scale soak + denseness judgment | A–F | planned |

Conventions match Aether / Hephaestus: one `main.aura` per example directory,
short README explaining the claim and expected PASS shape.
