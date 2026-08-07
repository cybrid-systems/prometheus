# Prometheus denseness probes

Copy `_template` to start a new probe.

| # | Probe | Axes | Status |
|---|-------|------|--------|
| 01 | [minimal-scale](01-minimal-scale/) | A F | landed |
| 02 | [continuous-mutate](02-continuous-mutate/) | A B F | landed |
| 03 | [incremental-cost](03-incremental-cost/) | A B C F | landed |
| 04 | [propose-edge](04-propose-edge/) | A B D E F | landed (offline) |
| 05 | [live-propose](05-live-propose/) | A B D E F | landed (opt-in live) |
| 06 | scale soak + denseness judgment | A–F | planned |

Conventions match Aether / Hephaestus: one `main.aura` per example directory,
short README explaining the claim and expected PASS shape.

**Live LLM API:** not required for 01–04. Opt-in compare:

```bash
./scripts/compare-live-llms.sh   # MiniMax-M3 + deepseek-v4-flash
```
