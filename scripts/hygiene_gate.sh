#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

SHARED_GATE="/home/oss/_agents/shared/scripts/hygiene_gate.sh"
if [[ -x "${SHARED_GATE}" ]]; then
  bash "${SHARED_GATE}" \
    --context "fiamma hygiene gate" \
    --allow-dirty-env ALLOW_DIRTY_DEPLOY
  exit $?
fi

# Portable fallback for CI or non-/home/oss environments.
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "[hygiene_gate] ERROR (fiamma hygiene gate): not inside a git repo."
  exit 1
fi

BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [[ "${CI:-}" != "true" && "${GITHUB_ACTIONS:-}" != "true" ]]; then
  if [[ -z "${BRANCH}" || "${BRANCH}" == "HEAD" ]]; then
    echo "[hygiene_gate] ERROR (fiamma hygiene gate): detached HEAD is not allowed."
    exit 1
  fi
fi

if [[ "${ALLOW_DIRTY_DEPLOY:-0}" != "1" ]]; then
  if ! git diff --quiet || ! git diff --cached --quiet || [[ -n "$(git ls-files --others --exclude-standard)" ]]; then
    echo "[hygiene_gate] ERROR (fiamma hygiene gate): dirty git worktree."
    echo "[hygiene_gate] Commit/stash before proceeding, or set ALLOW_DIRTY_DEPLOY=1 only with explicit Founder approval."
    git status --short
    exit 1
  fi
fi

if [[ "${ALLOW_DIRTY_DEPLOY:-0}" == "1" ]]; then
  echo "[hygiene_gate] WARNING (fiamma hygiene gate): ALLOW_DIRTY_DEPLOY=1 override is active."
fi

echo "[hygiene_gate] OK (fiamma hygiene gate) repo=$(basename "${ROOT_DIR}") branch=${BRANCH}"
