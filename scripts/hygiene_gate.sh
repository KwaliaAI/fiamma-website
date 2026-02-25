#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

bash /home/oss/_agents/shared/scripts/hygiene_gate.sh \
  --context "fiamma hygiene gate" \
  --allow-dirty-env ALLOW_DIRTY_DEPLOY
