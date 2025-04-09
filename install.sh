#!/bin/sh
set -e
make $@ \
  --directory="$(dirname "$0")" \
  --check-symlink-times \
  --no-print-directory \
  --no-builtin-rules \
  --no-builtin-variables \
  --environment-overrides
