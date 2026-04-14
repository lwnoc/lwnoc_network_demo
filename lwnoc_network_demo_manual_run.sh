#!/usr/bin/env bash
# ───────────────────────────────────────────────────────────────────────────────
# lwnoc_network_demo_manual_run.sh
#
# Creates the GitHub repo and pushes the current main branch.
# SSH auth works via the github-sub-account-z alias, but no GITHUB_TOKEN or gh CLI is available.
#
# FILL IN:
#   GITHUB_TOKEN — a personal access token with 'repo' scope
#                  Get one at https://github.com/settings/tokens
# ───────────────────────────────────────────────────────────────────────────────

set -euo pipefail

GITHUB_TOKEN="${GITHUB_TOKEN:-<FILL_IN>}"
REPO_NAME="lwnoc_network_demo"
ORG="lwnoc"
REPO_DIR="/home/lgzhu/dev/noc_work/lwnoc_network_demo"
SSH_REMOTE="git@github-sub-account-z:${ORG}/${REPO_NAME}.git"

# Step 1: Create the repo on GitHub
echo "[1/3] Creating GitHub repo ${ORG}/${REPO_NAME} ..."
curl -s -X POST \
  -H "Authorization: token ${GITHUB_TOKEN}" \
  -H "Content-Type: application/json" \
  https://api.github.com/orgs/${ORG}/repos \
  -d "{\"name\":\"${REPO_NAME}\",\"description\":\"Interrupt ring NoC demo with lwnoc_topo framework\",\"private\":false}" \
  | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('html_url','ERROR: ' + d.get('message','unknown')))"

# Step 2: Add the remote
echo "[2/3] Adding remote origin ..."
cd "${REPO_DIR}"
git remote add origin "${SSH_REMOTE}" 2>/dev/null || \
  git remote set-url origin "${SSH_REMOTE}"

# Step 3: Push
echo "[3/3] Pushing to GitHub ..."
git push -u origin main

echo ""
echo "Done! Repo available at: https://github.com/${ORG}/${REPO_NAME}"
