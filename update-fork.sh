#!/usr/bin/env bash

[ -z "$1" ] && echo "usage: update-fork.sh <upstream-version>" && exit

git pull --autostash git@github.com:terraform-aws-modules/terraform-aws-eks.git v$1 && \
yq e -i ".module_version = \"$1\"" .spacelift/config.yml #&& \
git commit -am "release: version $1 from upstream" && \
git push
