#!/usr/bin/env bash

set -eu -o pipefail

bundle

exec ./ensure-sharded.sh "$@"
