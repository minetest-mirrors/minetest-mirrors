#!/bin/sh

git clone $1 gh_repo
cd gh_repo
git pull $2 $3
git push origin $3
