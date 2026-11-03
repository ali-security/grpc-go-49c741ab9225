#!/bin/bash

set -e
# Run from this script's directory so the relative paths below resolve no
# matter where the script is invoked from (CI invokes it from the repo root).
cd "$(dirname "$0")"
mkdir -p binaries
# Remove the built binaries afterwards so later CI steps see a clean git tree.
trap 'rm -rf "$PWD/binaries"' EXIT
# interop/xds is a separate Go module, so its binaries must be built from
# inside that module.
(cd ../../../../interop/xds && go build -o ../../xds/internal/test/e2e/binaries/client ./client/)
(cd ../../../../interop/xds && go build -o ../../xds/internal/test/e2e/binaries/server ./server/)
go test -v .
