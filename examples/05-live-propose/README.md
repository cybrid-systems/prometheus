# 05-live-propose

**Opt-in** live LLM propose edge denseness probe (not in default `run-all.sh`).

| | |
|--|--|
| **Axes** | A · B · D · E · F |
| **Providers** | MiniMax-M3 (`~/code/keys/minimax`) · deepseek-v4-flash (`~/code/keys/deepseek`) |
| **Core \(E\)** | 0 |
| **Edge \(E\)** | ≥1 (HTTPS via curl harness) |

## Why curl, not in-process `llm:chat`?

Host residual **H4**: after heavy `prometheus-min` load, `aura-llm-call` can recurse / fail. Live harness therefore:

1. `scripts/live-chat.sh` — OpenAI-compatible HTTPS  
2. Pass wire in `PROMETHEUS_LLM_WIRE`  
3. Aura probe — schema gate + rebind on scale FlatAST  

## Run

```bash
# both providers + denseness execute
./scripts/compare-live-llms.sh

# single provider
source ./scripts/env-minimax.sh
WIRE=$(./scripts/live-chat.sh)
PROMETHEUS_LLM_WIRE="$WIRE" PROMETHEUS_LLM_CHAT_MS=1 \
  ./scripts/run-aura.sh examples/05-live-propose/main.aura
```

## Pass shape

```
PASS: live propose edge (parsed llm-live; core guarded)
RESULT pass example=05-live-propose provider=... model=... decision=commit got=21 escapes=1
```
