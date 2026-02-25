#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

bash ./scripts/release_gate.sh

echo "[deploy_prod] Running full Netlify production build/deploy..."
echo "[deploy_prod] Using Netlify build context/env (no --no-build)."

npx netlify-cli deploy --prod
