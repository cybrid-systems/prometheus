# Prometheus denseness probes

| # | Probe | Axes | Status |
|---|-------|------|--------|
| 01 | [minimal-scale](01-minimal-scale/) | A F | landed |
| 02 | [continuous-mutate](02-continuous-mutate/) | A B F | landed |
| 03 | [incremental-cost](03-incremental-cost/) | A B C F | landed |
| 04 | [propose-edge](04-propose-edge/) | A B D E F | landed (offline) |
| 05 | [live-propose](05-live-propose/) | A B D E F | landed (opt-in live) |
| 06 | [scale-soak](06-scale-soak/) | A B C F | landed N=25 |
| 07 | [long-n-50](07-long-n-50/) | A B C F | landed N=50 |
| 08 | [long-n-100](08-long-n-100/) | A B C F | landed N=100 |
| 09 | [propose-under-soak](09-propose-under-soak/) | A B D F | landed |
| 10 | [dual-subject](10-dual-subject/) | A B F | landed |

```bash
./scripts/run-all.sh
./scripts/overnight-scale.sh
./scripts/compare-live-llms.sh
```
