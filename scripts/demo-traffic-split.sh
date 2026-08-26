#!/usr/bin/env bash
# Demonstrate Gateway API traffic splitting in action
set -euo pipefail

GATEWAY_IP="${GATEWAY_IP:-127.0.0.1}"
PORT="${GATEWAY_PORT:-8080}"
BASE="http://${GATEWAY_IP}:${PORT}"
REQUESTS="${DEMO_REQUESTS:-20}"

echo "=== Gateway API Traffic Split Demo ==="
echo "Sending $REQUESTS requests and counting version distribution..."

v1=0; v2=0
for i in $(seq 1 "$REQUESTS"); do
  VERSION=$(curl -sf "${BASE}/api" -H "Host: app.example.com" 2>/dev/null | python3 -c "import json,sys; print(json.load(sys.stdin).get('version','unknown'))" 2>/dev/null || echo "error")
  [[ "$VERSION" == "v1" ]] && ((v1++)) || ((v2++))
done

echo ""
echo "Results after $REQUESTS requests:"
echo "  v1 (stable):  $v1 requests ($(( v1 * 100 / REQUESTS ))%)"
echo "  v2 (canary):  $v2 requests ($(( v2 * 100 / REQUESTS ))%)"
echo ""
echo "Header-based routing (X-Canary: true always goes to v2):"
VERSION=$(curl -sf "${BASE}/api" -H "Host: app.example.com" -H "X-Canary: true" 2>/dev/null | python3 -c "import json,sys; print(json.load(sys.stdin).get('version','unknown'))" 2>/dev/null || echo "error")
echo "  X-Canary: true → $VERSION"
