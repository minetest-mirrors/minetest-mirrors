#!/bin/sh

git clone https://${access_token}@github.com/minetest-mirrors/${github_repo} gh_repo || exit -1
cd gh_repo
git pull ${source_repo} ${branch} || exit -1
git push origin ${branch} || exit -1
