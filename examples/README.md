# Prometheus denseness probes

Copy `_template` to start a new probe.

| # | Probe | Axes | Status |
|---|-------|------|--------|
| 01 | [minimal-scale](01-minimal-scale/) | A F | landed |
| 02 | [continuous-mutate](02-continuous-mutate/) | A B F | landed |
| 03 | [incremental-cost](03-incremental-cost/) | A B C F | landed |
| 04 | [propose-edge](04-propose-edge/) | A B D E F | landed |
| 05 | scale soak + denseness judgment | A–F | planned |

Conventions match Aether / Hephaestus: one `main.aura` per example directory,
short README explaining the claim and expected PASS shape.

**Live LLM API:** not required for probes 01–04. Optional for propose-edge via
`PROMETHEUS_LLM_PROPOSE=live` + `LLM_API_KEY` (product pressure only).
