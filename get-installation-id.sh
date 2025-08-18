curl --request GET \
--url "https://api.github.com/app/installations" \
--header "Accept: application/vnd.github+json" \
--header "Authorization: Bearer $(cat jwt)" \
--header "X-GitHub-Api-Version: 2022-11-28"
