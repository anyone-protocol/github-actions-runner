#!/bin/bash

# From: https://baccini-al.medium.com/how-to-containerize-a-github-actions-self-hosted-runner-5994cc08b9fb

REPO=$REPO
ACCESS_TOKEN=$ACCESS_TOKEN
REG_TOKEN=$(
  curl \
    -X POST \
    -H "Authorization: token ${ACCESS_TOKEN}" \
    -H "Accept: application/vnd.github+json" https://api.github.com/orgs/${REPO}/actions/runners/registration-token \
    | jq .token --raw-output
)


./config.sh --url https://github.com/${REPO} --token ${REG_TOKEN} --name ${RUNNER_NAME}

cleanup() {
  echo "Removing runner..."
  ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!
