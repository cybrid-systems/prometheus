#!/usr/bin/env bash
# Call OpenAI-compatible chat API and print assistant content to stdout.
# Never prints the API key. Used by compare-live-llms.sh (H4: avoid
# aura-llm-call after heavy module load / set-code recursion).
#
# Env: LLM_API_KEY LLM_BASE_URL LLM_MODEL
# Optional: LIVE_CHAT_MAX_TOKENS (default 512)

set -euo pipefail

: "${LLM_API_KEY:?LLM_API_KEY required}"
: "${LLM_BASE_URL:?LLM_BASE_URL required}"
: "${LLM_MODEL:?LLM_MODEL required}"

MAX_TOKENS="${LIVE_CHAT_MAX_TOKENS:-512}"
URL="${LLM_BASE_URL%/}/chat/completions"

SYS='You are a denseness propose-edge agent. Output EXACTLY one line and nothing else. No markdown. No thinking. No prose. Allowed lines only:
MUTATE|subject|(lambda (x) (* x 3))|triple
or
SKIP|subject||noop
Field 2 is ALWAYS the exact word subject (never sample-arg, never a number, never x). N must be 2, 3, 5, or 7.'
USR='Observation: input-arg=7 observed-value=14 (double). Policy: when observed is double, emit triple mutate. Example good line:
MUTATE|subject|(lambda (x) (* x 3))|auto-triple
Now output your one line:'

# Build JSON safely with python
BODY=$(python3 - <<PY
import json, os
print(json.dumps({
  "model": os.environ["LLM_MODEL"],
  "max_tokens": int(os.environ.get("LIVE_CHAT_MAX_TOKENS", "512")),
  "temperature": 0,
  "messages": [
    {"role": "system", "content": '''$SYS'''},
    {"role": "user", "content": '''$USR'''},
  ],
}))
PY
)

TMP=$(mktemp)
HTTP=$(curl -sS -o "$TMP" -w "%{http_code}" --max-time 90 \
  -X POST "$URL" \
  -H "Authorization: Bearer ${LLM_API_KEY}" \
  -H "Content-Type: application/json" \
  -d "$BODY" || true)

python3 - <<PY
import json, sys
from pathlib import Path
http = int("$HTTP")
raw = Path("$TMP").read_text(errors="replace")
Path("$TMP").unlink(missing_ok=True)
if http < 200 or http >= 300:
    print(f"HTTP_{http}", file=sys.stderr)
    print(raw[:400], file=sys.stderr)
    sys.exit(2)
try:
    d = json.loads(raw)
except Exception as e:
    print(f"JSON_ERR {e}", file=sys.stderr)
    sys.exit(3)
if "error" in d:
    print(d["error"], file=sys.stderr)
    sys.exit(4)
msg = d["choices"][0]["message"]
content = msg.get("content") or ""
reasoning = msg.get("reasoning_content") or ""
# Prefer content; if empty or only think wrapper, append/use reasoning
text = content if content.strip() else reasoning
# Strip <think>...</think>
import re
text = re.sub(r"<think>[\s\S]*?</think>", "", text, flags=re.I)
text = text.strip()
# Prefer a single clean wire line with literal subject and concrete N in {2,3,5,7}
wire_re = re.compile(
    r"(MUTATE\|subject\|\(lambda \(x\) \(\* x [2357]\)\)\|[^\n\r]*|SKIP\|subject\|\|[^\n\r]*)"
)
m = wire_re.search(text) or wire_re.search(raw)
if m:
    text = m.group(1).strip()
elif "MUTATE|" in text or "SKIP|" in text:
    for line in text.splitlines():
        line = line.strip()
        if line.startswith("MUTATE|") or line.startswith("SKIP|"):
            text = line
            break
# Repair common model mistake: field2 = sample-arg / 7 / x  → subject
parts = text.split("|")
if len(parts) >= 4 and parts[0].upper() == "MUTATE":
    if parts[1] in ("sample-arg", "7", "x", "input-arg", "arg", "name"):
        parts[1] = "subject"
        text = "|".join(parts)
print(text)
# metrics line on stderr for harness
usage = d.get("usage") or {}
print(f"LIVE_META model={d.get('model')} http={http} prompt_tokens={usage.get('prompt_tokens')} completion_tokens={usage.get('completion_tokens')} total_tokens={usage.get('total_tokens')}", file=sys.stderr)
PY
