#!/bin/bash

_source=$(readlink -f "${BASH_SOURCE[0]}")
_dir=${_source%/*}

git submodule init
git submodule update

for ass in "$_dir/ass"/* ; do
  bashbud --bump "$ass"
done
