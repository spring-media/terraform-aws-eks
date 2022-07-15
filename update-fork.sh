#!/usr/bin/env bash

[ -z "$1" ] && echo "usage: update-fork.sh <upstream-version>" && exit

git stash
git pull --rebase git@github.com:terraform-aws-modules/terraform-aws-eks.git v$1 && \
git rebase origin/spacelift
git stash apply
git stash drop
yq e -i ".module_version = \"$1\"" .spacelift/config.yml && \
git commit -am "release: version $1 from upstream" && \
git push
