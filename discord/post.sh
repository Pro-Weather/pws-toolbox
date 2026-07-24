#!/usr/bin/env bash
#
# Post a Discord webhook payload.
#
#   export DISCORD_WEBHOOK_URL="https://discord.com/api/webhooks/…"
#   ./discord/post.sh                 # posts discord/embed.json
#   ./discord/post.sh my-payload.json # posts any other payload file
#
# Get a webhook URL: Discord → Server Settings → Integrations → Webhooks → New Webhook.
# The URL is a credential — keep it in an env var, never commit it.

set -euo pipefail

PAYLOAD="${1:-$(dirname "$0")/embed.json}"

if [[ -z "${DISCORD_WEBHOOK_URL:-}" ]]; then
  echo "error: DISCORD_WEBHOOK_URL is not set" >&2
  echo "       export DISCORD_WEBHOOK_URL='https://discord.com/api/webhooks/…'" >&2
  exit 1
fi

if [[ ! -f "$PAYLOAD" ]]; then
  echo "error: payload file not found: $PAYLOAD" >&2
  exit 1
fi

# Validate JSON up front so a typo fails here rather than as an opaque 400 from Discord.
if command -v jq >/dev/null 2>&1; then
  jq empty "$PAYLOAD" || { echo "error: $PAYLOAD is not valid JSON" >&2; exit 1; }
fi

echo "→ posting $PAYLOAD"

# ?wait=true makes Discord return the created message object instead of an empty 204,
# which is far easier to debug.
HTTP_CODE=$(curl -sS -o /tmp/discord-post-response.json -w '%{http_code}' \
  -H 'Content-Type: application/json' \
  -X POST \
  --data-binary "@$PAYLOAD" \
  "${DISCORD_WEBHOOK_URL}?wait=true")

case "$HTTP_CODE" in
  2*)
    echo "✓ posted (HTTP $HTTP_CODE)"
    ;;
  429)
    RETRY=$(jq -r '.retry_after // "?"' /tmp/discord-post-response.json 2>/dev/null || echo '?')
    echo "✗ rate limited (HTTP 429) — retry after ${RETRY}s" >&2
    exit 1
    ;;
  *)
    echo "✗ failed (HTTP $HTTP_CODE)" >&2
    cat /tmp/discord-post-response.json >&2
    echo >&2
    exit 1
    ;;
esac
