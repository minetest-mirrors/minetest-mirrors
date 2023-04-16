#!/bin/sh
set -e

# fetch access token
ACCESS_TOKEN=$(cat /access_token)

# working dir
cd /git_cache

# read repos.json and parse fields
cat /repos.json | jq -M -r '.[] | .remote, .repo' |\
while read -r remote; read -r repo; do
    echo "Checking repo ${repo} (remote: ${remote})"

    # full github url
    GITHUB_REPO_URL="https://${ACCESS_TOKEN}@github.com/minetest-mirrors/${repo}"

    # initial clone if the .git dir does not exist
    test -d "$repo" || git clone --mirror $remote $repo

    # change to repository directory
    cd ${repo}

    # pull latest changes
    git fetch --prune

    # push changes to mirror repo
    git push --all ${GITHUB_REPO_URL}
    git push --tags ${GITHUB_REPO_URL}

    # change back to base-dir
    cd ..
done