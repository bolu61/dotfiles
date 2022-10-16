#!/bin/sh
set -e
make ${@:-${DOTFILES:-"common"}} \
  --directory="$(dirname $0)" \
  --keep-going \
  --check-symlink-times \
  --no-print-directory \
  --no-builtin-rules \
  --no-builtin-variables \
  --environment-overrides
