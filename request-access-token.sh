curl --request POST \
--url "https://api.github.com/app/installations/${INSTALLATION_ID}/access_tokens" \
--header "Accept: application/vnd.github+json" \
--header "Authorization: Bearer $(cat jwt)" \
--header "X-GitHub-Api-Version: 2022-11-28"
