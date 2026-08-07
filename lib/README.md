# Prometheus lib map

Thin Aura surfaces that compose the basis for denseness probes.

Planned modules (names may evolve):

| Module | Role |
|--------|------|
| `prometheus-min.aura` | Thin facade / version |
| `prometheus-measure.aura` | Axis F metrology |
| `prometheus-scale.aura` | Large-AST construction helpers |
| `prometheus-mutate.aura` | Continuous mutation policies |
| `prometheus-llm.aura` | Propose-edge schema / wire helpers |
| `prometheus-escape.aura` | Escape metering helpers |

All modules should prefer pure Aura and re-export or thin-wrap Aura std surfaces.
Do not reimplement engine primitives here.
