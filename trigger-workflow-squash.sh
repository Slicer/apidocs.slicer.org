#!/usr/bin/env bash

set -e
set -o pipefail

SCRIPT_NAME=$(basename $0)
UPDATE_MODE=${1:-squash}

usage() {
    echo ""
    echo "Usage: $0 [squash]"
    echo ""
}

# Sanity checks
if [[ -z $GITHUB_TOKEN ]]; then
  echo "$SCRIPT_NAME: skipping because GITHUB_TOKEN env. variable is not set"
  exit 1
fi

case $UPDATE_MODE in
squash)
  ;;
*)
  echo "$SCRIPT_NAME: invalid parameters"
  usage
  exit 1
  ;;
esac

GITHUB_REPO="Slicer/apidocs.slicer.org"
GITHUB_WORKFLOW_ID="gh-pages-squash.yml"

curl \
    -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    "https://api.github.com/repos/${GITHUB_REPO}/actions/workflows/${GITHUB_WORKFLOW_ID}/dispatches" \
    -d '{"ref":"main"}'
