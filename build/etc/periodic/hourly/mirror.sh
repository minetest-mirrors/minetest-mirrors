#!/bin/sh

repos=$(cat /repos.json | jq '.[] | "remote=\(.remote) repo=\(.repo)"')

cat /repos.json | jq -M -r '.[] | .remote, .repo' |\
while read -r remote; read -r repo; do
    echo "Cfg: $remote / $repo"
    # TODO
done