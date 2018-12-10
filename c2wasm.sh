#! /usr/bin/env bash

platform=./$(uname -s | tr '[:upper:]' '[:lower:]')

"$platform/dist/bin/clang" \
  --target=wasm32-unknown-unknown-wasm \
  --sysroot="$platform/sysroot" \
  -nostartfiles -Wl,--no-entry,--allow-undefined \
  "$@"

