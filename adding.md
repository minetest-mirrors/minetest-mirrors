# Adding a mirrored repository

Create an empty repository in the `minetest-mirrors` org with the same name as the source-repo.
For example: `https://github.com/minetest-mirrors/my-repo.git`


Initial clone/push:
```bash
# clone the original repository locally
# (this is only a one-time thing, the script can't yet manage repo initialization)
git clone https://unreliable-hosting.com/my-repo.git

# push it to the mirror org (needs push access obviously, hence the git: url)
git push git@github.com:minetest-mirrors/my-repo.git master
```

Create an entry in the workflow for daily sync (scripts in `.github/workflows`)
```yml
    - name: my-repo
      run: ./mirror.sh
      env:
        source_repo:  https://unreliable-hosting.com/my-repo.git
        github_repo: my-repo.git
        branch: master
        access_token: ${{ secrets.ACCESS_TOKEN }}
```

Done, this should now be updated daily