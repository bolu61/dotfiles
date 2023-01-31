#!/bin/sh
set -e

export DOTFILESMODULES=${@:-$DOTFILESMODULES}


modules=$DOTFILESMODULES make install \
  --directory="$(dirname $0)" \
  --keep-going \
  --check-symlink-times \
  --no-print-directory \
  --no-builtin-rules \
  --no-builtin-variables \
  --environment-overrides
