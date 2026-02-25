#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

bash ./scripts/hygiene_gate.sh

echo "[release_gate] Running lint..."
npm run lint

echo "[release_gate] Running build..."
npm run build
