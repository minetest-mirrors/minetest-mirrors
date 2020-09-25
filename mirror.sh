#!/bin/bash

# full github url
GITHUB_REPO_URL=https://${access_token}@github.com/minetest-mirrors/${github_repo}

# fetch commit-checksums
LOCAL_SHA=$(git ls-remote "${GITHUB_REPO_URL}" ${branch} | cut -f1)
REMOTE_SHA=$(git ls-remote "${source_repo}" ${branch} | head -n1 | cut -f1)

echo "Local sha: ${LOCAL_SHA} (${github_repo})"
echo "Remote sha: ${REMOTE_SHA} (${source_repo})"

# exit if commits are equal
test "${LOCAL_SHA}" == "${REMOTE_SHA}" && exit 0

echo "Changes detected! Cloning and updating local repo"

# clone, pull and push
rm gh_repo -rf
git clone -b ${branch} ${GITHUB_REPO_URL} gh_repo || exit -1
cd gh_repo
git pull ${source_repo} ${branch} || exit -1
git push origin ${branch} || exit -1
