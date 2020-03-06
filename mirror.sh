#!/bin/bash

# full github url
GITHUB_REPO_URL=https://${access_token}@github.com/minetest-mirrors/${github_repo}

# fetch commit-checksums
LOCAL_SHA=$(git ls-remote ${GITHUB_REPO_URL} | cut -f1)
REMOTE_SHA=$(git ls-remote ${source_repo} | cut -f1)

# exit if commits are equal
test "${LOCAL_SHA}" == "${REMOTE_SHA}" && exit 0

# clone, pull and push
git clone -b ${branch} ${GITHUB_REPO_URL} gh_repo || exit -1
cd gh_repo
git pull ${source_repo} ${branch} || exit -1
git push origin ${branch} || exit -1
