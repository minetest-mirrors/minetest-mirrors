#!/bin/sh

git clone https://${access_token}@github.com/minetest-mirrors/${github_repo} gh_repo
cd gh_repo
git pull ${source_repo} ${branch}
git push origin ${branch}
