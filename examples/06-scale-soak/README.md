# 06-scale-soak

**Phase 5** denseness soak — N=25 continuous rebind on large FlatAST.

| | |
|--|--|
| **Axes** | A · B · C · F |
| **Rounds** | 25 |
| **Leaves** | 100 |
| **Escapes** | Must be 0 on core path |

## Claim

Under sustained continuous typed mutation on a multi-define workspace:

1. All 25 rebind rounds verify closed form + leaf integrity  
2. Incremental cost envelope stays decision-grade (gen bump, partial relower)  
3. Poison + restore recovers known-good subject  
4. Core \(E = 0\)

## Run

```bash
./scripts/run-aura.sh examples/06-scale-soak/main.aura
```
