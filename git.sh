#!/usr/bin/env bash

set -euo pipefail

git init
git config --local user.name "Randolph Ledesma"
git config --local user.email "randolph@email.com"
git remote add origin git@gitlab.com:randop/machines.git
git push --set-upstream origin master
git remote set-url --add --push origin git@github.com:randop/machines.git
git remote set-url --add --push origin git@github.com:randop/machines.git
git push --set-upstream origin master
