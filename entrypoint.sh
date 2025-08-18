#!/bin/bash

# Modified from: https://baccini-al.medium.com/how-to-containerize-a-github-actions-self-hosted-runner-5994cc08b9fb

echo "Generating JWT..."
JWT=$(
  ./generate-github-app-jwt.sh ${CLIENT_ID} ${PRIVATE_KEY_PATH}
)
echo "Got JWT: ${#JWT}"
echo "Installation ID: ${#INSTALLATION_ID}"
echo "Requesting Installation Access Token..."
ACCESS_TOKEN=$(
  curl -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $(cat jwt)" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/app/installations/${INSTALLATION_ID}/access_tokens \
    | jq .token --raw-output
)
echo "Access Token: ${#ACCESS_TOKEN}"
echo "Org: ${ORG}"
echo "Requesting Runner Registration Token..."
REG_TOKEN=$(
  curl -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: token ${ACCESS_TOKEN}" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/orgs/${ORG}/actions/runners/registration-token \
    | jq .token --raw-output
)
echo "Registration Token: ${#REG_TOKEN}"
echo "Runner Name: ${RUNNER_NAME}"
./config.sh --url https://github.com/${ORG} --token ${REG_TOKEN} --name ${RUNNER_NAME}

cleanup() {
  echo "Removing runner..."
  ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!
