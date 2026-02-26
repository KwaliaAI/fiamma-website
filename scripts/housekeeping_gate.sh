#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "${ROOT_DIR}"

SHARED_GATE="/home/oss/_agents/shared/scripts/housekeeping_gate.sh"
if [[ -x "${SHARED_GATE}" ]]; then
  bash "${SHARED_GATE}" \
    --context "fiamma housekeeping gate" \
    --allow-dirty-env ALLOW_DIRTY_DEPLOY
  exit $?
fi

# Portable fallback for CI or non-/home/oss environments.
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "[housekeeping_gate] ERROR (fiamma housekeeping gate): not inside a git repo."
  exit 1
fi

BRANCH="$(git rev-parse --abbrev-ref HEAD)"
if [[ "${CI:-}" != "true" && "${GITHUB_ACTIONS:-}" != "true" ]]; then
  if [[ -z "${BRANCH}" || "${BRANCH}" == "HEAD" ]]; then
    echo "[housekeeping_gate] ERROR (fiamma housekeeping gate): detached HEAD is not allowed."
    exit 1
  fi
fi

if [[ "${ALLOW_DIRTY_DEPLOY:-0}" != "1" ]]; then
  if ! git diff --quiet || ! git diff --cached --quiet || [[ -n "$(git ls-files --others --exclude-standard)" ]]; then
    echo "[housekeeping_gate] ERROR (fiamma housekeeping gate): dirty git worktree."
    echo "[housekeeping_gate] Commit/stash before proceeding, or set ALLOW_DIRTY_DEPLOY=1 only with explicit Founder approval."
    git status --short
    exit 1
  fi
fi

if [[ "${ALLOW_DIRTY_DEPLOY:-0}" == "1" ]]; then
  echo "[housekeeping_gate] WARNING (fiamma housekeeping gate): ALLOW_DIRTY_DEPLOY=1 override is active."
fi

echo "[housekeeping_gate] OK (fiamma housekeeping gate) repo=$(basename "${ROOT_DIR}") branch=${BRANCH}"
