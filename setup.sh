#!/bin/bash

ERX() { >&2 echo  "[ERROR] $*" ; exit 1 ;}

command -v bashbud >/dev/null \
  || ERX "could not find bashbud,"        \
     "installation instructions at:"$'\n' \
     "https://github.com/budlabs/bashbud"

_source=$(readlink -f "${BASH_SOURCE[0]}")
_dir=${_source%/*}

git submodule init
git submodule update \
  || ERX "failed to update submodules"                     \
         "do you have your github credentials setup?"$'\n' \
         "https://docs.github.com/en/enterprise/2.15/user/articles/adding-a-new-ssh-key-to-your-github-account"

for ass in "$_dir/ass"/* ; do
  bashbud --bump "$ass"
done
