#!/usr/bin/env bash

set -eu -o pipefail

# mongo $MONGODB_URL -eval 'sh.status()'

until mongo $MONGODB_URL -eval 'sh.status()' | grep 'shard0' | grep '"state" : 1' >/dev/null; do
  >&2 echo "Sharded MongoDB is unavailable - sleeping"
  sleep 1
done

# mongo $MONGODB_URL -eval 'sh.status()'

mongo $MONGODB_URL -eval 'sh.enableSharding("test")' >/dev/null

exec "$@"
