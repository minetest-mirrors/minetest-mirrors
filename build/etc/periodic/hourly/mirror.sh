#!/bin/sh
set -e

# fetch access token
ACCESS_TOKEN=$(cat /access_token)

# working dir
cd /git_cache

# read repos.json and parse fields
cat /repos.json | jq -M -r '.[] | .remote, .repo, .branch' |\
while read -r remote; read -r repo; read -r branch; do
    # default branch: master
    test "$branch" == "null" && branch=master

    echo "Checking repo ${repo} (remote: ${remote}) on branch ${branch}"

    # full github url
    GITHUB_REPO_URL="https://${ACCESS_TOKEN}@github.com/minetest-mirrors/${repo}"

    # initial clone if the .git dir does not exist
    test -d "$repo/.git" || git clone $remote $repo

    # fetch commit-checksums
    LOCAL_SHA=$(git ls-remote "${GITHUB_REPO_URL}" ${branch} | cut -f1)
    REMOTE_SHA=$(git ls-remote "${remote}" ${branch} | head -n1 | cut -f1)

    # abort if no changes found
    test "${LOCAL_SHA}" == "${REMOTE_SHA}" && continue

    echo "Changes found"
    # change to repository directory
    cd ${repo}

    # pull latest changes
    git pull origin ${branch}

    # push changes to mirror repo
    git push ${GITHUB_REPO_URL} ${branch}

    # change back to base-dir
    cd ..
done