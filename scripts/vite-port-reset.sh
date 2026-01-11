#!/usr/bin/env bash
set -euo pipefail
cd "${1:-.}"

kill_port() {
  local p="$1"
  local pids
  pids="$(lsof -tiTCP:"$p" -sTCP:LISTEN 2>/dev/null || true)"
  if [ -z "$pids" ]; then
    echo "✅ Port $p already free"
    return 0
  fi

  echo "⚠️ Port $p in use by PID(s): $pids"
  echo "   Details:"
  lsof -iTCP:"$p" -sTCP:LISTEN -nP | sed -n '1,10p' || true

  echo "🧯 Sending SIGTERM..."
  kill $pids 2>/dev/null || true
  sleep 0.5

  pids="$(lsof -tiTCP:"$p" -sTCP:LISTEN 2>/dev/null || true)"
  if [ -n "$pids" ]; then
    echo "🧨 Still listening, sending SIGKILL..."
    kill -9 $pids 2>/dev/null || true
    sleep 0.2
  fi

  if lsof -iTCP:"$p" -sTCP:LISTEN -nP >/dev/null 2>&1; then
    echo "❌ Port $p still busy (rare)."
    exit 1
  fi

  echo "✅ Port $p freed"
}

echo "🔎 Checking ports..."
for p in 5173 5174; do
  if lsof -iTCP:"$p" -sTCP:LISTEN -nP >/dev/null 2>&1; then
    echo "⚠️ $p is busy"
  else
    echo "✅ $p is free"
  fi
done

echo ""
echo "🧹 Freeing 5173..."
kill_port 5173

echo ""
echo "🚀 Starting Vite on 5173 (forced)..."
pnpm dev -- --port 5173 --strictPort
