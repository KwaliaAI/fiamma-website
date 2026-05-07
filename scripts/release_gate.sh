#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

bash ./scripts/housekeeping_gate.sh

echo "[release_gate] Running lint..."
npm run lint

echo "[release_gate] Running build..."
npm run build

echo "[release_gate] Checking reader onboarding contract..."
npm run reader:onboarding:check

echo "[release_gate] Checking search indexing contract..."
npm run search:indexing:check
