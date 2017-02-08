#!/bin/sh
set -e

chown -R node bower_components node_modules

if [ "$1" = 'grunt' ]; then
  su-exec node npm-cache install | grep "ERROR"
fi

su-exec node "$@"
