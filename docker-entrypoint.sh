#!/bin/sh
set -e

chown -R node bower_components node_modules

if [ "$1" = 'grunt' ]; then
  su-exec node npm-cache install --cacheDirectory /var/cache/npm
fi

su-exec node "$@"
