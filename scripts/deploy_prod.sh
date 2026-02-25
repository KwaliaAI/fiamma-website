#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

if [[ "${ALLOW_DIRTY_DEPLOY:-0}" != "1" ]]; then
  if ! git diff --quiet || ! git diff --cached --quiet || [[ -n "$(git ls-files --others --exclude-standard)" ]]; then
    echo "[deploy_prod] ERROR: git worktree is dirty. Commit/stash changes before production deploy."
    echo "[deploy_prod] Hint: set ALLOW_DIRTY_DEPLOY=1 only with explicit Founder approval."
    git status --short
    exit 1
  fi
fi

echo "[deploy_prod] Running full Netlify production build/deploy..."
echo "[deploy_prod] Using Netlify build context/env (no --no-build)."

npx netlify-cli deploy --prod
