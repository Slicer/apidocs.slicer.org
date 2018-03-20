#!/usr/bin/env bash

set -e
set -o pipefail

SCRIPT_NAME=$(basename $0)
TRAVIS_EVENT_TYPE=$1

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

case $TRAVIS_EVENT_TYPE in
cron|squash)
  ;;
*)
  echo "$SCRIPT_NAME: invalid parameters"
  usage
  exit 1
  ;;
esac

# Login to TravisCI
travis-cli login --org --no-interactive --github-token $GITHUB_TOKEN

# Get a Travis token
TRAVIS_TOKEN=$(echo $(travis-cli token --org --no-interactive) | tr -d '[:space:]')

body="{
  \"request\": {
    \"config\": {
      \"env\": {\"TRAVIS_EVENT_TYPE\": \"${TRAVIS_EVENT_TYPE}\"
      }
    }
  }
}"

TRAVIS_REPO="Slicer%2Fapidocs.slicer.org"

curl -s -X POST \
   -H "Content-Type: application/json" \
   -H "Accept: application/json" \
   -H "Travis-API-Version: 3" \
   -H "Authorization: token ${TRAVIS_TOKEN}" \
   -d "$body" \
   "https://api.travis-ci.org/repo/${TRAVIS_REPO}/requests"
